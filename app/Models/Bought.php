<?php

namespace App\Models;

class Bought extends Model
{
    protected $connection = 'default';
    protected $table = 'bought';

    public function renew_date()
    {
        return date('Y-m-d H:i:s', $this->attributes['renew']);
    }

    public function datetime()
    {
        return date('Y-m-d H:i:s', $this->attributes['datetime']);
    }

    public function user()
    {
        $user = User::where('id', $this->attributes['userid'])->first();
        if ($user == null) {
            self::where('id', '=', $this->attributes['id'])->delete();
            return null;
        }

        return $user;
    }

    public function shop()
    {
        return Shop::where('id', $this->attributes['shopid'])->first();
    }

    /*
     * 套餐已使用的天数
     *
     */
    public function used_days()
    {
        return (int) ((strtotime(date('Y-m-d')) - $this->datetime) / 86400);
    }

    /*
     * 是否有效期内
     *
     */
    public function valid()
    {
        $shop = $this->shop();
        if ($this->use_loop()) {
            return (time() - $shop->reset_exp() * 86400 < $this->datetime);
        }
        return false;
    }

    /*
     * 是否周期性商品
     *
     */
    public function use_loop()
    {
        $shop = $this->shop();
        return ($shop->reset() != 0 && $shop->reset_value() != 0 && $shop->reset_exp() != 0);
    }

    /*
     * 下一次流量重置时间
     *
     */
    public function reset_time($unix = false)
    {
        $shop = $this->shop();
        if ($this->use_loop()) {
            $day = $shop->reset() - ($this->used_days() % $shop->reset());
            $time = time() + ($day * 86400);
            return ($unix == false ? date('Y-m-d', $time) : $time);
        }
        return ($unix == false ? '-' : 0);
    }

    /*
     * 过期时间
     *
     */
    public function exp_time($unix = false)
    {
        $shop = $this->shop();
        if ($this->use_loop()) {
            $time = $this->datetime + ($shop->reset_exp() * 86400);
            return ($unix == false ? date('Y-m-d H:i:s', $time) : $time);
        }
        return ($unix == false ? '-' : 0);
    }
}
