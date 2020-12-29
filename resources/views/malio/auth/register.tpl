<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
  <title>{$i18n->get('sign-up')} &mdash; {$config["appName"]}</title>

  <!-- General CSS Files -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.8.2/css/all.min.css">

  <!-- Template CSS -->
  <link rel="stylesheet" href="/theme/malio/assets/css/style.css">
  <link rel="stylesheet" href="/theme/malio/assets/css/components.css">

  {if $malio_config['enable_crisp'] == true && $malio_config['enable_crisp_outside'] == true}
  {include file='crisp.tpl'}
  {/if}
  {if $malio_config['enable_chatra'] == true && $malio_config['enable_crisp_outside'] == true}
  {include file='chatra.tpl'}
  {/if}
</head>

<body>
  <div id="app">
    <section class="section">
      <div class="container mt-5">
        <div class="row">
          <div class="col-12 col-sm-10 offset-sm-1 col-md-8 offset-md-2 col-lg-8 offset-lg-2 col-xl-8 offset-xl-2">
            <div class="login-brand">
              <img src="/theme/malio/assets/img/stisla-fill.svg" alt="logo" width="100" class="shadow-light rounded-circle">
            </div>

            <div class="card card-primary">
              <div class="card-header">
                <h4>{$i18n->get('sign-up')}</h4>
              </div>

              <div class="card-body">
                {if $config['register_mode'] == 'close'}
                <p>{$i18n->get('closed-on-registeration', [$config["appName"]])}</p>
                {else}
                <form action="javascript:void(0);" method="POST" class="needs-validation" novalidate="">
                  <div class="row">
                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                      <label for="name">{$i18n->get('nickname')}</label>
                      <input id="name" type="text" class="form-control" name="name" required autofocus>
                      <div class="invalid-feedback">
                        {$i18n->get('please-fill-in-your-nickname')}
                      </div>
                    </div>
                    {if $enable_email_verify == false}
                      {if $malio_config['enable_register_email_restrict'] == true}
                      <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                        <label for="email">{$i18n->get('email')}</label>
                        <div class="input-group">
                          <input type="text" id="email" class="form-control col-7" required>
                          <select class="custom-select input-group-append col-5" id="email_postfix" required style="border-top-right-radius: .25rem;
                          border-bottom-right-radius: .25rem;">
                            {$email_first = true}
                            {foreach $malio_config['register_email_white_list'] as $email}
                            {if $email_first == true}
                            <option value="{$email}" selected="">{$email}</option>
                            {$email_first = false}
                            {else}
                            <option value="{$email}">{$email}</option>
                            {/if}
                            {/foreach}
                          </select>
                          <div class="invalid-feedback">
                            {$i18n->get('please-fill-in-your-email')}
                          </div>
                        </div>
                      </div>
                      {else}
                      <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                        <label for="email">{$i18n->get('email')}</label>
                        <input id="email" type="email" class="form-control" name="email" required>
                        <div class="invalid-feedback">
                          {$i18n->get('please-fill-in-your-email')}
                        </div>
                      </div>
                      {/if}
                    {/if}

                    {if $enable_email_verify == true && $config['register_mode'] == 'invite'}
                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                      <label for="code" class="d-block">{$i18n->get('invitation-code')} {if $malio_config['code_required'] == false}({$i18n->get('optional')}){/if}</label>
                      <input id="code" type="text" class="form-control" name="code" {if $malio_config['code_required'] == true}required{/if}>
                      {if $malio_config['code_required'] == true}
                      <div class="invalid-feedback">
                        {$i18n->get('please-fill-in-invitation-code')}
                      </div>
                      {/if}
                    </div>
                    {/if}
                  </div>

                  {if $enable_email_verify == true}
                  <div class="row">
                    {if $malio_config['enable_register_email_restrict'] == true}
                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                      <label for="email">{$i18n->get('email')}</label>
                      <div class="input-group">
                        <input type="text" id="email" class="form-control col-7" required>
                        <select class="custom-select input-group-append col-5" id="email_postfix" required style="border-top-right-radius: .25rem;
                          border-bottom-right-radius: .25rem;">
                          {$email_first = true}
                          {foreach $malio_config['register_email_white_list'] as $email}
                          {if $email_first == true}
                          <option value="{$email}" selected="">{$email}</option>
                          {$email_first = false}
                          {else}
                          <option value="{$email}">{$email}</option>
                          {/if}
                          {/foreach}
                        </select>
                        <div class="invalid-feedback">
                          {$i18n->get('please-fill-in-your-email')}
                        </div>
                      </div>
                    </div>
                    {else}
                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                      <label for="email">{$i18n->get('email')}</label>
                      <input id="email" type="email" class="form-control" name="email" required>
                      <div class="invalid-feedback">
                        {$i18n->get('please-fill-in-your-email')}
                      </div>
                    </div>
                    {/if}
                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                      <label for="email">{$i18n->get('email-verification-code')}</label>
                      <div class="input-group mb-3">
                        <input id="email_code" type="text" class="form-control" name="email" required>
                        <div class="input-group-append">
                          <button id="email_verify" class="btn btn-primary" type="button">{$i18n->get('send')}</button>
                        </div>
                      </div>
                      <div class="invalid-feedback">
                        {$i18n->get('please-fill-in-email-verification-code')}
                      </div>
                    </div>
                  </div>
                  {/if}

                  <div class="row">
                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                      <label for="passwd" class="d-block">{$i18n->get('password')}</label>
                      <input id="passwd" type="password" class="form-control pwstrength" data-indicator="pwindicator" name="passwd" required>
                      <div id="pwindicator" class="pwindicator">
                        <div class="bar"></div>
                        <div class="label"></div>
                      </div>
                      <div class="invalid-feedback">
                        {$i18n->get('please-fill-in-your-passsword')}
                      </div>
                    </div>
                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                      <label for="repasswd" class="d-block">{$i18n->get('confirm-password')}</label>
                      <input id="repasswd" type="password" class="form-control" name="repasswd" required>
                      <div class="invalid-feedback">
                        {$i18n->get('please-your-confirm-password')}
                      </div>
                    </div>
                  </div>

                  {if $malio_config['enable_sms_verify'] == true}
                  <div class="row">
                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                      <label for="email">{$i18n->get('phone-number')}</label>
                      <div class="form-group">
                        <div class="input-group">
                          <select id="area_code" class="form-control custom-select col-4 select2" style="border-top-right-radius: 0 !important;
                                border-bottom-right-radius: 0 !important;">
                            {foreach $malio_config['phone_area_code'] as $code => $name}
                            <option value="{$code}">{$name}</option>
                            {/foreach}
                          </select>
                          <input id="phone" type="text" class="form-control col-8" required>
                          <div class="invalid-feedback">
                            {$i18n->get('please-fill-in-your-phone-number')}
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                      <label for="email">{$i18n->get('sms-verification-code')}</label>
                      <div class="form-group">
                        <div class="input-group mb-3">
                          <input id="sms_code" type="text" class="form-control" placeholder="" aria-label="" required>
                          <div class="input-group-append">
                            <button id="send_sms_code" class="btn btn-primary" type="button" style="border-top-right-radius: .3rem;border-bottom-right-radius: .3rem;">{$i18n->get('send')}</button>
                          </div>
                          <div class="invalid-feedback">
                            {$i18n->get('please-fill-in-sms-verification-code')}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  {/if}

                  {if $config['register_mode'] == 'invite' && $enable_email_verify == false}
                  <div class="row">
                    <div class="form-group col-lg-6 col-sm-12 col-xs-12">
                      <label for="code" class="d-block">{$i18n->get('invitation-code')} {if $malio_config['code_required'] == false}({$i18n->get('optional')}){/if}</label>
                      <input id="code" type="text" class="form-control" name="code" {if $malio_config['code_required'] == true}required{/if}>
                      {if $malio_config['code_required'] == true}
                      <div class="invalid-feedback">
                        {$i18n->get('please-fill-in-invitation-code')}
                      </div>
                      {/if}
                    </div>
                  </div>
                  {/if}

                  {if $geetest_html != null}
                      <div class="rowtocol">
                          <div class="form-group form-group-label">
                              <div id="embed-captcha"></div>
                          </div>
                      </div>
                  {/if}

                  {if $recaptcha_sitekey != null}
                    <div class="form-group">
                      <div class="g-recaptcha" data-sitekey="{$recaptcha_sitekey}"></div>
                    </div>
                  {/if}

                  <div class="form-group">
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" name="agree" class="custom-control-input" id="agree" checked="checked" required>
                      <label class="custom-control-label" for="agree">{$i18n->get('sign-up-tos-check')}</label>
                      <div class="invalid-feedback">
                        {$i18n->get('check-tos-feedback')}
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <button id="register-confirm" onclick="doSignUp()" class="btn btn-primary btn-lg btn-block">
                      {$i18n->get('sign-up')}
                    </button>
                  </div>
                </form>
                {/if}
              </div>
            </div>
            <div class="mt-5 text-muted text-center">
              {$i18n->get('already-got-an-account-question-mark')}
              </div>
            <div class="simple-footer">
              Copyright &copy; 2020 {$config["appName"]}
              <div class="mt-2" id="copyright"></div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>

  <!-- General JS Scripts -->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.2.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/tooltip.js@1.3.2/dist/umd/tooltip.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/jquery.nicescroll@3.7.6/jquery.nicescroll.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/moment@2.18.1/min/moment.min.js"></script>

  <!-- JS Libraies -->
  <script src="/theme/malio/assets/modules/jquery-pwstrength/jquery.pwstrength.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.25.6/dist/sweetalert2.all.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/clipboard@2/dist/clipboard.min.js"></script>

  <!-- Page Specific JS File -->
  <script src="/theme/malio/js/malio.js?{$malio_config['malio_js_version']}"></script>

  <script>
    var code = "UG93ZXJlZCBieSA8YSBocmVmPSIvc3RhZmYiPlNTUEFORUw8L2E+IDxkaXYgY2xhc3M9ImJ1bGxldCI+PC9kaXY+VGhlbWUgYnkgPGEgaHJlZj0iaHR0cHM6Ly90Lm1lL2VkaXRYWSIgdGFyZ2V0PSJibGFuayI+ZWRpdFhZPC9hPg==";
    $('#copyright').html(atob(code));
  </script>

  <script>
  $(".pwstrength").pwstrength({
    texts: ['{$i18n->get("too-weak")}', '{$i18n->get("weak")}', '{$i18n->get("average")}', '{$i18n->get("strong")}', '{$i18n->get("perfect")}'] 
  });

    function login(email,passwd) {
      $.ajax({
          type:"POST",
          url:"/auth/login",
          dataType:"json",
          data:{
              email: email,
              passwd: passwd,
              code: '',
              remember_me: 1
          },
          success: function (data) {
            window.location.assign('/user')
          }
      });
    }

    function register() {
      // vaildation
      if (
        !$("#name").val() ||
        !$("#email").val() ||
        !$("#passwd").val() ||
        !$("#repasswd").val()
        ){
          $('#register-confirm').removeClass("disabled")
          $('#register-confirm').removeAttr("disabled")
        return false
      };
      // eof vaildation
      
      {if $geetest_html != null}
      validate = captcha.getValidate();
      if (typeof validate === 'undefined' || !validate) {
        swal('请验证身份', '请滑动验证码来完成验证。', 'info');
        $('#register-confirm').removeClass("disabled")
        $('#register-confirm').removeAttr("disabled")
        return;
      }
      {/if}

      code = $("#code").val();
      {if $config['register_mode'] != 'invite'}
      code = 0;
      if ((getCookie('code')) != '') {
        code = getCookie('code');
      }
      {/if}

      {if $malio_config['enable_register_email_restrict'] == true}
      var email = $("#email").val()+$("#email_postfix").val();
      {else}
      var email = $("#email").val();
      {/if}

      $.ajax({
          type: "POST",
          url: "/auth/register",
          dataType: "json",
          data: {
              email: email,
              name: $("#name").val(),
              passwd: $("#passwd").val(),
              repasswd: $("#repasswd").val(),
              {if $recaptcha_sitekey != null}
              recaptcha: grecaptcha.getResponse(),
              {/if}
              {if $malio_config['enable_sms_verify'] == true}
              "phone": $('#phone').val(),
              "area_code": $('#area_code').val(),
              "sms_code": $('#sms_code').val(),
              {/if}
              code: code{if $enable_email_verify == true},
              emailcode: $("#email_code").val(){/if}{if $geetest_html != null},
              geetest_challenge: validate.geetest_challenge,
              geetest_validate: validate.geetest_validate,
              geetest_seccode: validate.geetest_seccode
              {/if}
          },
          success: function (data) {
              if (data.ret == 1) {
                swal({
                  type: 'success',
                  title: '{$i18n->get("sign-up-successful")}',
                  showCloseButton: true,
                  onClose: () => {
                    login(email, $("#passwd").val());
                  }
                })
              } else {
                $('#register-confirm').removeClass("disabled")
                $('#register-confirm').removeAttr("disabled")
                {if $geetest_html != null}
                captcha.reset();
                {/if}
                $("#code").val(code);
                swal({
                  type: 'error',
                  title: '{$i18n->get("hey")}',
                  showCloseButton: true,
                  text: data.msg
                })
              }
          }
      });
    }

    $("html").keydown(function (event) {
        if (event.keyCode == 13) {
          register()
        }
    });

    function doSignUp(){
      $('#register-confirm').addClass("disabled")
      $('#register-confirm').attr("disabled","disabled")
      register()
    }
  </script>

  {if $enable_email_verify == true}
  <script>
    var wait = 60;

    function time(o) {
      if (wait == 0) {
        o.removeAttr("disabled");
        o.text("{$i18n->get('sned-agagin')}");
        wait = 60;
      } else {
        o.attr("disabled", "disabled");
        o.text("{$i18n->get('sned-agagin')}(" + wait + ")");
        wait--;
        setTimeout(function () {
            time(o)
          },
          1000)
      }
    }

    $("#email_verify").click(function () {
      time($("#email_verify"));

      {if $malio_config['enable_register_email_restrict'] == true}
      var email = $("#email").val()+$("#email_postfix").val();
      {else}
      var email = $("#email").val();
      {/if}

      $.ajax({
        type: "POST",
        url: "send",
        dataType: "json",
        data: {
          email: email
        },
        success: function (data) {
          if (data.ret) {
            swal({
              type: 'success',
              title: "{$i18n->get('code-sent')}",
              showCloseButton: true,
              text: "{$i18n->get('email-code-desc')}"
            })
          } else {
            swal({
              type: 'error',
              title: "{$i18n->get('failed')}",
              showCloseButton: true,
              text: data.msg
            })
          }
        }
      })
    })
  </script>
  {/if}

  {if $malio_config['enable_sms_verify'] == true}
  <script>
    var wait = 60;

  function time(o) {
    if (wait == 0) {
      o.removeAttr("disabled");
      o.text("{$i18n->get('sned-agagin')}");
      wait = 60;
    } else {
      o.attr("disabled", "disabled");
      o.text("{$i18n->get('sned-agagin')}(" + wait + ")");
      wait--;
      setTimeout(function () {
          time(o)
        },
        1000)
    }
  }

    $('#send_sms_code').click(function () {
      if (!$("#phone").val()) {
        swal({
          type: 'error',
          title: '提示',
          showCloseButton: true,
          text: '请填写手机号'
        })
        return false
      }

      $.ajax({
        type: "POST",
        url: "sendsms",
        dataType: "json",
        data: {
          "phone": $('#phone').val(),
          "area_code": $('#area_code').val()
        },
        success: function (data) {
          if (data.ret) {
            time($("#send_sms_code"));
            swal({
              type: 'success',
              title: "{$i18n->get('code-sent')}",
              showCloseButton: true,
              text: data.msg
            })
          } else {
            swal({
              type: 'error',
              title: "{$i18n->get('failed')}",
              showCloseButton: true,
              text: data.msg
            })
          }
        }
      })

    })
  </script>
  {/if}

  {if $geetest_html != null}
  <script src="//static.geetest.com/static/tools/gt.js"></script>
  <script>
    var handlerEmbed = function (captchaObj) {
      captchaObj.onSuccess(function () {
          validate = captchaObj.getValidate();
      });
      captchaObj.appendTo("#embed-captcha");
      captcha = captchaObj;
    };
    initGeetest({
      gt: "{$geetest_html->gt}",
      challenge: "{$geetest_html->challenge}",
      product: "embed",
      width: "100%",
      offline: {if $geetest_html->success}0{else}1{/if}
    }, handlerEmbed);
  </script>
  {/if}

  {if $recaptcha_sitekey != null}
    <script src="https://recaptcha.net/recaptcha/api.js" async defer></script>
  {/if}

<script>
    {*dumplin：轮子1.js读取url参数*}
    function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            if (pair[0] == variable) {
                return pair[1];
            }
        }
        return "";
    }

    {*dumplin:轮子2.js写入cookie*}
    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toGMTString();
        document.cookie = cname + "=" + cvalue + "; " + expires;
    }

    {*dumplin:轮子3.js读取cookie*}
    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i].trim();
            if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
        }
        return "";
    }

    {*dumplin:读取url参数写入cookie，自动跳转隐藏url邀请码*}
    if (getQueryVariable('code') != '') {
        setCookie('code', getQueryVariable('code'), 30);
        window.location.href = '/auth/register';
    }

    {if $config['register_mode'] == 'invite'}
    {*dumplin:读取cookie，自动填入邀请码框*}
    if ((getCookie('code')) != '') {
        $("#code").val(getCookie('code'));
    }
    {/if}


</script>
</body>

</html>
