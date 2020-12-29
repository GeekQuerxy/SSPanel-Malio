<!-- Chatra -->
<script>
    window.ChatraSetup = {
      clientId: '{$user->uuid}',
      colors: {
        buttonText: '#fff',
        buttonBg: '#4958F7'
      },
      {literal}
      locale: {
        "customStrings": {
          "welcome": "有疑问吗? 联系我们!",
          "chatWithUs": "与客服对话",
          "leaveUsAMessage": "给我们留言",
          "mobile_chatWithUs": "对话",
          "mobile_leaveUsAMessage": "留言",
          "offlineNote": "有任何疑问都可以留言，我们上线后会尽快回复。",
          "bot_thanksForMessage": "已收到你的信息，",
          "bot_startOnline": "我们会尽快回复。",
          "bot_startOnline_email": "我们会尽快回复，信息将会发送到此对话框或您的邮箱 ({{#email}})",
          "bot_startOnline_required": "填写昵称和邮箱即可与客服对话，我们会尽快回复。",
          "bot_startOffline": "我们会尽快回复。",
          "bot_startOffline_email": "我们会尽快回复，信息将会发送到此对话框或您的邮箱 ({{#email}})",
          "bot_startOffline_required": "填写昵称和邮箱后即可留言，收到留言后我们会尽快回复。",
          "bot_beforeForm": "请输入你的昵称和邮箱:",
          "bot_afterForm": "谢谢！",
          "bot_afterForm_email": "谢谢, 回复的信息将会发送到此对话框或您的邮箱。",
          "bot_details": "请详细描述你遇到的问题，尽量上传截图，以方便我们帮你快速解决问题。"
        },
        "online": "在线",
        "loading": "加载中...",
        "chat": {
          "empty": "Nothing here",
          "input": {
            "placeholder": "输入信息...",
            "oneMore": "输入信息...",
            "notIntroduced": "请输入你的昵称和邮箱",
            "reply": "回复 {{#name}}..."
          },
          "send": "发送",
          "messagesCount": "总共 {{#count}} 条信息",
          "noMessages": "没有信息",
          "newMessage": "新信息",
          "retrievingHistory": "正在加载聊天记录...",
          "more": "加载更多...",
          "loading": "加载中...",
          "introduce": "请提供你的昵称和邮箱",
          "insertEmoji": "输入Emoji"
        },
        "name": "昵称",
        "yourName": "你的昵称",
        "email": "邮箱",
        "message": "信息",
        "submit": "提交",
        "saved": "保存",
        "change": "更改",
        "cancel": "取消",
        "messageTypes": {
          "welcome": "欢迎",
          "joinedFirst": "加入对话",
          "joined": "{{#username}} 已加入对话",
          "left": "{{#username}} 离开了对话",
          "agentsOffline": "无人在线"
        },
        "agent": "客服",
        "typing": "正在输入",
        "areTyping": "正在输入",
        "minimize": "最小化",
        "date": {
          "month": {
            "full": "1月_2月_3月_4月_5月_6月_7月_8月_9月_10月_11月_12月",
            "short": "1月_2月_3月_4月_5月_6月_7月_8月_9月_10月_11月_12月",
          },
          "am": "上午_下午",
          "moment": "刚刚",
          "minute": "{{#count}}分钟前",
          "hour": "{{#count}}小时前",
          "day": "{{#count}}天前",
          "today": "今天",
          "yesterday": "昨天",
          "format": {
            "date": "MMMM D",
            "dateWithYear": "YYYY MMMM D",
            "when": "MMM D",
            "whenWithYear": "YYYY MMM D",
            "time": "h:mm A"
          }
        },
        "status": {
          "waiting": "{{$connecting}}",
          "connecting": "连接中...",
          "failed": "连接失败",
          "offline": "离线",
          "retry": "重新连接"
        },
        "smile": {
          "sorry": "¯\\_(ツ)_/¯"
        },
        "error": {
          "weird": "Weird error :-/",
          "incorrectEmail": "Incorrect email",
          "emptyEmail": "Empty email field",
          "emptyMessage": "Write something",
          "denied": "Access denied",
          "formNotDone": "The form has not been completed"
        },
        "and": "和",
        "close": "关闭",
        "requiredField": "Required field",
        "_chatra": {
          "logo": "Chatra",
          "phrase": "We run on",
          "chatra": "Chatra"
        },
        "messageSent": "Message sent!",
        "active": "Active",
        "activeShort": "Active less than an hour ago",
        "activeLong": "Active some time ago",
        "sending": "发送中...",
        "sent": "已发送",
        "unsent": "unsent, please introduce yourself",
        "notSeen": "未读",
        "seen": "已读",
        "units": {
          "b": "B",
          "kb": "KB",
          "mb": "MB",
          "gb": "GB"
        },
        "dropToUpload": "拖拽文件到这里上传",
        "uploadFile": "上传文件",
        "uploadFailed": "上传失败",
        "maximumFileSize": "文件大小不能超过 {{#size}} MB",
        "comment": "评论",
        "update": "更新",
        "optional": "可选"
      }

    };

  {/literal}

  (function (d, w, c) {
    w.ChatraID = '{$malio_config["chatra_id"]}';
    var s = d.createElement('script');
    w[c] = w[c] || function () {
      (w[c].q = w[c].q || []).push(arguments);
    };
    s.async = true;
    s.src = 'https://call.chatra.io/chatra.js';
    if (d.head) d.head.appendChild(s);
  })(document, window, 'Chatra');
</script>
<!-- /Chatra -->