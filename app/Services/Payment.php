<?php
/**
 * Created by PhpStorm.
 * User: tonyzou
 * Date: 2018/9/24
 * Time: 下午7:07
 */

namespace App\Services;

use App\Services\Gateway\{
    AopF2F, Codepay, DoiAMPay, PaymentWall, ChenPay, SPay, TrimePay, BitPayX, TomatoPay, flyfoxpay, PAYJS, F2Fpay_PAYJS, StripePay, Payssion, YftPay, MalioPay, IDtPay, CustomPay
};

class Payment
{
    public static function getClient()
    {
        $method = Config::get('payment_system');
        switch ($method) {
            case ('codepay'):
                return new Codepay();
            case ('paymentwall'):
                return new PaymentWall();
            case ('spay'):
                return new SPay();
            case ('f2fpay'):
                return new AopF2F();
            case ('chenAlipay'):
                return new ChenPay();
            case ('bitpayx'):
                return new BitPayX(Config::get('bitpay_secret'));
            case("tomatopay"):
                return new TomatoPay();
            case("flyfoxpay"):
                return new flyfoxpay();
            case ('payjs'):
                return new PAYJS(Config::get('payjs_key'));
            case ('f2fpay_payjs'):
                return new F2Fpay_PAYJS();
            case ('stripe'):
                return new StripePay();
            case ('payssion'):
                return new Payssion();
            case ('yftpay'):
                return new YftPay();
            case ('malio'):
                return new MalioPay();
            case ("idtpay"):
                return new IDtPay();
            case ("custompay"):
                return new CustomPay();
            default:
                return null;
        }
    }

    public static function notify($request, $response, $args)
    {
        return self::getClient()->notify($request, $response, $args);
    }

    public static function returnHTML($request, $response, $args)
    {
        return self::getClient()->getReturnHTML($request, $response, $args);
    }

    public static function purchaseHTML()
    {
        if (self::getClient() != null) {
            return self::getClient()->getPurchaseHTML();
        }

        return '';
    }

    public static function getStatus($request, $response, $args)
    {
        return self::getClient()->getStatus($request, $response, $args);
    }

    public static function purchase($request, $response, $args)
    {
        return self::getClient()->purchase($request, $response, $args);
    }
}
