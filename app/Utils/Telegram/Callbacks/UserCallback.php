<?php

namespace App\Utils\Telegram\Callbacks;

use App\Controllers\LinkController;
use App\Models\{LoginIp, Node, Ip, InviteCode, Payback, UserSubscribeLog};
use App\Services\Config;
use App\Utils\{Tools, QQWry};
use App\Utils\Telegram\{Reply, TelegramTools};

class UserCallback
{
    public static function getUserIndexKeyboard($user)
    {
        $checkin = (!$user->isAbleToCheckin() ? '已签到' : '签到');
        $Keyboard = [
            [
                [
                    'text'          => '用户中心',
                    'callback_data' => 'user.center'
                ],
                [
                    'text'          => '资料编辑',
                    'callback_data' => 'user.edit'
                ],
            ],
            [
                [
                    'text'          => '订阅中心',
                    'callback_data' => 'user.subscribe'
                ],
                [
                    'text'          => '分享计划',
                    'callback_data' => 'user.invite'
                ],
            ],
            [
                [
                    'text'          => $checkin,
                    'callback_data' => 'user.checkin.' . $user->telegram_id
                ],
            ],
        ];
        $text = Reply::getUserTitle($user);
        $text .= PHP_EOL . PHP_EOL;
        $text .= Reply::getUserInfo($user);
        $text .= PHP_EOL;
        $text .= '流量重置时间：' . $user->valid_use_loop();
        if ($_ENV['show_group_link'] === true) {
            $Keyboard[] = [
                [
                    'text'  => '加入用户群',
                    'url'   => $_ENV['telegram_group_link']
                ],
            ];
        }
        return [
            'text'     => $text,
            'keyboard' => $Keyboard,
        ];
    }

    /**
     *
     * 用户相关回调数据处理
     *
     */
    public static function handler($bot, $Callback, $Data, $SendUser)
    {
        $user = TelegramTools::getUser($SendUser['id']);
        if ($user == null) {
            if ($Data['ChatID'] < 0) {
                return TelegramTools::SendPost(
                    'answerCallbackQuery',
                    [
                        'callback_query_id' => $Callback->getId(),
                        'text'              => '您好，您尚未绑定账户，无法进行操作.',
                        'show_alert'        => true,
                    ]
                );
            } else {
                return Callback::CallbackDataHandler($bot, $Callback, $Data, $SendUser);
            }
        }
        $CallbackDataExplode = explode('|', $Data['CallbackData']);
        $Operate = explode('.', $CallbackDataExplode[0]);
        $op_1 = $Operate[1];
        switch ($op_1) {
            case 'edit':
                // 资料编辑
                self::UserEdit($user, $bot, $Callback, $Data, $SendUser);
                break;
            case 'subscribe':
                // 订阅中心
                self::UserSubscribe($user, $bot, $Callback, $Data, $SendUser);
                break;
            case 'invite':
                // 分享计划
                self::UserInvite($user, $bot, $Callback, $Data, $SendUser);
                break;
            case 'checkin':
                // 签到
                if ($Operate[2] != $SendUser['id']) {
                    return TelegramTools::SendPost(
                        'answerCallbackQuery',
                        [
                            'callback_query_id' => $Callback->getId(),
                            'text'              => '您好，您无法操作他人的账户.',
                            'show_alert'        => true,
                        ]
                    );
                }
                self::UserCheckin($user, $bot, $Callback, $Data, $SendUser);
                break;
            case 'center':
                // 用户中心
                self::UserCenter($user, $bot, $Callback, $Data, $SendUser);
                break;
            default:
                // 用户首页
                $temp = self::getUserIndexKeyboard($user);
                $sendMessage = [
                    'text'                      => $temp['text'],
                    'chat_id'                   => $Data['ChatID'],
                    'message_id'                => $Data['MessageID'],
                    'parse_mode'                => 'HTML',
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => $temp['keyboard']
                        ]
                    ),
                ];
                return ($Data['AllowEditMessage']
                    ? TelegramTools::SendPost('editMessageText', $sendMessage)
                    : $bot->sendMessage($sendMessage));
        }
    }

    public static function getUserCenterKeyboard($user)
    {
        $text = Reply::getUserTitle($user);
        $text .= PHP_EOL . PHP_EOL;
        $text .= Reply::getUserTrafficInfo($user);
        $keyboard = [
            [
                [
                    'text'          => '登录记录',
                    'callback_data' => 'user.center.login_log'
                ],
                [
                    'text'          => '使用记录',
                    'callback_data' => 'user.center.usage_log'
                ],
            ],
            [
                [
                    'text'          => '返利记录',
                    'callback_data' => 'user.center.rebate_log'
                ],
                [
                    'text'          => '订阅记录',
                    'callback_data' => 'user.center.subscribe_log'
                ],
            ],
            [
                [
                    'text'          => '回主菜单',
                    'callback_data' => 'user.index'
                ]
            ],
        ];
        return [
            'text'      => $text,
            'keyboard'  => $keyboard,
        ];
    }

    /**
     *
     * 用户中心
     *
     */
    public static function UserCenter($user, $bot, $Callback, $Data, $SendUser)
    {
        $back = [
            [
                [
                    'text'          => '回主菜单',
                    'callback_data' => 'user.index'
                ],
                [
                    'text'          => '回上一页',
                    'callback_data' => 'user.center'
                ]
            ]
        ];
        $CallbackDataExplode = explode('|', $Data['CallbackData']);
        $Operate = explode('.', $CallbackDataExplode[0]);
        $op_2 = $Operate[2];
        switch ($op_2) {
            case 'login_log':
                // 登录记录
                $iplocation = new QQWry();
                $totallogin = LoginIp::where('userid', '=', $user->id)->where('type', '=', 0)->orderBy('datetime', 'desc')->take(10)->get();
                $userloginip = [];
                foreach ($totallogin as $single) {
                    $location = $iplocation->getlocation($single->ip);
                    $loginiplocation = iconv('gbk', 'utf-8//IGNORE', $location['country'] . $location['area']);
                    if (!in_array($loginiplocation, $userloginip)) {
                        $userloginip[] = $loginiplocation;
                    }
                }
                $text = ('<strong>以下是您最近 10 次的登录位置：</strong>' .
                    PHP_EOL .
                    PHP_EOL .
                    implode('、', $userloginip));
                $sendMessage = [
                    'text'                      => $text,
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => $back
                        ]
                    ),
                ];
                break;
            case 'usage_log':
                // 使用记录
                $iplocation = new QQWry();
                $total = Ip::where('datetime', '>=', time() - 300)->where('userid', '=', $user->id)->get();
                $userip = [];
                foreach ($total as $single) {
                    $single->ip = Tools::getRealIp($single->ip);
                    $is_node = Node::where('node_ip', $single->ip)->first();
                    if ($is_node) {
                        continue;
                    }
                    $location = $iplocation->getlocation($single->ip);
                    $userip[$single->ip] = '[' . $single->ip . '] ' . iconv('gbk', 'utf-8//IGNORE', $location['country'] . $location['area']);
                }
                $text = ('<strong>以下是您最近 5 分钟的使用 IP：</strong>' .
                    PHP_EOL .
                    PHP_EOL .
                    implode(PHP_EOL, $userip));
                $sendMessage = [
                    'text'                      => $text,
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => $back
                        ]
                    ),
                ];
                break;
            case 'rebate_log':
                // 返利记录
                $paybacks = Payback::where('ref_by', $user->id)->orderBy('datetime', 'desc')->take(10)->get();
                $temp = [];
                foreach ($paybacks as $payback) {
                    $temp[] = '<code>#' . $payback->id . '：' . ($payback->user() != null ? $payback->user()->user_name : '已注销') . '：' . $payback->ref_get . ' 元</code>';
                }
                $text = ('<strong>以下是您最近 10 条返利记录：</strong>' .
                    PHP_EOL .
                    PHP_EOL .
                    implode(PHP_EOL, $temp));
                $sendMessage = [
                    'text'                      => $text,
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => $back
                        ]
                    ),
                ];
                break;
            case 'subscribe_log':
                // 订阅记录
                $iplocation = new QQWry();
                $logs = UserSubscribeLog::orderBy('id', 'desc')->where('user_id', $user->id)->take(10)->get();
                $temp = [];
                foreach ($logs as $log) {
                    $location = $iplocation->getlocation($log->request_ip);
                    $temp[] = '<code>' . $log->request_time . ' 在 [' . $log->request_ip . '] ' . iconv('gbk', 'utf-8//IGNORE', $location['country'] . $location['area']) . ' 访问了 ' . $log->subscribe_type . ' 订阅</code>';
                }
                $text = ('<strong>以下是您最近 10 条订阅记录：</strong>' .
                    PHP_EOL .
                    PHP_EOL .
                    implode(PHP_EOL . PHP_EOL, $temp));
                $sendMessage = [
                    'text'                      => $text,
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => $back
                        ]
                    ),
                ];
                break;
            default:
                $temp = self::getUserCenterKeyboard($user);
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
            [
                'chat_id'       => $Data['ChatID'],
                'message_id'    => $Data['MessageID'],
                'parse_mode'    => 'HTML',
            ],
            $sendMessage
        );
        return ($Data['AllowEditMessage']
            ? TelegramTools::SendPost('editMessageText', $sendMessage)
            : $bot->sendMessage($sendMessage));
    }

    public static function getUserEditKeyboard($user)
    {
        $text = Reply::getUserTitle($user);
        $keyboard = [
            [
                [
                    'text'          => '重置订阅链接',
                    'callback_data' => 'user.edit.update_link'
                ],
                [
                    'text'          => '重置链接密码',
                    'callback_data' => 'user.edit.update_passwd'
                ]
            ],
            [
                [
                    'text'          => '更改加密方式',
                    'callback_data' => 'user.edit.encrypt'
                ],
                [
                    'text'          => '更改协议类型',
                    'callback_data' => 'user.edit.protocol'
                ]
            ],
            [
                [
                    'text'          => '更改混淆类型',
                    'callback_data' => 'user.edit.obfs'
                ],
                [
                    'text'          => '每日邮件接收',
                    'callback_data' => 'user.edit.sendemail'
                ],
            ],
            [
                [
                    'text'          => '账户解绑',
                    'callback_data' => 'user.edit.unbind'
                ],
                [
                    'text'          => '群组解封',
                    'callback_data' => 'user.edit.unban'
                ],
            ],
            [
                [
                    'text'          => '回主菜单',
                    'callback_data' => 'user.index'
                ]
            ]
        ];
        return [
            'text'      => $text,
            'keyboard'  => $keyboard,
        ];
    }

    /**
     *
     * 用户编辑
     *
     */
    public static function UserEdit($user, $bot, $Callback, $Data, $SendUser)
    {
        if ($Data['ChatID'] < 0) {
            return TelegramTools::SendPost(
                'answerCallbackQuery',
                [
                    'callback_query_id' => $Callback->getId(),
                    'text'              => '无法在群组中进行该操作.',
                    'show_alert'        => true,
                ]
            );
        }
        $back = [
            [
                [
                    'text'          => '回主菜单',
                    'callback_data' => 'user.index'
                ],
                [
                    'text'          => '回上一页',
                    'callback_data' => 'user.edit'
                ]
            ]
        ];
        $CallbackDataExplode = explode('|', $Data['CallbackData']);
        $Operate = explode('.', $CallbackDataExplode[0]);
        $op_2 = $Operate[2];
        switch ($op_2) {
            case 'update_link':
                // 重置订阅链接
                $user->clean_link();
                TelegramTools::SendPost(
                    'answerCallbackQuery',
                    [
                        'callback_query_id' => $Callback->getId(),
                        'text'              => '订阅链接重置成功，请在下方重新更新订阅.',
                        'show_alert'        => true,
                    ]
                );
                $temp = self::getUserSubscribeKeyboard($user);
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
            case 'update_passwd':
                // 重置链接密码
                $user->passwd = Tools::genRandomChar(8);
                if ($user->save()) {
                    $answerCallbackQuery = '连接密码更新成功，请在下方重新更新订阅.';
                    $temp = self::getUserSubscribeKeyboard($user);
                } else {
                    $answerCallbackQuery = '出现错误，连接密码更新失败，请联系管理员.';
                    $temp = self::getUserEditKeyboard($user);
                }
                TelegramTools::SendPost(
                    'answerCallbackQuery',
                    [
                        'callback_query_id' => $Callback->getId(),
                        'text'              => $answerCallbackQuery,
                        'show_alert'        => true,
                    ]
                );
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
            case 'encrypt':
                // 加密方式更改
                $keyboard = $back;
                if ($_ENV['protocol_specify'] === true) {
                    if (isset($CallbackDataExplode[1])) {
                        if (in_array($CallbackDataExplode[1], Config::getSupportParam('method')) && $_ENV['protocol_specify'] === true) {
                            $temp = $user->setMethod($CallbackDataExplode[1]);
                            if ($temp['ok'] === true) {
                                $text = '您当前的加密方式为：' . $user->method . PHP_EOL . PHP_EOL . $temp['msg'];
                            } else {
                                $text = '发生错误，请重新选择.' . PHP_EOL . PHP_EOL . $temp['msg'];
                            }
                        } else {
                            $text = '发生错误，请重新选择.';
                        }
                    } else {
                        $Encrypts = [];
                        foreach (Config::getSupportParam('method') as $value) {
                            $Encrypts[] = [
                                'text'          => $value,
                                'callback_data' => 'user.edit.encrypt|' . $value
                            ];
                        }
                        $Encrypts = array_chunk($Encrypts, 2);
                        $keyboard = [];
                        foreach ($Encrypts as $Encrypt) {
                            $keyboard[] = $Encrypt;
                        }
                        $keyboard[] = $back[0];
                        $text = '您当前的加密方式为：' . $user->method;
                    }
                } else {
                    $text = '当前不允许私自更改.';
                }
                $sendMessage = [
                    'text'                      => $text,
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => $keyboard
                        ]
                    ),
                ];
                break;
            case 'protocol':
                // 协议更改
                $keyboard = $back;
                if ($_ENV['protocol_specify'] === true) {
                    if (isset($CallbackDataExplode[1])) {
                        if (in_array($CallbackDataExplode[1], Config::getSupportParam('protocol')) && $_ENV['protocol_specify'] === true) {
                            $temp = $user->setProtocol($CallbackDataExplode[1]);
                            if ($temp['ok'] === true) {
                                $text = '您当前的协议为：' . $user->protocol . PHP_EOL . PHP_EOL . $temp['msg'];
                            } else {
                                $text = '发生错误，请重新选择.' . PHP_EOL . PHP_EOL . $temp['msg'];
                            }
                        } else {
                            $text = '发生错误，请重新选择.';
                        }
                    } else {
                        $Protocols = [];
                        foreach (Config::getSupportParam('protocol') as $value) {
                            $Protocols[] = [
                                'text'          => $value,
                                'callback_data' => 'user.edit.protocol|' . $value
                            ];
                        }
                        $Protocols = array_chunk($Protocols, 1);
                        $keyboard = [];
                        foreach ($Protocols as $Protocol) {
                            $keyboard[] = $Protocol;
                        }
                        $keyboard[] = $back[0];
                        $text = '您当前的协议为：' . $user->protocol;
                    }
                } else {
                    $text = '当前不允许私自更改.';
                }
                $sendMessage = [
                    'text'                      => $text,
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => $keyboard
                        ]
                    ),
                ];
                break;
            case 'obfs':
                // 混淆更改
                $keyboard = $back;
                if ($_ENV['protocol_specify'] === true) {
                    if (isset($CallbackDataExplode[1])) {
                        if (in_array($CallbackDataExplode[1], Config::getSupportParam('obfs')) && $_ENV['protocol_specify'] === true) {
                            $temp = $user->setObfs($CallbackDataExplode[1]);
                            if ($temp['ok'] === true) {
                                $text = '您当前的协议为：' . $user->obfs . PHP_EOL . PHP_EOL . $temp['msg'];
                            } else {
                                $text = '发生错误，请重新选择.' . PHP_EOL . PHP_EOL . $temp['msg'];
                            }
                        } else {
                            $text = '发生错误，请重新选择.';
                        }
                    } else {
                        $Obfss = [];
                        foreach (Config::getSupportParam('obfs') as $value) {
                            $Obfss[] = [
                                'text'          => $value,
                                'callback_data' => 'user.edit.obfs|' . $value
                            ];
                        }
                        $Obfss = array_chunk($Obfss, 1);
                        $keyboard = [];
                        foreach ($Obfss as $Obfs) {
                            $keyboard[] = $Obfs;
                        }
                        $keyboard[] = $back[0];
                        $text = '您当前的协议为：' . $user->obfs;
                    }
                } else {
                    $text = '当前不允许私自更改.';
                }
                $sendMessage = [
                    'text'                      => $text,
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => $keyboard
                        ]
                    ),
                ];
                break;
            case 'sendemail':
                // 每日邮件设置更改
                $keyboard = [
                    [
                        [
                            'text'          => '更改开启/关闭',
                            'callback_data' => 'user.edit.sendemail.update'
                        ]
                    ],
                    $back[0]
                ];
                $op_3 = $Operate[3];
                switch ($op_3) {
                    case 'update':
                        $user->sendDailyMail = ($user->sendDailyMail == 0 ? 1 : 0);
                        if ($user->save()) {
                            $text = '设置更改成功，每日邮件接收当前设置为：';
                            $text .= '<strong>';
                            $text .= ($user->sendDailyMail == 0 ? '不发送' : '发送');
                            $text .= '</strong>';
                        } else {
                            $text = '发生错误.';
                        }
                        break;
                    default:
                        $text = '每日邮件接收当前设置为：';
                        $text .= '<strong>';
                        $text .= ($user->sendDailyMail == 0 ? '不发送' : '发送');
                        $text .= '</strong>';
                        break;
                }
                $sendMessage = [
                    'text'                      => $text,
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => $keyboard
                        ]
                    ),
                ];
                break;
            case 'unbind':
                // Telegram 账户解绑
                $Data['AllowEditMessage'] = false;
                $text = '发送 **/unbind 账户邮箱** 进行解绑.';
                if ($_ENV['unbind_kick_member'] === true) {
                    $text .= PHP_EOL . PHP_EOL . '根据管理员的设定，您解绑账户将会被自动移出用户群.'; 
                }
                $sendMessage = [
                    'text'                      => $text,
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'parse_mode'                => 'Markdown',
                    'reply_markup'              => null
                ];
                break;
            case 'unban':
                // 群组解封
                if (isset($Operate[3]) && $Operate[3] == 'update') {
                    TelegramTools::SendPost(
                        'unbanChatMember',
                        [
                            'chat_id'   => $_ENV['telegram_chatid'],
                            'user_id'   => $SendUser['id'],
                        ]
                    );
                    TelegramTools::SendPost(
                        'answerCallbackQuery',
                        [
                            'callback_query_id' => $Callback->getId(),
                            'text'              => '已提交解封，如您仍无法加入群组，请联系管理员.',
                            'show_alert'        => true,
                        ]
                    );
                }
                $sendMessage = [
                    'text'                      => '如果您已经身处用户群，请勿随意点击解封，否则会导致您被移除出群组.',
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => json_encode(
                        [
                            'inline_keyboard' => [
                                [
                                    [
                                        'text'          => '点击提交解封',
                                        'callback_data' => 'user.edit.unban.update'
                                    ]
                                ],
                                $back[0]
                            ]
                        ]
                    ),
                ];
                break;
            default:
                $temp = self::getUserEditKeyboard($user);
                $text = '您可在此编辑您的资料或连接信息：' . PHP_EOL . PHP_EOL;
                $text .= '端口：' . $user->port . PHP_EOL;
                $text .= '密码：' . $user->passwd . PHP_EOL;
                $text .= '加密：' . $user->method . PHP_EOL;
                $text .= '协议：' . $user->protocol . PHP_EOL;
                $text .= '混淆：' . $user->obfs;
                $sendMessage = [
                    'text'                      => $text,
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
            [
                'chat_id'       => $Data['ChatID'],
                'message_id'    => $Data['MessageID'],
                'parse_mode'    => 'HTML',
            ],
            $sendMessage
        );
        return ($Data['AllowEditMessage']
            ? TelegramTools::SendPost('editMessageText', $sendMessage)
            : $bot->sendMessage($sendMessage));
    }

    public static function getUserSubscribeKeyboard($user)
    {
        $text = '订阅中心.';
        $keyboard = [
            [
                [
                    'text'          => 'SSR 订阅',
                    'callback_data' => 'user.subscribe|?sub=1'
                ],
                [
                    'text'          => 'SSD 订阅',
                    'callback_data' => 'user.subscribe|?ssd=1'
                ],
            ],
            [
                [
                    'text'          => 'SS-Android 订阅',
                    'callback_data' => 'user.subscribe|?list=ssa'
                ],
                [
                    'text'          => 'V2RayN 订阅',
                    'callback_data' => 'user.subscribe|?sub=3'
                ],
            ],
            [
                [
                    'text'          => 'Shadowrocket',
                    'callback_data' => 'user.subscribe|?list=shadowrocket'
                ],
                [
                    'text'          => 'Kitsunebi',
                    'callback_data' => 'user.subscribe|?list=kitsunebi'
                ]
            ],
            [
                [
                    'text'          => 'Clash',
                    'callback_data' => 'user.subscribe|?clash=1'
                ],
                [
                    'text'          => 'ClashR',
                    'callback_data' => 'user.subscribe|?clash=2'
                ],
            ],
            [
                [
                    'text'          => 'Clash Provider',
                    'callback_data' => 'user.subscribe|?list=clash'
                ],
                [
                    'text'          => 'ClashR Provider',
                    'callback_data' => 'user.subscribe|?list=clashr'
                ],
            ],
            [
                [
                    'text'          => 'Surge List',
                    'callback_data' => 'user.subscribe|?list=surge'
                ],
                [
                    'text'          => 'Surge 4',
                    'callback_data' => 'user.subscribe|?surge=4'
                ],
            ],
            [
                [
                    'text'          => 'Surge 2',
                    'callback_data' => 'user.subscribe|?surge=2'
                ],
                [
                    'text'          => 'Surge 3',
                    'callback_data' => 'user.subscribe|?surge=3'
                ],
            ],
            [
                [
                    'text'          => 'Quantumult',
                    'callback_data' => 'user.subscribe|?list=quantumult'
                ],
                [
                    'text'          => 'QuantumultX',
                    'callback_data' => 'user.subscribe|?list=quantumultx'
                ],
            ],
            [
                [
                    'text'          => 'Quantumult Conf',
                    'callback_data' => 'user.subscribe|?quantumult=3'
                ],
                [
                    'text'          => 'Surfboard',
                    'callback_data' => 'user.subscribe|?surfboard=1'
                ],
            ],
            [
                [
                    'text'          => '回主菜单',
                    'callback_data' => 'user.index'
                ]
            ]
        ];
        return [
            'text'      => $text,
            'keyboard'  => $keyboard,
        ];
    }

    /**
     *
     * 用户订阅
     *
     */
    public static function UserSubscribe($user, $bot, $Callback, $Data, $SendUser)
    {
        $CallbackDataExplode = explode('|', $Data['CallbackData']);
        // 订阅中心
        if (isset($CallbackDataExplode[1])) {
            $temp = [];
            $temp['keyboard'] = [
                [
                    [
                        'text'          => '回主菜单',
                        'callback_data' => 'user.index'
                    ],
                    [
                        'text'          => '回上一页',
                        'callback_data' => 'user.subscribe'
                    ]
                ]
            ];
            $token = LinkController::GenerateSSRSubCode($user->id, 0);
            $UserApiUrl = LinkController::getSubinfo($user, 0)['link'];
            switch ($CallbackDataExplode[1]) {
                case '?clash=1':
                    $temp['text'] = '您的 Clash 配置文件.' . PHP_EOL . '同时，您也可使用该订阅链接：' . $UserApiUrl . $CallbackDataExplode[1];
                    $filename = 'Clash_' . $token . '_' . time() . '.yaml';
                    $filepath = BASE_PATH . '/storage/SendTelegram/' . $filename;
                    $fh = fopen($filepath, 'w+');
                    $string = LinkController::getClash($user, 1, [], [], false);
                    fwrite($fh, $string);
                    fclose($fh);
                    $bot->sendDocument(
                        [
                            'chat_id'       => $Data['ChatID'],
                            'document'      => $filepath,
                            'caption'       => $temp['text'],
                        ]
                    );
                    unlink($filepath);
                    break;
                case '?clash=2':
                    $temp['text'] = '您的 ClashR 配置文件.' . PHP_EOL . '同时，您也可使用该订阅链接：' . $UserApiUrl . $CallbackDataExplode[1];
                    $filename = 'ClashR_' . $token . '_' . time() . '.yaml';
                    $filepath = BASE_PATH . '/storage/SendTelegram/' . $filename;
                    $fh = fopen($filepath, 'w+');
                    $string = LinkController::getClash($user, 2, [], [], false);
                    fwrite($fh, $string);
                    fclose($fh);
                    $bot->sendDocument(
                        [
                            'chat_id'       => $Data['ChatID'],
                            'document'      => $filepath,
                            'caption'       => $temp['text'],
                        ]
                    );
                    unlink($filepath);
                    break;
                case '?quantumult=3':
                    $temp['text'] = '点击打开配置文件，选择分享 拷贝到 Quantumult，选择更新配置.';
                    $filename = 'Quantumult_' . $token . '_' . time() . '.conf';
                    $filepath = BASE_PATH . '/storage/SendTelegram/' . $filename;
                    $fh = fopen($filepath, 'w+');
                    $string = LinkController::GetQuantumult($user, 3, [], [], false);
                    fwrite($fh, $string);
                    fclose($fh);
                    $bot->sendDocument(
                        [
                            'chat_id'       => $Data['ChatID'],
                            'document'      => $filepath,
                            'caption'       => $temp['text'],
                        ]
                    );
                    unlink($filepath);
                    break;
                case '?surge=2':
                    $temp['text'] = '点击打开配置文件，选择分享 拷贝到 Surge，点击启动.';
                    $filename = 'Surge_' . $token . '_' . time() . '.conf';
                    $filepath = BASE_PATH . '/storage/SendTelegram/' . $filename;
                    $fh = fopen($filepath, 'w+');
                    $string = LinkController::getSurge($user, 2, [], [], false);
                    fwrite($fh, $string);
                    fclose($fh);
                    $bot->sendDocument(
                        [
                            'chat_id'       => $Data['ChatID'],
                            'document'      => $filepath,
                            'caption'       => $temp['text'],
                        ]
                    );
                    unlink($filepath);
                    break;
                case '?surge=3':
                    $temp['text'] = '点击打开配置文件，选择分享 拷贝到 Surge，点击启动.';
                    $filename = 'Surge_' . $token . '_' . time() . '.conf';
                    $filepath = BASE_PATH . '/storage/SendTelegram/' . $filename;
                    $fh = fopen($filepath, 'w+');
                    $string = LinkController::getSurge($user, 3, [], [], false);
                    fwrite($fh, $string);
                    fclose($fh);
                    $bot->sendDocument(
                        [
                            'chat_id'       => $Data['ChatID'],
                            'document'      => $filepath,
                            'caption'       => $temp['text'],
                        ]
                    );
                    unlink($filepath);
                    break;
                default:
                    $temp['text'] = '该订阅链接为：' . PHP_EOL . PHP_EOL . $UserApiUrl . $CallbackDataExplode[1];
                    break;
            }
        } else {
            $temp = self::getUserSubscribeKeyboard($user);
        }
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
        $sendMessage = array_merge(
            [
                'chat_id'       => $Data['ChatID'],
                'message_id'    => $Data['MessageID'],
                'parse_mode'    => 'HTML',
            ],
            $sendMessage
        );
        return ($Data['AllowEditMessage']
            ? TelegramTools::SendPost('editMessageText', $sendMessage)
            : $bot->sendMessage($sendMessage));
    }

    public static function getUserInviteKeyboard($user)
    {
        if (!$paybacks_sum = Payback::where('ref_by', $user->id)->sum('ref_get')) {
            $paybacks_sum = 0;
        }
        $text = [
            '<strong>分享计划，您每邀请 1 位用户注册：</strong>',
            '',
            '- 您会获得 <strong>' . $_ENV['invite_gift'] . 'G</strong> 流量奖励.',
            '- 对方将获得 <strong>' . $_ENV['invite_get_money'] . ' 元</strong> 奖励作为初始资金.',
            '- 对方充值时您还会获得对方充值金额的 <strong>' . $_ENV['code_payback'] . '%</strong> 的返利.',
            '',
            '已获得返利：' . $paybacks_sum . ' 元.',
        ];
        $keyboard = [
            [
                [
                    'text'          => '获取我的邀请链接',
                    'callback_data' => 'user.invite.get'
                ]
            ],
            [
                [
                    'text'          => '回主菜单',
                    'callback_data' => 'user.index'
                ]
            ]
        ];
        return [
            'text'      => implode(PHP_EOL, $text),
            'keyboard'  => $keyboard,
        ];
    }

    /**
     *
     * 分享计划
     *
     */
    public static function UserInvite($user, $bot, $Callback, $Data, $SendUser)
    {
        $CallbackDataExplode = explode('|', $Data['CallbackData']);
        $Operate = explode('.', $CallbackDataExplode[0]);
        $op_2 = $Operate[2];
        switch ($op_2) {
            case 'get':
                $Data['AllowEditMessage'] = false;
                $code = InviteCode::where('user_id', $user->id)->first();
                if ($code == null) {
                    $user->addInviteCode();
                    $code = InviteCode::where('user_id', $user->id)->first();
                }
                $inviteUrl = $_ENV['baseUrl'] . '/auth/register?code=' . $code->code;
                $text = '<a href="' . $inviteUrl . '">' . $inviteUrl . '</a>';
                $sendMessage = [
                    'text'                      => $text,
                    'disable_web_page_preview'  => false,
                    'reply_to_message_id'       => null,
                    'reply_markup'              => null
                ];
                break;
            default:
                $temp = self::getUserInviteKeyboard($user);
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
            [
                'chat_id'       => $Data['ChatID'],
                'message_id'    => $Data['MessageID'],
                'parse_mode'    => 'HTML',
            ],
            $sendMessage
        );
        return ($Data['AllowEditMessage']
            ? TelegramTools::SendPost('editMessageText', $sendMessage)
            : $bot->sendMessage($sendMessage));
    }

    /**
     *
     * 每日签到
     *
     */
    public static function UserCheckin($user, $bot, $Callback, $Data, $SendUser)
    {
        $checkin = $user->checkin();
        TelegramTools::SendPost(
            'answerCallbackQuery',
            [
                'callback_query_id' => $Callback->getId(),
                'text'              => $checkin['msg'],
                'show_alert'        => true,
            ]
        );
        // 回送信息
        if ($Data['ChatID'] > 0) {
            $temp = self::getUserIndexKeyboard($user);
        } else {
            $temp['text'] = Reply::getUserTitle($user);
            $temp['text'] .= PHP_EOL . PHP_EOL;
            $temp['text'] .= Reply::getUserTrafficInfo($user);
            $temp['text'] .= PHP_EOL;
            $temp['text'] .= '流量重置时间：' . $user->valid_use_loop();
            $temp['keyboard'] = [
                [
                    [
                        'text'          => (!$user->isAbleToCheckin() ? '已签到' : '签到'),
                        'callback_data' => 'user.checkin.' . $SendUser['id']
                    ]
                ],
            ];
        }
        $sendMessage = [
            'text'                  => $temp['text'] . PHP_EOL . PHP_EOL . $checkin['msg'],
            'chat_id'               => $Data['ChatID'],
            'message_id'            => $Data['MessageID'],
            'reply_to_message_id'   => $Data['MessageID'],
            'parse_mode'            => 'Markdown',
            'reply_markup'          => json_encode(
                [
                    'inline_keyboard' => $temp['keyboard'],
                ]
            ),
        ];
        return ($Data['AllowEditMessage']
            ? TelegramTools::SendPost('editMessageText', $sendMessage)
            : $bot->sendMessage($sendMessage));
    }
}
