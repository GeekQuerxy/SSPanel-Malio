<?php
namespace App\Services\Gateway;
use App\Services\View;
use App\Services\Auth;
use App\Services\Config;
use App\Models\Paylist;

class Wolfpay extends AbstractPayment {
    private $pid;
    private $key;
    private $url;
    public function __construct() {
        $config = Config::get("wolfpay") ['config'];
        $this->pid = $config['hid'];
        $this->key = $config['key'];
        $this->url = $config['url'];
    }

    public function purchase($request, $response, $args) {
        return '';
    }

    public function purchase_maliopay($type, $price, $shopid=0) {
        $user = Auth::getUser();
        $settings = Config::get("wolfpay")['config'];
        $pl = new Paylist();
        $pl->userid = $user->id;
        $pl->total = $price;
        $pl->tradeno = self::generateGuid();
        if ($shopid != 0) {
            $pl->shopid = $shopid;
        }
        $pl->save();

        //支付方式
        $type = 'all'; //$type;
        //订单号
        $out_trade_no = $pl->tradeno;
        //异步通知地址
        $notify_url = 'https://' . $_SERVER['HTTP_HOST'] . '/payment/notify/wolfpay/' . $type;
        //回调通知地址
        $return_url = 'https://' . $_SERVER['HTTP_HOST'] . '/user/payment/return';
        //商品名称
        $name = 'SS商品-' . $_SERVER['HTTP_HOST'];
        //支付金额（保留小数点后两位）
        $money = round($price, 2);
        //站点名称
        $sitename = $_SERVER['HTTP_HOST'];
        //发起支付
        $url = $this->submit($type, $out_trade_no, $notify_url, $return_url, $name, $money, $sitename);

        return array(
            'url' => $url,
            'errcode' => 0,
            'tradeno' => $pl->tradeno
        );
    }

    public function notify($request, $response, $args) {
        return '';
    }
    public function getPurchaseHTML() {
        return '';
    }
    public function getReturnHTML($request, $response, $args) {
    }
    public function getStatus($request, $response, $args) {
        // TODO: Implement getStatus() method.
        
    }

    public function verify($data) {
        if (!isset($data['sign']) || !$data['sign']) {
            return false;
        }
        $sign = $data['sign'];
        unset($data['sign']);
        unset($data['sign_type']);
        $sign2 = $this->getSign($data, $this->key);
        if ($sign != $sign2) {
            return false;
        }
        return true;
    }

    public function submit($type, $out_trade_no, $notify_url, $return_url, $name, $money, $sitename) {
        $data = ['pid' => $this->pid, 'type' => $type, 'out_trade_no' => $out_trade_no, 'notify_url' => $notify_url, 'return_url' => $return_url, 'name' => $name, 'money' => $money, 'sitename' => $sitename];
        $string = http_build_query($data);
        $keys = $this->ensy($string, $this->pid);
        $keyss = $this->base64url_encode($this->pid . '-' . $keys);
        $sign = substr($this->ensy($keyss, $this->key) , 0, 15);
        return 'https://' . $this->url . '/submit?skey=' . $keyss . '&sign=' . $sign . '&sign_type=MD5';
    }

    private function getSign($data) {
        $data = array_filter($data);
        ksort($data);
        $str1 = '';
        foreach ($data as $k => $v) {
            $str1.= '&' . $k . "=" . $v;
        }
        $str = $str1 . $this->key;
        $str = trim($str, '&');
        $sign = md5($str);
        return $sign;
    }

    public function ensy($data, $key) {
        $key = md5($key);
        $len = strlen($data);
        $code = '';
        for ($i = 0; $i < ceil($len / 32); $i++) {
            for ($j = 0; $j < 32; $j++) {
                $p = $i * 32 + $j;
                if ($p < $len) {
                    $code.= $data{$p} ^ $key{$j};
                }
            }
        }
        $code = str_replace(array(
            '+',
            '/',
            '='
        ) , array(
            '_',
            '$',
            ''
        ) , base64_encode($code));
        return $code;
    }
    public function base64url_encode($data) {
        return rtrim(strtr(base64_encode($data) , '+/', '-_') , '=');
    }
}
