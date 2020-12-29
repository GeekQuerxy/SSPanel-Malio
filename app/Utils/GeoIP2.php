<?php

namespace App\Utils;

use GeoIp2\Database\Reader;
use GeoIp2\Exception\AddressNotFoundException;


class GeoIP2
{
    public function __construct()
    {
        $this->reader = new Reader(BASE_PATH . '/storage/GeoLite2-City.mmdb');
    }

    public function getLocation($ip, $lang)
    {
        try {
            $record = $this->reader->city($ip);
        } catch (AddressNotFoundException $e) {
            if ($lang == 'zh-cn') {
                return "未知";
            } else {
                return "Unknow";
            }
        }

        if ($lang == 'zh-cn') {
            $lang = 'zh-CN';
        }

        if ($lang == 'en') {
            return $record->city->name. ', '.$record->country->name;
        } else if ($lang == 'zh-CN') {
            return $record->country->names[$lang]. ' '.$record->city->names[$lang];
        }
    }
}