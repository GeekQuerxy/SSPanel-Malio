<?php

namespace App\Services\Gateway;

use App\Services\Auth;
use App\Services\Config;
use App\Models\Paylist;
use App\Services\View;
use App\Services\MalioConfig;
use Exception;
use App\Services\Gateway\PayssionClient;

class Payssion extends AbstractPayment
{
    public function purchase($request, $response, $args)
    {
        $price = $request->getParam('price');
        $type = $request->getParam('type');
        $user = Auth::getUser();
        if ($type != 'alipay' and $type != 'unionpay') {
            return json_encode(['errcode' => -1, 'errmsg' => 'wrong payment.']);
        }

        if ($type == 'alipay') {
            $type = 'alipay_cn';
        } else if ($type == 'unionpay') {
            $type = 'unionpay_cn';
        }

        $pl = new Paylist();
        $pl->userid = $user->id;
        $pl->total = $price;
        $pl->tradeno = self::generateGuid();
        $pl->save();
        
        $payssion = new PayssionClient(Config::get('payssion_api_key'), Config::get('payssion_secret_key'));


		$payssion_response = null;
		try {
            //$type = 'dotpay_pl'; // for test
			$payssion_response = $payssion->create(array(
				'amount' => $price,
				'currency' => 'CNY',
				'pm_id' => $type,
				'description' => 'Shadowsocks Product',
				'order_id' => $pl->tradeno,
				'return_url' => Config::get('baseUrl').'/user/payment/return'   //optional, the return url after payments (for both of paid and non-paid)
			));
		} catch (\Exception $e) {
			$res['ret'] = 0;
            $res['msg'] = "创建订单失败。".$e->getMessage();
            return $response->getBody()->write(json_encode($res));
		}
		if ($payssion->isSuccess()) {
			$todo = $payssion_response['todo'];
			if ($todo) {
				$todo_list = explode('|', $todo);
				if (in_array("redirect", $todo_list)) {
				    $res['ret'] = 1;
                    $res['url'] = $payssion_response['redirect_url'];
                    $res['pid'] = $pl->id;
				    return $response->getBody()->write(json_encode($res));
			    }
			} else {
				//just in case, should not be here
			}
        } else {
            return json_encode($payssion_response);
        }

        $res['ret'] = 0;
        $res['msg'] = "购买失败";
        return $response->getBody()->write(json_encode($res));
    }

    public function notify($request, $response, $args)
    {
        $api_key=Config::get('payssion_api_key');
		$pm_id=$request->getParam('pm_id');	
		$amount=$request->getParam('amount');	
		$currency=$request->getParam('currency');	
		$order_id=$request->getParam('order_id');		
		$secret_key=Config::get('payssion_secret_key');
        $state=$request->getParam('state');
		$msg = implode('|', array($api_key, $pm_id, $amount, $currency,$order_id,$state, $secret_key));
		if($request->getParam('notify_sig')!= md5($msg)){
			return;
		}
		$state_code=3;
		switch ($state) {
			case 'error':
				$state_code=2;
				break;	
			case 'pending':
				$state_code=3;
				break;	
			case 'completed':
				$state_code=4;
				break;	
			case 'paid_partial':
				$state_code=5;
				break;	
			case 'failed':
				$state_code=6;
				break;	
			case 'cancelled':
				$state_code=7;
				break;	
			case 'expired':
				$state_code=8;
				break;	
			case 'refunded':
				$state_code=9;
				break;	
			case 'refund_pending':
				$state_code=10;
				break;	
			case 'refund_failed':
				$state_code=11;
				break;	
			case 'refund_cancelled':
				$state_code=12;
				break;	
			case 'chargeback':
				$state_code=13;
				break;	
			default:
				$state_code=14;
				break;
        }
        
        if ($state_code != 4) {
            return;
        }

        $type = null;
        if ($pm_id == 'alipay_cn') {
            $type = '支付宝支付'; 
        } else if ($pm_id == 'unionpay_cn') {
            $type = '银联支付';
        }
        $order = Paylist::where('tradeno', '=', $order_id)->first();
        if ($order->status != 1) {
            $this->postPayment($order_id, 'Payssion '.$type);
            echo 'SUCCESS';
        } else {
            echo 'ERROR';
        }
    }

    public function getPurchaseHTML()
    {
        return 1;
    }

    public function getReturnHTML($request, $response, $args)
    {
        $pid = $_GET['order_id'];
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
        return;
    }
}
