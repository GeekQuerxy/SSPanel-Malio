<?php

namespace App\Services\Gateway;

use App\Services\View;
use App\Services\Auth;
use App\Services\Config;
use App\Models\Paylist;
use App\Services\MalioConfig;
use Omnipay\Omnipay;
use Stripe\Stripe;
use Stripe\Charge;

class MalioPay extends AbstractPayment
{
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
            return json_encode(['ret' => 0, 'msg' => 'wrong type']);
        }

        if ($price < MalioConfig::get('mups_minimum_amount')) {
            return json_encode(['ret' => 0, 'errmsg' => '充值最低金额为' . MalioConfig::get('mups_minimum_amount') . '元']);
        }

        if ($price <= 0) {
            return json_encode(['ret' => 0, 'msg' => "金额必须大于0元"]);
        }

        if ($type == 'alipay') {
            $payment_system = MalioConfig::get('mups_alipay');
            switch ($payment_system) {
                case ('bitpayx'):
                    $bitpayx = new BitPayX(Config::get('bitpay_secret'));
                    $result = $bitpayx->purchase_maliopay($type, $price,$shopid);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('tomatopay'):
                    $tomatopay = new TomatoPay();
                    $result = $tomatopay->purchase_maliopay($type, $price);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['code']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('f2fpay'):
                    $f2fpay = new AopF2F();
                    $result = $f2fpay->purchase_maliopay($type, $price,$shopid);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'qrcode',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('stripe'):
                    $stripe = new StripePay();
                    $result = $stripe->purchase_maliopay($type, $price,$shopid);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('wolfpay'):
                    $wolfpay = new Wolfpay();
                    $result = $wolfpay->purchase_maliopay($type, $price,$shopid);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('materialpay'):
                    $materialpay = new MaterialPay(Config::get('materialpay_secret'));
                    $result = $materialpay->purchase_maliopay($type, $price,$shopid);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
            }
        } else if ($type == 'wechat') {
            $payment_system = MalioConfig::get('mups_wechat');
            switch ($payment_system) {
                case ('bitpayx'):
                    $bitpayx = new BitPayX(Config::get('bitpay_secret'));
                    $result = $bitpayx->purchase_maliopay($type, $price,$shopid);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'qrcode',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['qrcode_url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('tomatopay'):
                    $tomatopay = new TomatoPay();
                    $result = $tomatopay->purchase_maliopay($type, $price);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'url',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['code']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('stripe'):
                    $stripe = new StripePay();
                    $result = $stripe->purchase_maliopay($type, $price,$shopid);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'qrcode',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
                case ('materialpay'):
                    $materialpay = new MaterialPay(Config::get('materialpay_secret'));
                    $result = $materialpay->purchase_maliopay($type, $price,$shopid);
                    if ($result['errcode'] == 0) {
                        $return = array(
                            'ret' => 1,
                            'type' => 'qrcode',
                            'tradeno' => $result['tradeno'],
                            'url' => $result['url']
                        );
                    } else {
                        $return = array(
                            'ret' => 0,
                            'msg' => $result['errmsg']
                        );
                    }
                    return json_encode($return);
            }
        }
    }

    public function notify($request, $response, $args)
    {
        $path = $request->getUri()->getPath();
        $path_exploded = explode('/', $path);
        $payment_system = $path_exploded[3];

        switch ($payment_system) {
            case ('bitpayx'):
                $bitpayx = new BitPayX(Config::get('bitpay_secret'));
                if (!Config::get('bitpay_secret') || Config::get('bitpay_secret') === '') {
                    $return = [];
                    $return['status'] = 400;
                    echo json_encode($return);
                    return $return;
                }
                $inputString = file_get_contents('php://input', 'r');
                $inputStripped = str_replace(array("\r", "\n", "\t", "\v"), '', $inputString);
                $inputJSON = json_decode($inputStripped, true); //convert JSON into array
                $data = array();
                if ($inputJSON !== null) {
                    $data['status'] = $inputJSON['status'];
                    $data['order_id'] = $inputJSON['order_id'];
                    $data['merchant_order_id'] = $inputJSON['merchant_order_id'];
                    $data['price_amount'] = $inputJSON['price_amount'];
                    $data['price_currency'] = $inputJSON['price_currency'];
                    $data['created_at_t'] = $inputJSON['created_at_t'];
                }
                $str_to_sign = $bitpayx->prepareSignId($inputJSON['merchant_order_id']);
                $resultVerify = $bitpayx->verify($str_to_sign, $inputJSON['token']);
                $isPaid = $data !== null && $data['status'] !== null && $data['status'] === 'PAID';
                if ($resultVerify && $isPaid) {
                    $bitpayx->postPaymentMaliopay($data['merchant_order_id'], '在线支付 ' . $data['merchant_order_id']);
                    // echo 'SUCCESS';
                    $return = [];
                    $return['status'] = 200;
                    echo json_encode($return);
                } else {
                    // echo 'FAIL';
                    $return = [];
                    $return['status'] = 400;
                    echo json_encode($return);
                }
                return $return;
            case ('tomatopay'):
                $type = 'alipay';
                $settings = Config::get("tomatopay")[$type];
                $order_data = $_REQUEST;
                $transid   = $order_data['trade_no'];       //转账交易号
                $invoiceid = $order_data['out_trade_no'];     //订单号
                $amount    = $order_data['total_fee'];          //获取递过来的总价格
                $status    = $order_data['trade_status'];         //获取传递过来的交易状态
                $signs    = $order_data['sign'];

                if ($request->isGet()) {
                    header("Location: /user/payment/return?tradeno=".$order_data['out_trade_no']);
                    return 0;
                }

                $security  = array();
                $security['out_trade_no']      = $invoiceid;
                $security['total_fee']    = $amount;
                $security['trade_no']        = $transid;
                $security['trade_status']       = $status;
                foreach ($security as $k => $v) {
                    $o .= "$k=" . urlencode($v) . "&";
                }
                $sign = md5(substr($o, 0, -1) . $settings['token']);


                if ($sign == $signs) {
                    //验重
                    $p = Paylist::where('tradeno', '=', $order_data['out_trade_no'])->first();
                    $money = $p->total;
                    if ($p->status != 1) {
                        $this->postPaymentMaliopay($order_data['out_trade_no'], "在线支付");
                        echo 'SUCCESS';
                    } else {
                        echo 'ERROR';
                    }
                    echo 'success';
                } else {
                    echo '验证失败';
                }

                return 'tomatopay';
            case ('f2fpay'):
                $f2fpay = new AopF2F();

                $gateway = Omnipay::create('Alipay_AopF2F');
                $gateway->setSignType('RSA2'); //RSA/RSA2
                $gateway->setAppId(Config::get('f2fpay_app_id'));
                $gateway->setPrivateKey(Config::get('merchant_private_key')); // 可以是路径，也可以是密钥内容
                $gateway->setAlipayPublicKey(Config::get('alipay_public_key')); // 可以是路径，也可以是密钥内容

                $aliRequest = $gateway->completePurchase();
                $aliRequest->setParams($_POST);
        
                $aliResponse = $aliRequest->send();
                $pid = $aliResponse->data('out_trade_no');
                if ($aliResponse->isPaid()) {
                    $this->postPaymentMaliopay($pid, '支付宝');
                    die('success'); //The response should be 'success' only
                }
                return 'f2fpay';
            case ('stripe'):
                Stripe::setApiKey(Config::get('stripe_key'));
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
                                $this->postPaymentMaliopay($source['id'], 'Stripe '.$type);
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
            case ('wolfpay'):
                $type = $args['method'];
                $settings = Config::get("wolfpay") ['config'];
                $security['orderid'] = $_REQUEST['out_trade_no'];
                if ($security['orderid'] == '' OR $security['orderid'] == null) {
                    header("Location: /user/code");
                } else {
                    //实例化支付类
                    //$pay = new Pays($settings['hid'], $settings['key']);
                    $wolfpay = new Wolfpay();
                    //接收异步通知数据
                    $data = $_GET;
                    //商户订单号
                    $out_trade_no = $data['out_trade_no'];
                    //验证签名
                    if ($wolfpay->verify($data)) {
                        //验证支付状态
                        if ($data['trade_status'] == 'TRADE_SUCCESS') {
                            $wolfpay->postPaymentMaliopay($data['out_trade_no'], "在线支付");
                            echo "success";
                            header("Location: /user/code");
                        }
                    } else {
                        echo '錯誤';
                    }
                }
            case ('materialpay'):
                $data = array();
                $data['tradeStatus'] = $request->getParam('tradeStatus');
                $data['payAmount'] = number_format($request->getParam('payAmount'),2);
                $data['tradeNo'] = $request->getParam('tradeNo');
                $data['payType'] = $request->getParam('payType');
                $data['outTradeNo'] = $request->getParam('outTradeNo');

                $pl = Paylist::where('tradeno',$data['outTradeNo'])->first();
                if ($pl->status == 1) {
                    echo 'success';
                    return;
                }

                $materialpay = new MaterialPay(Config::get('materialpay_secret'));
                // 准备待签名数据
                $str_to_sign = $materialpay->prepareSign($data);
                // 验证签名
                $resultVerify = $materialpay->verify($str_to_sign, $request->getParam('sign'));
                if ($resultVerify) {
                    $materialpay->postPaymentMaliopay($data['outTradeNo'], 'MaterialPay - ' . $data['outTradeNo']);
                    echo 'success';
                    return;
                } else {
                    echo 'fail';
                    return;
                }
            default:
                return 'failed';
        }
    }

    public function getPurchaseHTML()
    {
        return 1;
    }

    public function getReturnHTML($request, $response, $args)
    {
        $tradeno = $_GET['tradeno'];
        if ($tradeno == '' || $tradeno == null) {
            $tradeno = $_GET['source'];
        }
        if ($tradeno == '' || $tradeno == null) {
            $tradeno = $_GET['out_trade_no'];
        }
        $p = Paylist::where('tradeno', '=', $tradeno)->first();
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
        $p = Paylist::where('tradeno', $_POST['tradeno'])->first();
        $return['ret'] = 1;
        $return['result'] = $p->status;
        return json_encode($return);
    }
}
