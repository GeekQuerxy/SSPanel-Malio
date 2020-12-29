<?php

namespace App\Services;

class MalioConfig
{
    public static function get($key)
    {
        global $Malio_Config;
        return $Malio_Config[$key];
    }

    public static function getPublicConfig()
    {
        global $Malio_Config;
        return $Malio_Config;
    }
}
