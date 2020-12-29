<?php

namespace App\Utils\Telegram\Callbacks;

use App\Utils\Telegram\TelegramTools;

class Callback
{
    public static function CallbackQueryMethod($bot, $Callback)
    {
        // 触发用户
        $SendUser = [
            'id'       => $Callback->getFrom()->getId(),
            'name'     => $Callback->getFrom()->getFirstName() . ' ' . $Callback->getFrom()->getLastName(),
            'username' => $Callback->getFrom()->getUsername(),
        ];

        // 触发源消息发送时间
        $MessageSendTime = $Callback->getMessage()->getDate();

        // 消息是否可编辑
        $AllowEditMessage = (time() < $MessageSendTime + 172800
            ? true
            : false);

        $Data = [
            'CallbackData'      => $Callback->getData(),                            // 回调数据
            'ChatID'            => $Callback->getMessage()->getChat()->getId(),     // 消息会话 ID
            'MessageID'         => $Callback->getMessage()->getMessageId(),         // 触发源信息 ID
            'AllowEditMessage'  => $AllowEditMessage,                               // 消息是否可编辑
        ];

        if ($Data['ChatID'] < 0 && $_ENV['telegram_group_quiet'] === true) {
            // 群组中不回应
            return;
        }

        switch (true) {
            case (strpos($Data['CallbackData'], 'user.') === 0):
                // 用户相关
                UserCallback::handler($bot, $Callback, $Data, $SendUser);
                break;
            // case (strpos($Data['CallbackData'], 'admin.') === 0):
            //     // 管理员
            //     break;
            default:
                // 回调数据处理
                self::CallbackDataHandler($bot, $Callback, $Data, $SendUser);
                break;
        }
    }

    public static function getGuestIndexKeyboard()
    {
        $Keyboard = [
            [
                [
                    'text'          => '产品介绍',
                    'callback_data' => 'general.pricing'
                ],
                [
                    'text'          => '服务条款',
                    'callback_data' => 'general.terms'
                ]
            ]
        ];
        $text = '游客您好，以下是 BOT 菜单：' . PHP_EOL . PHP_EOL . '本站用户请前往用户中心进行 Telegram 绑定操作.';
        return [
            'text'     => $text,
            'keyboard' => $Keyboard,
        ];
    }

    /**
     *
     * 回调数据处理
     *
     */
    public static function CallbackDataHandler($bot, $Callback, $Data, $SendUser)
    {
        $CallbackDataExplode = explode('|', $Data['CallbackData']);
        switch ($CallbackDataExplode[0]) {
            case 'general.pricing':
                // 产品介绍
                $sendMessage = [
                    'text'                      => $_ENV['telegram_general_pricing'],
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => self::getGuestIndexKeyboard()['keyboard']
                        ]
                    ),
                ];
                break;
            case 'general.terms':
                // 服务条款
                $sendMessage = [
                    'text'                      => $_ENV['telegram_general_terms'],
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => self::getGuestIndexKeyboard()['keyboard']
                        ]
                    ),
                ];
                break;
            default:
                // 主菜单
                $temp = self::getGuestIndexKeyboard();
                $sendMessage = [
                    'text'                      => $temp['text'],
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => $temp['keyboard']
                        ]
                    ),
                ];
                break;
        }
        $sendMessage = array_merge(
            $sendMessage,
            [
                'chat_id'       => $Data['ChatID'],
                'message_id'    => $Data['MessageID'],
                'parse_mode'    => 'HTML',
            ]
        );
        return ($Data['AllowEditMessage']
            ? TelegramTools::SendPost('editMessageText', $sendMessage)
            : $bot->sendMessage($sendMessage));
    }
}
