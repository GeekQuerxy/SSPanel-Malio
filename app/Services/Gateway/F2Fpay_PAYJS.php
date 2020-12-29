<?php
/**
 * Created by PhpStorm.
 * User: tonyzou
 * Date: 2018/9/24
 * Time: 下午9:24
 */

namespace App\Services\Gateway;

use App\Services\Auth;
use App\Services\Config;
use App\Models\Paylist;
use App\Services\View;
use Exception;
use Omnipay\Omnipay;

class F2Fpay_PAYJS extends AbstractPayment
{
    // f2fpay
    private function createGateway()
    {
        $gateway = Omnipay::create('Alipay_AopF2F');
        $gateway->setSignType('RSA2'); //RSA/RSA2
        $gateway->setAppId(Config::get('f2fpay_app_id'));
        $gateway->setPrivateKey(Config::get('merchant_private_key')); // 可以是路径，也可以是密钥内容
        $gateway->setAlipayPublicKey(Config::get('alipay_public_key')); // 可以是路径，也可以是密钥内容
        $notifyUrl = Config::get('f2fNotifyUrl') ?? (Config::get('baseUrl') . '/payment/notify');
        $gateway->setNotifyUrl($notifyUrl);
        return $gateway;
    }
    // f2fpay end

    // payjs
    public function __construct()
    {
        $this->appSecret = Config::get('payjs_key');
        $this->gatewayUri = 'https://payjs.cn/api/';
    }
    public function prepareSign($data)
    {
        $data['mchid'] = Config::get('payjs_mchid');
        $data = array_filter($data);
        ksort($data);
        return http_build_query($data);
    }

    public function sign($data)
    {
        return strtoupper(md5(urldecode($data) . '&key=' . $this->appSecret));
    }

    public function verify($data, $signature)
    {
        $mySign = $this->sign($data);
        return $mySign === $signature;
    }

    public function post($data, $type = 'pay')
    {
        if ($type == 'pay') {
            $this->gatewayUri .= 'cashier';
        } elseif ($type == 'refund') {
            $this->gatewayUri .= 'refund';
        } else {
            $this->gatewayUri .= 'check';
        }
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $this->gatewayUri);
        curl_setopt($curl, CURLOPT_HEADER, 0);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_POST, 1);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        $data = curl_exec($curl);
        curl_close($curl);
        return $data;
    }

    public function query($tradeNo)
    {
        $data['payjs_order_id'] = $tradeNo;
        $params = $this->prepareSign($data);
        $data['sign'] = $this->sign($params);
        return json_decode($this->post($data, $type = 'query'), true);
    }

    public function refund($merchantTradeNo)
    {
        $data['payjs_order_id'] = $merchantTradeNo;
        $params = $this->prepareSign($data);
        $data['sign'] = $this->sign($params);
        return $this->post($data, 'refund');
    }
    // payjs end


    public function purchase($request, $response, $args)
    {
        $payment = $request->getParam('payment');
        if ($payment == 'alipay') {
            $amount = $request->getParam('amount');
            $user = Auth::getUser();
            if ($amount == '') {
                $res['ret'] = 0;
                $res['msg'] = '订单金额错误：' . $amount;
                return $response->getBody()->write(json_encode($res));
            }
    
            $pl = new Paylist();
            $pl->userid = $user->id;
            $pl->tradeno = self::generateGuid();
            $pl->total = $amount;
            $pl->save();
    
            $gateway = $this->createGateway();
    
            $request = $gateway->purchase();
            $request->setBizContent([
                'subject' => $pl->tradeno,
                'out_trade_no' => $pl->tradeno,
                'total_amount' => $pl->total
            ]);
    
            /** @var \Omnipay\Alipay\Responses\AopTradePreCreateResponse $response */
            $aliResponse = $request->send();
    
            // 获取收款二维码内容
            $qrCodeContent = $aliResponse->getQrCode();
    
            $return['ret'] = 1;
            $return['qrcode'] = $qrCodeContent;
            $return['amount'] = $pl->total;
            $return['pid'] = $pl->tradeno;
    
            return json_encode($return);

        } else if ($payment == 'wechat') {
            $price = $request->getParam('amount');
            if ($price <= 0) {
                return json_encode(['ret' => -1, 'errmsg' => '非法的金额.']);
            }
            $user = Auth::getUser();
            $pl = new Paylist();
            $pl->userid = $user->id;
            $pl->total = $price;
            $pl->tradeno = self::generateGuid();
            $pl->save();
            $data['mchid'] = Config::get('payjs_mchid');
            $data['out_trade_no'] = $pl->tradeno;
            $data['total_fee'] = (float) $price * 100;
            $data['notify_url'] = Config::get('baseUrl') . '/payment/notify?way=payjs';
            $params = $this->prepareSign($data);
            $data['sign'] = $this->sign($params);
            $url = 'https://payjs.cn/api/cashier?' . http_build_query($data);
            return json_encode(['ret' => 1, 'qrcode' => $url, 'pid' => $data['out_trade_no']]);
        } else {
            $res['ret'] = 0;
            $res['msg'] = 'payment参数缺失';
            return $response->getBody()->write(json_encode($res));
        }

    }

    public function notify($request, $response, $args)
    {
        $way = $_GET['way'];
        if ($way == 'payjs') {
            $data = $_POST;

            if($data['return_code'] == 1){
                // 验证签名
                $in_sign = $data['sign'];
                unset($data['sign']);
                $data = array_filter($data);
                ksort($data);
                $sign = strtoupper(md5(urldecode(http_build_query($data) . '&key=' . $this->appSecret)));
                $resultVerify = $sign ? true : false;
            
                //$str_to_sign = $this->prepareSign($data);
                //$resultVerify = $this->verify($str_to_sign, $request->getParam('sign'));
    
                if ($resultVerify) {
                    // 验重
                    $p = Paylist::where('tradeno', '=', $data['out_trade_no'])->first();
                    $money = $p->total;
                    if ($p->status != 1) {
                        $this->postPayment($data['out_trade_no'], '微信支付');
                        echo 'SUCCESS';
                    } else {
                        echo 'ERROR';
                    }
                } else {
                    echo 'FAIL2';
                }
            } else {
                echo 'FAIL1';
            }
        } else {
            $gateway = $this->createGateway();
            $aliRequest = $gateway->completePurchase();
            $aliRequest->setParams($_POST);
    
            try {
                /** @var \Omnipay\Alipay\Responses\AopCompletePurchaseResponse $response */
                $aliResponse = $aliRequest->send();
                $pid = $aliResponse->data('out_trade_no');
                if ($aliResponse->isPaid()) {
                    $this->postPayment($pid, '支付宝当面付 ' . $pid);
                    die('success'); //The response should be 'success' only
                }
            } catch (Exception $e) {
                die('fail');
            }
        }
    }

    public function getPurchaseHTML()
    {
        return 1;
    }

    public function getStatus($request, $response, $args)
    {
        $p = Paylist::where('tradeno', $_POST['pid'])->first();
        $return['ret'] = 1;
        $return['result'] = $p->status;
        return json_encode($return);
    }

    public function getReturnHTML($request, $response, $args)
    {
        return 0;
    }
}
