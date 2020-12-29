<?php

namespace App\Services;

use App\Models\GConfig;

class DefaultConfig
{
    public static function create($key)
    {
        $value = self::default_value($key);
        if ($value != null) {
            $new                 = new GConfig();
            $new->key            = $value['key'];
            $new->value          = $value['value'];
            $new->name           = $value['name'];
            $new->comment        = $value['comment'];
            $new->operator_id    = $value['operator_id'];
            $new->operator_name  = $value['operator_name'];
            $new->oldvalue       = '';
            $new->operator_email = '';
            $new->last_update    = time();
            if ($new->save()) {
                return true;
            }
        }

        return false;
    }

    public static function firstOrCreate($key)
    {
        return (self::create($key)
            ? GConfig::find($key)
            : null
        );
    }

    public static function detectConfigs()
    {
        $return = '开始检查新增的配置项...' . PHP_EOL;
        $configs = self::configs();
        foreach ($configs as $key => $value) {
            $config = GConfig::find($key);
            if ($config == null) {
                if (self::create($key)) {
                    $return .= '新增的配置项：' . $key . '：' . $value['name'] . PHP_EOL;
                } else {
                    $return .= $key . '：配置项创建失败，请检查错误' . PHP_EOL;
                }
            }
        }
        $return .= '以上是新增的配置项...' . PHP_EOL;

        return $return;
    }

    public static function configs($key = null)
    {
        $configs = [
            'Telegram.enable.Diary' => [
                'key'           => $key,
                'value'         => 1,
                'name'          => '开启 Telegram 群组推送系统今天的运行状况',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],
            'Telegram.msg.Diary' => [
                'key'           => $key,
                'value'         => ('各位老爷少奶奶，我来为大家报告一下系统今天的运行状况哈~' . PHP_EOL . '今日签到人数：%getTodayCheckinUser%' . PHP_EOL . '今日使用总流量：%lastday_total%' . PHP_EOL . '晚安~'),
                'name'          => '自定义向 Telegram 群组推送系统今天的运行状况的信息',
                'comment'       => '可用变量：' . PHP_EOL . '[今日签到人数] %getTodayCheckinUser%' . PHP_EOL . '[今日使用总流量] %lastday_total%',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],

            'Telegram.enable.DailyJob' => [
                'key'           => $key,
                'value'         => 1,
                'name'          => '开启 Telegram 群组推送数据库清理的通知',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],
            'Telegram.msg.DailyJob' => [
                'key'           => $key,
                'value'         => '姐姐姐姐，数据库被清理了，感觉身体被掏空了呢~',
                'name'          => '自定义向 Telegram 群组推送数据库清理通知的信息',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],

            'Telegram.enable.NodeOffline' => [
                'key'           => $key,
                'value'         => 1,
                'name'          => '开启 Telegram 群组推送节点掉线的通知',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],
            'Telegram.msg.NodeOffline' => [
                'key'           => $key,
                'value'         => '喵喵喵~ %node_name% 节点掉线了喵~',
                'name'          => '自定义向 Telegram 群组推送节点掉线通知的信息',
                'comment'       => '可用变量：' . PHP_EOL . '[节点名称] %node_name%',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],

            'Telegram.enable.NodeOnline' => [
                'key'           => $key,
                'value'         => 1,
                'name'          => '开启 Telegram 群组推送节点上线的通知',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],
            'Telegram.msg.NodeOnline' => [
                'key'           => $key,
                'value'         => '喵喵喵~ %node_name% 节点恢复了喵~',
                'name'          => '自定义向 Telegram 群组推送节点上线通知的信息',
                'comment'       => '可用变量：' . PHP_EOL . '[节点名称] %node_name%',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],

            'Telegram.enable.NodeGFW' => [
                'key'           => $key,
                'value'         => 1,
                'name'          => '开启 Telegram 群组推送节点被墙的通知',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],
            'Telegram.msg.NodeGFW' => [
                'key'           => $key,
                'value'         => '喵喵喵~ %node_name% 节点被墙了喵~',
                'name'          => '自定义向 Telegram 群组推送节点被墙通知的信息',
                'comment'       => '可用变量：' . PHP_EOL . '[节点名称] %node_name%',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],

            'Telegram.enable.NodeGFW_recover' => [
                'key'           => $key,
                'value'         => 1,
                'name'          => '开启 Telegram 群组推送节点被墙恢复的通知',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],
            'Telegram.msg.NodeGFW_recover' => [
                'key'           => $key,
                'value'         => '喵喵喵~ %node_name% 节点恢复了喵~',
                'name'          => '自定义向 Telegram 群组推送节点被墙恢复通知的信息',
                'comment'       => '可用变量：' . PHP_EOL . '[节点名称] %node_name%',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],

            'Telegram.enable.AddNode' => [
                'key'           => $key,
                'value'         => 1,
                'name'          => '开启 Telegram 群组推送节点新增的通知',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],
            'Telegram.msg.AddNode' => [
                'key'           => $key,
                'value'         => '新节点添加~ %node_name%',
                'name'          => '自定义向 Telegram 群组推送节点新增通知的信息',
                'comment'       => '可用变量：' . PHP_EOL . '[节点名称] %node_name%',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],

            'Telegram.enable.UpdateNode' => [
                'key'           => $key,
                'value'         => 1,
                'name'          => '开启 Telegram 群组推送节点修改的通知',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],
            'Telegram.msg.UpdateNode' => [
                'key'           => $key,
                'value'         => '节点信息被修改~ %node_name%',
                'name'          => '自定义向 Telegram 群组推送节点修改通知的信息',
                'comment'       => '可用变量：' . PHP_EOL . '[节点名称] %node_name%',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],

            'Telegram.enable.DeleteNode' => [
                'key'           => $key,
                'value'         => 1,
                'name'          => '开启 Telegram 群组推送节点删除的通知',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],
            'Telegram.msg.DeleteNode' => [
                'key'           => $key,
                'value'         => '节点被删除~ %node_name%',
                'name'          => '自定义向 Telegram 群组推送节点删除通知的信息',
                'comment'       => '可用变量：' . PHP_EOL . '[节点名称] %node_name%',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],

            'get.Detect.Log' => [
                'key'           => $key,
                'value'         => '0',
                'name'          => '审计记录的处理记录',
                'comment'       => '',
                'operator_id'   => 0,
                'operator_name' => '系统默认',
            ],
        ];
        return ($key === null
            ? $configs
            : $configs[$key]
        );
    }

    public static function default_value($key)
    {
        return (in_array($key, array_keys(self::configs()))
            ? self::configs($key)
            : null
        );
    }
}
