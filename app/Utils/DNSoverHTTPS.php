<?php
/**
 * Created by PhpStorm.
 * User: rico93
 * Date: 2019/1/26
 * Time: 12:22
 */

namespace App\Utils;

use RemotelyLiving\PHPDNS\Resolvers\GoogleDNS;
class DNSoverHTTPS
{
    public static function gethostbyName($hostname){
        $resolver = new GoogleDNS();
        return $resolver->getARecords($hostname)->pickFirst()->toArray()["IPAddress"];
    }
}
