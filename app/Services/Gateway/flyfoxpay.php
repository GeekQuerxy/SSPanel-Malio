<?php
namespace App\Services\Gateway;
use App\Services\View;
use App\Services\Auth;
use App\Services\Config;
use App\Models\Paylist;

class Pays
{
    private $pid;
    private $key;

    public function __construct($pid, $key)
    {
        $this->pid = $pid;
        $this->key = $key;
    }

    /**
     * @Note  支付发起
     * @param $type   支付方式
     * @param $out_trade_no     订单号
     * @param $notify_url     异步通知地址
     * @param $return_url     回调通知地址
     * @param $name     商品名称
     * @param $money     金额
     * @param $sitename     站点名称
     * @return string
     */
    public function submit($type, $out_trade_no, $notify_url, $return_url, $name, $money, $sitename)
    {
        $data = [
            'pid' => $this->pid,
            'type' => $type,
            'out_trade_no' => $out_trade_no,
            'notify_url' => $notify_url,
            'return_url' => $return_url,
            'name' => $name,
            'money' => $money,
            'sitename' => $sitename
        ];
        $string = http_build_query($data);
        $sign = $this->getsign($data);
        return 'https://api.jxspay.cn/submit/?' . $string . '&sign=' . $sign . '&sign_type=MD5';
    }

    /**
     * @Note   验证签名
     * @param $data  待验证参数
     * @return bool
     */
    public function verify($data)
    {
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

    /**
     * @Note  生成签名
     * @param $data   参与签名的参数
     * @return string
     */
    private function getSign($data)
    {
        $data = array_filter($data);
        ksort($data);
        $str1 = '';
        foreach ($data as $k => $v) {
            $str1 .= '&' . $k . "=" . $v;
        }
        $str = $str1 . $this->key;
        $str = trim($str, '&');
        $sign = md5($str);
        return $sign;
    }
}
class flyfoxpay extends AbstractPayment
{

    public function purchase($request, $response, $args)
    {
        $type = $request->getParam('type');
        $price = $request->getParam('price');
        if($price <= 0){
            return json_encode(['errcode'=>-1,'errmsg'=>"非法的金额."]);
        }
        $user = Auth::getUser();
        $settings = Config::get("flyfoxpay")['config'];
        $pl = new Paylist();
        $pl->userid = $user->id;
        $pl->total = $price;
        $pl->tradeno = self::generateGuid();
        $pl->save();
		$return='https://'.$_SERVER['HTTP_HOST'].'/flyfoxpay_back/'.$type;
		$pay = new Pays($settings['hid'], $settings['key']);

//支付方式
$type = 'all';

//订单号
$out_trade_no = $pl->tradeno;

//异步通知地址
$notify_url = $return;

//回调通知地址
$return_url = $return;

//商品名称
$name = 'SS商品-'.$_SERVER['HTTP_HOST'];

//支付金额（保留小数点后两位）
$money = $price;

//站点名称
$sitename = $_SERVER['HTTP_HOST'];

//发起支付
$url = $pay->submit($type, $out_trade_no, $notify_url, $return_url, $name, $money, $sitename);
      
		$result = "<script language='javascript' type='text/javascript'>window.location.href='".$url."';</script>";
        $result = json_encode(array('code'=>$url,'errcode'=>0,'pid' =>$pl->id));
        return $result;
    }
    
    public function notify($request, $response, $args)
    {
		$type = $args['type'];
		$settings = Config::get("flyfoxpay")['config'];
        $security['orderid'] = $_REQUEST['out_trade_no'];
      if($security['orderid']=='' OR $security['orderid']==null){header("Location: /user/code");}else{
		  //实例化支付类
$pay = new Pays($settings['hid'], $settings['key']);

//接收异步通知数据
$data = $_GET;

//商户订单号
$out_trade_no = $data['out_trade_no'];

//验证签名
if ($pay->verify($data)) {
    //验证支付状态
    if ($data['trade_status'] == 'TRADE_SUCCESS') {
        $this->postPayment($data['out_trade_no'], "在线支付");
		header("Location: /user/code");
        //这里就可以放心的处理您的业务流程了
        //您可以通过上面的商户订单号进行业务流程处理
    }
} else {
    echo '錯誤';
}
    }}
    public function getPurchaseHTML()
    {
        return '
                    <div class="card-inner">
										<p class="card-heading">充值</p>
										<h5>支付方式:</h5>
										<nav class="tab-nav margin-top-no">
											<ul class="nav nav-list">
											
													<li>
														<a class="waves-attach waves-effect type active" data-toggle="tab" data-pay="wxpay">聚合支付</a>
													</li>
											
											
				
											</ul>
											<div class="tab-nav-indicator"></div>
										</nav>
										<div class="form-group form-group-label">
											<label class="floating-label" for="amount">金额</label>
											<input class="form-control" id="amount" type="text">
										</div>
									</div>
                                    <div class="card-action">
										<div class="card-action-btn pull-left">
											<button class="btn btn-flat waves-attach" id="code-updates" ><span class="icon">check</span>&nbsp;充值</button>
										</div>
									</div>
                        <script>
		var type = "wxpay";
	var pid = 0;
	$(".type").click(function(){
		type = $(this).data("pay");
	});
	$("#code-updates").click(function(){
		var price = parseFloat($("#amount").val());
		console.log("将要使用"+type+"方法充值"+price+"元")
		if(isNaN(price)){
			$("#result").modal();
			$("#msg").html("非法的金额!");
		}
		$.ajax({
			\'url\':"/user/payment/purchase",
			\'data\':{
				\'price\':price,
				\'type\':type,
			},
			\'dataType\':\'json\',
			\'type\':"POST",
			success:function(data){
				console.log(data);
				if(data.errcode==-1){
					$("#result").modal();
					$("#msg").html(data.errmsg);
				}
				if(data.errcode==0){
					pid = data.pid;
					if(type=="wxpay"){
						$("#result").modal();
						$("#msg").html("正在跳转到支付系統..."+data.code);
					}
				}
			}
		});
	});
</script>
';
    }
    public function getReturnHTML($request, $response, $args)
    {

    }
    public function getStatus($request, $response, $args)
    {
        // TODO: Implement getStatus() method.
    }
}