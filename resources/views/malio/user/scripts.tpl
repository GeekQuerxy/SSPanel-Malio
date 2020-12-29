<!-- General JS Scripts -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.2.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/tooltip.js@1.3.2/dist/umd/tooltip.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery.nicescroll@3.7.6/jquery.nicescroll.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.18.1/min/moment.min.js"></script>

<!-- JS Libraies -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.25.6/dist/sweetalert2.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/clipboard@2/dist/clipboard.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bowser@1.9.4/bowser.min.js"></script>

<script>
  const i18n = {
    'lang': "{$user->lang}",
    'used': "{$i18n->get('data-used')} ",
    'used-today': "{$i18n->get('data-used-today')} ",
    'available': "{$i18n->get('data-available')} ",
    'alredy-got-daily-bonus': "{$i18n->get('alredy-got-daily-bonus')}",
    'success-got-daily-bonus': "{$i18n->get('success-got-daily-bonus')}",
    "server-password-changed-successfully":"{$i18n->get('server-password-changed-successfully')}",
    "encryption-changed-successfully":"{$i18n->get('encryption-changed-successfully')}",
    "failed":"{$i18n->get('failed')}",
    "protocol-and-obfs-changed-successfully":"{$i18n->get('protocol-and-obfs-changed-successfully')}",
    "confirm":"{$i18n->get('confirm')}",
    "cancel":"{$i18n->get('cancel')}",
    "reset-config-url-confirm-modal-title":"{$i18n->get('reset-config-url-confirm-modal-title')}",
    "reset-config-url-confirm-modal-desc":"{$i18n->get('reset-config-url-confirm-modal-desc')}",
    "config-url-has-been-reseted":"{$i18n->get('config-url-has-been-reseted')}",
    "config-url-reset-modal-desc":"{$i18n->get('config-url-reset-modal-desc')}",
    "port-reseted-successfully":"{$i18n->get('port-reseted-successfully')}",
    "new-port":"{$i18n->get('new-port')}",
    "customize-port-successfully":"{$i18n->get('customize-port-successfully')}",
    "successful-purchase":"{$i18n->get('successful-purchase')}",
    "go-to-wallet":"{$i18n->get('go-to-wallet')}",
    "customize-inivitation-link-successfully":"{$i18n->get('customize-inivitation-link-successfully')}",
    "2fa-has-been-disabled":"{$i18n->get('2fa-has-been-disabled')}",
    "password-changed-successfully":"{$i18n->get('password-changed-successfully')}",
    "your-account-has-been-deleted":"{$i18n->get('your-account-has-been-deleted')}",
    "submitted":"{$i18n->get('submitted')}",
    "this-ticket-has-been-closed":"{$i18n->get('this-ticket-has-been-closed')}",
    "notice":"{$i18n->get('notice')}",
    "unable-import-config-on-computer-modal":'{$i18n->get("unable-import-config-on-computer-modal")}',
    "proceed":"{$i18n->get('proceed')}",
    "top-up-successful":"{$i18n->get('top-up-successful')}",
    "":"{$i18n->get('login')}",
    "":"{$i18n->get('login')}",
    "":"{$i18n->get('login')}",
    "":"{$i18n->get('login')}",
    "":"{$i18n->get('login')}",
    "":"{$i18n->get('login')}",
    "":"{$i18n->get('login')}",
    "":"{$i18n->get('login')}",
    "":"{$i18n->get('login')}",
  }
</script>

<script src="/theme/malio/js/malio.js?{$malio_config['malio_js_version']}"></script>

<script>
  var isWeixin = function () {
    var ua = navigator.userAgent.toLowerCase();
    return ua.match(/MicroMessenger/i) == "micromessenger";
  };
  if (isWeixin() == true) {
    $('body').html('<h5 style="margin:20px">不支持在微信内访问<br>请点击右上角菜单<br>选择浏览器打开</h5>')
  }
  
  $(function () {
    new ClipboardJS('.copy-text');
  });
  $(".copy-text").click(function () {
    swal({
      type: 'success',
      title: "{$i18n->get('copied')}",
      showConfirmButton: false,
      timer: 1500
    })
  });

  function joinTelegramGroup() {
    {if $malio_config['force_user_to_bind_tg_when_join_group'] == true && $user->telegram_id == 0}
    Swal.fire({
      title: "{$i18n->get('notice')}",
      html: '{$i18n->get("join-telegram-group-modal-text")}',
      type: 'warning',
      showCancelButton: true,
      confirmButtonText: "{$i18n->get('join-telegram-group')}",
      cancelButtonText: "{$i18n->get('cancel')}"
    }).then((result) => {
      if (result.value) {
        window.open("{$malio_config['telegram_group']}")
      }
    })
    {else}
    window.open("{$malio_config['telegram_group']}")
    {/if}
  }
</script>

{if $malio_config['enable_crisp'] == true}
<script>
  function sendData() {
    $crisp.push(["set", "user:email", "{$user->email}"], ["set", "user:nickname", "{$user->user_name}"]);
    $crisp.push(["set", "session:data", [[
      ["Class", "{$user->class}"],
      ["Class_Expire", "{$user->class_expire}"],
      ["Money", "{$user->money}"],
      ["Unused_Traffic", "{$user->unusedTraffic()}"]
    ]]]);
  }
  sendData();
</script>
{/if}

{if $malio_config['enable_chatra'] == true}
<script>
  window.ChatraIntegration = {
    name: '{$user->user_name}',
    email: '{$user->email}',
    'Class': '{$user->class}',
    'Class_Expire': '{$user->class_expire}',
    'Money': '{$user->money}',
    'Unused_Traffic': '{$user->unusedTraffic()}'
  };
  var userUUID = '{$user->uuid}';
</script>
{/if}

<script>
  var code = "UG93ZXJlZCBieSA8YSBocmVmPSIvc3RhZmYiPlNTUEFORUw8L2E+IDxkaXYgY2xhc3M9ImJ1bGxldCI+PC9kaXY+IFRoZW1lIGJ5IDxhIGhyZWY9Imh0dHBzOi8vdC5tZS9lZGl0WFkiIHRhcmdldD0iYmxhbmsiPmVkaXRYWTwvYT4=";
  $('#copyright').html(atob(code));
</script>