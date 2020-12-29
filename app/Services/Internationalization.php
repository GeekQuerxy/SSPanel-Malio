<?php

namespace App\Services;

use App\Utils\Cookie;

class Internationalization
{
    public function __construct()
    {
        $this->lang = MalioConfig::get('default_lang');
    }

    public function detectLang($request, $response, $args)
    {
        $user = Auth::getUser();
        if ($user->isLogin == true && $user->lang != null) {
            $lang = $user->lang;
        } else {
            $cookie = Cookie::get('lang');
            if ($cookie != null || $cookie != '') {
                $lang =  $cookie;
            } else {
                $accept_language = $request->getHeader('Accept-Language');
                $accept_language = strtolower($accept_language[0]);
                $accept_language = explode(";",$accept_language)[0];
                $accept_language = explode(",",$accept_language)[0];
                if (strpos($accept_language, 'zh') !== false) {
                    if (strpos($accept_language, 'cn') !== false || strpos($accept_language, 'sg') !== false) {
                        $lang = 'zh-cn';
                    } elseif (strpos($accept_language, 'tw') !== false || strpos($accept_language, 'hk') !== false) {
                        $lang = 'zh-cn';
                    } else {
                        $lang = 'zh-cn';
                    }
                } else if (strpos($accept_language, 'en') !== false) {
                    $lang = 'en';
                }

                if ($lang == null) {
                    $lang = MalioConfig::get('default_lang');
                }

                Cookie::set([
                    'lang' => $lang
                ],'1775445251');
            }
        }

        $this->lang = $lang;
        return $lang;
    }

    public function get($name, $args=null) {
        global $I18N;
        if ($args == null){
            return $I18N[$name][$this->lang];
        } else {
            $counter = 1;
            $text = $I18N[$name][$this->lang];
            foreach ($args as $arg) {
                $text = str_replace("$".$counter, $arg, $text);
                $counter += 1;
            }
            return $text;
        }
    }

    public static function getPublicConfig()
    {
        global $I18N;
        return $I18N;
    }
}