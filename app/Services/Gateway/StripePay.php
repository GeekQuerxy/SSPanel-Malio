<?php

namespace App\Services\Gateway;

use App\Services\Auth;
use App\Services\Config;
use App\Models\Paylist;
use App\Services\View;
use App\Services\MalioConfig;
use Exception;
use Stripe\Stripe;
use Stripe\Charge;
use Stripe\Source;

class StripePay extends AbstractPayment
{
    public function __construct()
    {
        Stripe::setApiKey(Config::get('stripe_key'));
    }

    public function purchase($request, $response, $args)
    {
        $price = $request->getParam('price');
        $type = $request->getParam('type');
        $shopid = $request->getParam('shopid');
        if ($shopid == null) {
            $shopid = 0;
        }
        $user = Auth::getUser();
        if ($type != 'alipay' and $type != 'wechat') {
            return json_encode(['errcode' => -1, 'errmsg' => 'wrong payment.']);
        }
        $stripe_minimum_amount = MalioConfig::get('stripe_minimum_amount');
        if ($price < $stripe_minimum_amount) {
            return json_encode(['errcode' => -1, 'errmsg' => '充值最低金额为'.$stripe_minimum_amount.'元']);
        }

        $ch = curl_init();
        $url = 'https://api.exchangeratesapi.io/latest?symbols=CNY&base='.strtoupper(MalioConfig::get('stripe_currency'));
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        $currency = json_decode(curl_exec($ch));
        curl_close($ch);

        $price_exchanged = ((double)$price) / ($currency->rates->CNY);

        $source = Source::create([
            'amount' => floor($price_exchanged * 100),
            'currency' => MalioConfig::get('stripe_currency'),
            'type' => $type,
            'redirect' => [
                'return_url' => Config::get('baseUrl') . '/user/payment/return',
            ],
        ]);

        $pl = new Paylist();
        $pl->userid = $user->id;
        $pl->total = $price;
        $pl->tradeno = $source['id'];
        if ($shopid != 0) {
            $pl->shopid = $shopid;
        }
        $pl->save();

        if ($type == 'alipay') {
            return json_encode(array('url' => $source['redirect']['url'], 'errcode' => 0, 'pid' => $pl->id, 'tradeno' => $source['id']));
        } else {
            if (MalioConfig::get('payment_v2') == true) {
                return json_encode(array('url' => '/user/qrcode?type=alipay'
                .'&qrcode='.rawurlencode($source['wechat']['qr_code_url'])
                .'&tradeno='.$pl->tradeno
                .'&price='.$price,
                'errcode' => 0, 'pid' => $pl->id, 'tradeno' => $source['id']));
            } else {
                return json_encode(array('url' => $source['wechat']['qr_code_url'], 'errcode' => 0, 'pid' => $pl->id, 'tradeno' => $source['id']));
            }
        }
    }

    public function purchase_maliopay($type, $price, $shopid=0)
    {
        $user = Auth::getUser();
        if ($type != 'alipay' and $type != 'wechat') {
            return json_encode(['errcode' => -1, 'errmsg' => 'wrong payment.']);
        }
        $stripe_minimum_amount = MalioConfig::get('stripe_minimum_amount');
        if ($price < $stripe_minimum_amount) {
            return json_encode(['errcode' => -1, 'errmsg' => '充值最低金额为'.$stripe_minimum_amount.'元']);
        }

        $ch = curl_init();
        $url = 'https://api.exchangeratesapi.io/latest?symbols=CNY&base='.strtoupper(MalioConfig::get('stripe_currency'));
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        $currency = json_decode(curl_exec($ch));
        curl_close($ch);

        $price_exchanged = ((double)$price) / ($currency->rates->CNY);

        $source = Source::create([
            'amount' => floor($price_exchanged * 100),
            'currency' => MalioConfig::get('stripe_currency'),
            'type' => $type,
            'redirect' => [
                'return_url' => Config::get('baseUrl') . '/user/payment/return',
            ],
        ]);

        $pl = new Paylist();
        $pl->userid = $user->id;
        $pl->total = $price;
        $pl->tradeno = $source['id'];
        if ($shopid != 0) {
            $pl->shopid = $shopid;
        }
        $pl->save();

        if ($type == 'alipay') {
            return array(
                'url' => $source['redirect']['url'],
                'errcode' => 0,
                'tradeno' => $pl->tradeno
            );
        } else {
            return array(
                'url' => $source['wechat']['qr_code_url'],
                'errcode' => 0,
                'tradeno' => $pl->tradeno
            );
        }
    }

    public function notify($request, $response, $args)
    {
        $endpoint_secret = Config::get('stripe_webhook_endpoint_secret');
        $payload = @file_get_contents('php://input');
        $sig_header = $_SERVER['HTTP_STRIPE_SIGNATURE'];
        $event = null;

        try {
            $event = \Stripe\Webhook::constructEvent(
                $payload,
                $sig_header,
                $endpoint_secret
            );
        } catch (\UnexpectedValueException $e) {
            http_response_code(400);
            exit();
        } catch (\Stripe\Error\SignatureVerification $e) {
            http_response_code(400);
            exit();
        }

        switch ($event->type) {
            case 'source.chargeable':
                $source = $event->data->object;
                $charge = Charge::create([
                    'amount' => $source['amount'],
                    'currency' => $source['currency'],
                    'source' => $source['id'],
                  ]);
                if ($charge['status'] == 'succeeded') {
                    $type = null;
                    if ($source['type'] == 'alipay') {
                        $type = '支付宝支付'; 
                    } else if ($source['type'] == 'wechat') {
                        $type = '微信支付';
                    }
                    $order = Paylist::where('tradeno', '=', $source['id'])->first();
                    if ($order->status != 1) {
                        $this->postPayment($source['id'], 'Stripe '.$type);
                        echo 'SUCCESS';
                    } else {
                        echo 'ERROR';
                    }
                }
                break;
            default:
                http_response_code(400);
                exit();
        }

        http_response_code(200);
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
