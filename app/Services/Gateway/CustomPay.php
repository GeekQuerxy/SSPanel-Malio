<?php

namespace App\Services\Gateway;

use App\Services\Auth;
use App\Services\Config;
use App\Models\Paylist;
use App\Services\View;
use App\Services\MalioConfig;

class CustomPay extends AbstractPayment
{
    public function __construct()
    {

    }

    public function purchase($request, $response, $args)
    {
        $price = $request->getParam('price');
        $type = $request->getParam('type');
        $shopid = $request->getParam('shopid');
        $user = Auth::getUser();

        if (!is_numeric($shopid)) {
            return array(
                'ret' => 0,
                'msg' => 'shopid只能是数字'
            );
        }

        if (!is_numeric($price)) {
            return array(
                'ret' => 0,
                'msg' => '金额错误'
            );
        }
        
        // 这里写发起支付请求

        $pl = new Paylist();
        $pl->userid = $user->id;
        $pl->total = $price;
        $pl->tradeno = self::generateGuid();
        $pl->shopid = $shopid;
        $pl->save();

        return array(
            'ret' => 1,
            'url' => 'https://example.alipay.com/pay',
            // url填写为跳转的url
            // 如果是扫码支付的话，要输出这样的格式（其中的type可换为wechat） '/user/qrcode?type=alipay&qrcode=https%3A%2F%2Fexample.alipay.com%2Fpay&tradeno=5BDD1D44Z&price=12.1'
            // 示例代码👇
            // 'url' => '/user/qrcode?type='.$type.'&qrcode='.rawurlencode($qrContent).'&tradeno='.$tradeno.'&price='.$price;
        );
    }

    public function purchase_maliopay($type, $price, $shopid=0)
    {
        $user = Auth::getUser();

        // 这里写发起支付请求

        $pl = new Paylist();
        $pl->userid = $user->id;
        $pl->total = $price;
        $pl->tradeno = self::generateGuid();
        $pl->shopid = $shopid;
        $pl->save();

        if ($type == 'alipay') {
            return array(
                'url' => $pl->tradeno,
                'errcode' => 0,
                'tradeno' => $pl->tradeno
            );
        } else {
            return array(
                'url' => $pl->tradeno,
                'errcode' => 0,
                'tradeno' => $pl->tradeno
            );
        }
    }

    public function notify($request, $response, $args)
    {
        // 处理回调
    }

    public function getPurchaseHTML()
    {
        return 1;
    }

    public function getReturnHTML($request, $response, $args)
    {
        $pid = $_GET['source'];
        $p = Paylist::where('tradeno', '=', $pid)->first();
        $money = $p->total;
        if ($p->status === 1) {
            $success = 1;
        } else {
            $success = 0;
        }
        return View::getSmarty()->assign('money', $money)->assign('success', $success)->fetch('user/pay_success.tpl');
    }

    public function getStatus($request, $response, $args)
    {
        $p = Paylist::where('id', $_POST['pid'])->first();
        $return['ret'] = 1;
        $return['result'] = $p->status;
        return json_encode($return);
    }
}
