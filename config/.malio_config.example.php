<?php

/*

__    __     ______     __         __     ______    
/\ '-./  \   /\  __ \   /\ \       /\ \   /\  __ \   
\ \ \-./\ \  \ \  __ \  \ \ \____  \ \ \  \ \ \/\ \  
 \ \_\ \ \_\  \ \_\ \_\  \ \_____\  \ \_\  \ \_____\ 
  \/_/  \/_/   \/_/\/_/   \/_____/   \/_/   \/_____/ 
                                                     
                  made by @editXY

*/


####### 版本信息说明（请勿更改） #######
$Malio_Config['config_migrate_notice'] = '';
$Malio_Config['version'] = '1';


####### 通用设置 #######
$Malio_Config['theme_color'] = 'purple';    // 主题颜色，可选值为 purple, blue, darkblue, orange, pink TODO:（此功能尚在开发中）
$Malio_Config['google_analytics_code'] = 'UA-123456789-1';    // Google 统计代码，留空为不开启，code格式为 'UA-123456789-1'
$Malio_Config['login_style'] = 'wallpaper';    // 登录页面的样式，可选 simple 和 wallpaper
$Malio_Config['enable_landing_page'] = true;    // 是否启用着陆页用于介绍本站
$Malio_Config['malio_js_version'] = 'v1';    // 可以随便写，每次更新 malio.js 文件就要改变这个值，用户浏览器就会请求最新的js授权文件，就不会出现缓存的问题
$Malio_Config['small_brand'] = 'ML';    // 侧边栏在缩小状态下显示的 logo 名称，建议写两个英文字母或一个中文汉字


####### 面板设置 #######
$Malio_Config['enable_webapi_ip_verification'] = false;    // (此项已废弃，可使用.config.php里面的checkNodeIp) 当节点通过 webapi 连接时，不验证节点IP是否与数据库中的IP相同。关闭此选项会降低安全性。设置为 true 为开启 IP 验证
$Malio_Config['enable_webapi_email_hash'] = true;    // 启用后，当节点通过 webapi 连接时，传出去的邮件地址会经过md5加密。
$Malio_Config['reset_bandwidth_and_expire_date_when_change_class'] = false;    // 设置为true时，当用户购买与用户当前等级不同的套餐时，重置流量和过期时间。（定制功能）
$Malio_Config['force_user_to_bind_tg_when_join_group'] = true;   // 设置为true时，限制只有绑定了tg的用户才能加入群组，如未绑定将会被踢出群组。.config.php 需要设置群组id，机器人在群组中不回应设为false才能用。机器人需要在群里组设定为管理员才能踢人。(定制功能)
$Malio_Config['ip_database'] = 'QQWry';   //  IP归属地数据库，可选 QQWry | GeoIP2
$Malio_Config['enable_i18n'] = true;   //  是否显示切换语言的按钮
$Malio_Config['default_lang'] = 'zh-cn';   //  面板默认的语言，支持 en | zh-cn
$Malio_Config['only_one_lang'] = 'none';   //  强制使用某种语言，支持 en | zh-cn | none


####### 支付系统 #######
// 支付系统写 none 意味着不启用此收款方式
// 支付宝目前支持 bitpayx | stripe | tomatopay | f2fpay | wolfpay | materialpay
$Malio_Config['mups_alipay'] = 'bitpayx';   // Malio 聚合支付系统里面的 支付宝 要用的支付平台  
// 微信支付目前支持 bitpayx | stripe | materialpay
$Malio_Config['mups_wechat'] = 'bitpayx';   // Malio 聚合支付系统里面的 微信支付 要用的支付平台
$Malio_Config['mups_minimum_amount'] = 0;   //  Malio 聚合支付系统限制最低的充值金额

// 下面的选项在 Malio 聚合支付系统无效
$Malio_Config['stripe_minimum_amount'] = 4;   // Stripe 支付接口可充值的最低金额
$Malio_Config['stripe_currency'] = 'usd';   // Stripe 支付接口的默认货币，可以写 hkd usd等，stripe限制了收款货币只能是账号注册地区的货币
$Malio_Config['bitpyax_alipay_type'] = 'ALIPAY';   // bitpayx 支付宝充值的类似，ALIPAY是国内支付宝，ALIGLOBAL是国际支付宝


####### 注册 #######
$Malio_Config['code_required'] = false;    // 设置为true时，注册时邀请码是必须的。设置为false时，有无邀请码都可以注册，但是可以填邀请码（aff专用）
$Malio_Config['enable_register_email_restrict'] = true;    // 设置为true时，会限制注册时使用的邮箱后缀
$Malio_Config['register_email_white_list'] = ['@gmail.com','@qq.com','@outlook.com','@163.com','@126.com','@yeah.net','@foxmail.com'];   // 注册时的邮箱后缀白白白白白白名单，仅在上面的设置为true时生效
$Malio_Config['register_email_black_list'] = ['@bcaoo.com','@chacuo.net','@tmpmail.net','@tmail.ws','@tmpmail.org','@moimoi.re','@bccto.me','@027168.com','@disbox.org','@linshiyouxiang.net','@t.odmail.cn','@tmails.net','@moakt.co','@moakt.ws','@disbox.net','@bareed.ws'];   // 注册时的邮箱后缀黑黑黑黑黑黑名单
$Malio_Config['enable_sms_verify'] = false;   //  是否启用注册时的短信验证码
$Malio_Config['sms_verify_iplimit'] = '5';   //  单IP限制发送短信验证码的次数
$Malio_Config['globalsent_access_key'] = '';   //  GlobalSent 的 api key， https://globalsent.com
$Malio_Config['phone_area_code'] = [    // 发送短信支持的手机区号
    '86' => '中国 +86',
    '1' => '美国 +1',
    '852' => '香港 +852',
    '81' => '日本 +81',
    '44' => '英国 +44',
    '61' => '澳大利亚 +61'
];


####### 订阅设置 #######
$Malio_Config['support_sub_type'] = ['ss','ssr','v2ray'];    // 选择网站支持的代理协议，会影响复制订阅链接和一键导入按钮的显示。比如删除这个参数里的ss，则 Surge 订阅按钮不会显示再首页上，教程里也不会显示Surge教程
$Malio_Config['quantumult_mode'] = 'single';   // quantumult 一键导入按钮的模式，可选 "single"或"all"。选择single的话只能导入一种订阅（比如只能导入SSR订阅）。选择all的话可以一次性导入全部订阅类型（SS+SSR+V2RAY），但是导入后需要用户手动更新订阅才会出现节点。
$Malio_Config['quantumult_sub_type'] = 'v2ray';    // quanmutult 的一键导入的订阅类型，可选 ss、ssr、v2ray (仅在quantumult_mode设置为single时生效)
$Malio_Config['enable_copy_urls_to_clipboard'] = true;   // 设置为 true 时，首页会显示 批量复制XX链接到剪贴板 的按钮，不建议启用。
$Malio_Config['enable_sub_extend'] = false;   //  设置为true时，订阅将包含等级过期时间和流量信息


####### 在线客服系统 #######
// Crisp 设置
$Malio_Config['enable_crisp'] = false;   // 是否启用 Crisp 在线客服系统 https://crisp.chat
$Malio_Config['enable_crisp_outside'] = true;   // 是否对未登录的用户也启用 Crisp，设置为 false 的话，着陆页和登录/注册等页面不会显示 Crisp，同时对 Chatra 也是生效的
$Malio_Config['crisp_wesite_id'] = '18b46e92-eb21-76d3-bfb7-8f2ae9adba64';    // Crisp 的网站ID，格式为 '18b46e92-eb21-76d3-bfb7-8f2ae9adba64'

// Chatra 设置
$Malio_Config['enable_chatra'] = true;    // 是否启用 Chatra 在线客服系统 https://chatra.io
$Malio_Config['chatra_id'] = '';    // Chatra 的 ChatraID，可以在 Chatra 提供的网站代码里找到


####### 侧边栏 #######
$Malio_Config['enable_relay'] = true;   // 是否显示中转规则
$Malio_Config['enable_ticket'] = true;   // 是否显示工单系统
$Malio_Config['enable_detect'] = true;   // 是否显示审计系统
$Malio_Config['enable_invite'] = true;   // 是否显示邀请注册
$Malio_Config['enable_wallet'] = true;   // 是否显示我的钱包
$Malio_Config['enable_user_sub_log'] = true;  // 是否显示用户订阅记录页面
$Malio_Config['enable_share_account_page'] = true;  // 是否在侧边栏显示共享账号页面 (定制功能)
$Malio_Config['enable_sidebar_button'] = true;    // 是否显示底部 Telegram 按钮
$Malio_Config['telegram_group'] = 'https://t.me/SSUnion';   // Telegram 按钮的链接
$Malio_Config['telegram_group_class'] = 0;   // 显示底部 Telegram 按钮的用户最低等级，用户等级小于这个数字的将不会显示 Telegram 按钮


####### 首页 #######
$Malio_Config['enable_index_subinfo'] = true;    // 是否在首页显示订阅链接复制或一键导入等按钮
$Malio_Config['index_subinfo_buttons_align'] = false;   // 是否开启首页订阅链接按钮的对齐
$Malio_Config['index_show_alert_to_tutorial'] = false;   // 首页是否一直显示进入教程的横幅 （此项设置为false后，新用户的首页依旧会显示引导进入教程的横幅）
$Malio_Config['enable_index_popup_ann'] = false;   //  是否在用户登录后弹出重要公告
$Malio_Config['enable_index_popup_ann_time'] = false;   //  重要公告弹窗是否24小时只弹一次
$Malio_Config['index_popup_ann_content'] = '仅在有重大通知时使用，否则会降低用户体验，可以使用HTML标签';   //  重要公告的内容

// 不在首页显示的一键导入按钮，clash | kitsunebi | quantumult | shadowrocket | v2ray | ss | ssr | ssd | surge | surfboard | copy-ss | copy-ssr | copy-vmess
$Malio_Config['index_hidden_import_buttons'] = ['copy-ss','copy-ssr','ssd','copy-vmess'];

$Malio_Config['enable_share'] = true;   // 是否显示共享账号
$Malio_Config['share_account'] = [    // 一个array为一个共享账号
    'Netflix' => [  // 这个是账号分类
        array(
            'name' => 'Netflix 1',   // 账号的名字
            'account' => 'malio@nintendo.jp',  // 账号的登录邮箱啥的
            'passwd' => 'yahaha~',   // 账号的密码
            'class' => 2   // 大于等于此等级的用户才能看到此共享账号
        ),
        array(
            'name' => 'Netflix 2',
            'account' => 'malio22222@nintendo.jp',
            'passwd' => 'yahaha~',
            'class' => 2
        )
    ],
    'HBO' => [
        array(
            'name' => 'HBO 1',
            'account' => 'malio@nintendo.jp',
            'passwd' => 'yahaha~',
            'class' => 2
        )
    ],
    'Hulu' => [
        array(
            'name' => 'Hulu 1',
            'account' => 'malio@nintendo.jp',
            'passwd' => 'yahaha~',
            'class' => 1,
        )
    ],
];

$Malio_Config['daily_bonus_mode'] = 'sspanel';  // 签到的模式，填写 sspanel 为原版模式，填写 malio 为不同等级给不同的签到流量
$Malio_Config['daily_bonus_settings'] = array(  // 为不同等级给不同的签到流量，仅在 daily_bonus_mode 为 malio 时生效
    1 => array(  // 用户等级
        'min' => 100,  // 最低流量，单位为MB
        'max' => 200   // 最高流量，单位为MB
    ),
    2 => array(
        'min' => 1000,
        'max' => 2000
    ),
    3 => array(
        'min' => 10000,
        'max' => 20000
    ),
);


####### 商店 #######
$Malio_Config['shop_style'] = 'plans';    // 商店的显示风格， legacy为SSPANEL原版，plans为新版

$Malio_Config['shop_enable_autorenew'] = true;   // 商店是否显示自动续费的选项
$Malio_Config['shop_enable_coupon'] = true;    // 商店是否显示试用优惠券选项

$Malio_Config['shop_enable_trail_plan'] = true;   // 商店是否显示新用户试用选项
$Malio_Config['shop_trail_plan_shopid'] = '12';   // 新用户试用的商品ID

$Malio_Config['index_one_row_plans'] = '3';   //  首页里每行显示多少个会员计划，可以写 3 或 4
$Malio_Config['shop_one_row_plans'] = '3';   //  商店里每行显示多少个会员计划，可以写 3 或 4

// 每个会员计划不同时长所对应的商品ID（商品ID可以在管理面板的商品列表里找到），此项必须设置，不然商店购买功能无法正常工作
// 可以复制 array 增加会员计划，比如增加第四个会员计划，使用 'plan_4' => array(...) 这样的格式
$Malio_Config['plan_shop_id'] = array(
    'plan_1' => array(
        '1month' => 1,
        '3month' => 2,
        '6month' => 3,
        '12month' => 4,
    ),
    'plan_2' => array(
        '1month' => 5,
        '3month' => 6,
        '6month' => 7,
        '12month' => 8,
    ),
    'plan_3' => array(
        '1month' => 9,
        '3month' => 10,
        '6month' => 11,
        '12month' => 12,
    ),
);

$Malio_Config['shop_enable_traffic_package'] = true;   // 商店是否显示流量叠加包的选项（仅在用户购买会员计划后才会显示）
$Malio_Config['shop_traffic_packages'] = [ // 商店流量叠加包的详细信息，一个array为一个流量叠加包。在商品列表添加流量包时只需要填写名称、价格、流量，其他参数默认即可
    array(
        'shopid' => 13, // 流量叠加包的商品ID
        'traffic' => 10, // 单位为GB
        'price' => 5 
    ),
    array(
        'shopid' => 14,
        'traffic' => 20,
        'price' => 9 
    ),
    array(
        'shopid' => 15,
        'traffic' => 30,
        'price' => 15 
    ),
];


####### 我的钱包 #######
$Malio_Config['enable_topup_code'] = true;   // 是否在我的钱包页面显示充值码充值按钮
$Malio_Config['topup_amount_input_mode'] = 'input';  //  充值金额的输入方式，input 是用户手动输入， select 是用户选择站长设定的固定值进行充值
$Malio_Config['topup_select_list'] = [9.9, 19.9, 29.9];  // 用户只能在这个列表里选择充值金额，只有在 topup_amount_input_mode 设置为 select 的时候有效


####### 我的账号 #######
$Malio_Config['enable_2fa'] = true;   // 是否显示二步验证的选项
$Malio_Config['enable_delete'] = true;   // 是否显示删除账号的选项
$Malio_Config['enable_telegram'] = true;   // 是否显示绑定 Telegram 账号的选项，禁用后登录页面的 “使用 Telegram 登录” 按钮会隐藏


####### 节点列表 #######
$Malio_Config['enable_node_load'] = true;   // 是否显示节点的负载
$Malio_Config['enable_online_user'] = true;   // 是否显示节点的在线人数
$Malio_Config['enable_node_traffic_rate'] = true;   // 是否显示节点的流量倍率
$Malio_Config['enable_node_speedlimit'] = true;   // 是否显示节点的限速
$Malio_Config['flag_mode'] = 'node-name';   // 节点列表的国旗取值方式。node-name 为从节点名字前两个字取值（比如美国Vultr取值为美国）。node-info 为从节点状态取值，在节点列表里编辑节点，填写节点状态为 us 则显示美国国旗。us这个是国家ISO 3166码，不懂就谷歌。
$Malio_Config['taiwan_flag'] = 'cn';   //  台湾的旗显示方式，cn为中国国旗，tw为台湾区旗


####### 节点设置 -> 连接设置 #######
$Malio_Config['enable_protocol'] = true;   // 是否显示自定义混淆和协议设置
$Malio_Config['enable_method'] = true;    // 是否显示自定义加密方式设置
$Malio_Config['enable_reset_port'] = true;   // 是否显示重置端口设置，.config.php 里的 port_price (重置端口价格) 为负数的话是不会显示的。


####### 下载和使用 #######
$Malio_Config['display_more_app_button'] = true;   // 教程页面是否显示”其他客户端按钮“
$Malio_Config['windows_client'] = 'cfw';    // Windows 教程的首选客户端，可选 cfw, ssr
$Malio_Config['ios_client'] = 'quantumult';    // iOS 教程的首选客户端，可选 quantumult, shadowrocket, kitsunebi
$Malio_Config['ios_sub_type'] = 'v2ray';    // iOS 客户端的一键导入的订阅类型，可选ssr、v2ray
$Malio_Config['enable_ios_apple_id'] = true;    //  是否在 iOS 教程页面显示 Apple ID
$Malio_Config['ios_apple_id'] = 'malio@icloud.com';   //  iOS 教程页面的 Apple ID 账号
$Malio_Config['ios_apple_id_password'] = '1UPBOY~~';    // iOS 教程页面的 Apple ID 密码
$Malio_Config['android_client'] = 'clash';    // Android 教程的首选客户端，可选 ssr, kitsunebi, v2rayng, surfboard, clash
$Malio_Config['mac_client'] = 'clashx';    // Mac 教程的首选客户端，可选 clashx, shadowsocksx-ng-r
$Malio_Config['linux_client'] = 'clash';    // Linux 教程的首选客户端，可选 clash, electron-ssr
$Malio_Config['enable_faq'] = true;    // 是否显示 FAQ 常见问题页面
$Malio_Config['enable_windows_gaming_tutorial'] = true;    // 是否启用 Windows 游戏教程 （netch教程）


####### 着陆页设置 #######
// 着陆页文本可以在 .i18n.php 更改
$Malio_Config['index_enable_promotion'] = true;   // 着陆页是否显示促销活动提示
$Malio_Config['index_statistics_1_data'] = '100+';    // 着陆页的第1个统计数据（国际节点）
$Malio_Config['index_statistics_2_data'] = '25+';    // 着陆页的第2个统计数据（国家地区）
$Malio_Config['index_statistics_3_data'] = '6500+';    // 着陆页的第3个统计数据（满意用户）
