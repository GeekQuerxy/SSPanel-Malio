<?php

namespace App\Utils;

use App\Services\Config;
use Exception;
use TelegramBot\Api\BotApi;
use Telegram\Bot\Api;

class Telegram
{

    /**
     * 发送消息
     */
    public static function Send($messageText)
    {
        if (Config::get('enable_telegram') == true) {
            // $bot = new BotApi(Config::get('telegram_token'));
            // try {
            //     $bot->sendMessage(Config::get('telegram_chatid'), $messageText);
            // } catch (Exception $e) {
            //     echo $e->getMessage();
            // }

            $bot = new Api(Config::get('telegram_token'));
            $sendMessage = [
                'chat_id'                   => Config::get('telegram_chatid'),
                'text'                      => $messageText,
                'parse_mode'                => '',
                'disable_web_page_preview'  => false,
                'reply_to_message_id'       => null,
                'reply_markup'              => null
            ];
            try {
                $bot->sendMessage($sendMessage);
            } catch (Exception $e) {
                echo $e->getMessage();
            }
        }
    }

    public static function SendMarkdown($messageText)
    {
        if (Config::get('enable_telegram') == true) {
            // $bot = new BotApi(Config::get('telegram_token'));
            // try {
            //     $bot->sendMessage(Config::get('telegram_chatid'), $messageText, 'Markdown');
            // } catch (Exception $e) {
            //     echo $e->getMessage();
            // }

            $bot = new Api(Config::get('telegram_token'));
            $sendMessage = [
                'chat_id'                   => Config::get('telegram_chatid'),
                'text'                      => $messageText,
                'parse_mode'                => 'Markdown',
                'disable_web_page_preview'  => false,
                'reply_to_message_id'       => null,
                'reply_markup'              => null
            ];
            try {
                $bot->sendMessage($sendMessage);
            } catch (Exception $e) {
                echo $e->getMessage();
            }
        }
    }
}
