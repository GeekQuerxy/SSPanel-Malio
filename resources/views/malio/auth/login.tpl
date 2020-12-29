<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
  <title>{$i18n->get('login')} &mdash; {$config["appName"]}</title>

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
  {if $malio_config['login_style'] == 'simple'}
  <div id="app">
    <section class="section">
      <div class="container mt-5">
        <div class="row">
          <div class="col-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4">
            <div class="login-brand">
              <img src="/theme/malio/assets/img/stisla-fill.svg" alt="logo" width="100" class="shadow-light rounded-circle">
            </div>

            <div class="card card-primary">
              <div class="card-header">
                <h4>{$i18n->get('login')}</h4>
              </div>
              <form action="javascript:void(0);" method="POST" class="needs-validation" novalidate="">

                <div class="card-body">
                  <div class="form-group login-form-item">
                    <label for="email">{$i18n->get('email')}</label>
                    <input id="email" type="email" class="form-control" name="email" tabindex="1" required autofocus>
                    <div class="invalid-feedback">
                      {$i18n->get('please-fill-in-your-email')}
                    </div>
                  </div>

                  <div class="form-group login-form-item">
                    <div class="d-block">
                      <label for="password" class="control-label">{$i18n->get('password')}</label>
                      <div class="float-right">
                        <a href="/password/reset" class="text-small">
                          {$i18n->get('forgot-password-question-mark')}
                        </a>
                      </div>
                    </div>
                    <input id="password" type="password" class="form-control" name="password" tabindex="2" required>
                    <div class="invalid-feedback">
                      {$i18n->get('please-fill-in-your-password')}
                    </div>
                  </div>

                  <div id="2fa-form" class="form-group" style="display: none;">
                    <label for="2fa-code">二步验证</label>
                    <input id="2fa-code" type="number" class="form-control" name="2fa-code" tabindex="1" maxlength="6" placeholder="请输入6位验证码" required>
                    <div class="invalid-feedback">
                      请输入验证码
                    </div>
                  </div>

                  {if $geetest_html != null}
                  <div class="form-group">
                    <div class="embed-captcha"></div>
                  </div>
                  {/if}

                  {if $recaptcha_sitekey != null}
                      <div class="form-group">
                        <div class="g-recaptcha" data-sitekey="{$recaptcha_sitekey}"></div>
                      </div>
                  {/if}

                  <div class="form-group login-form-item">
                    <div class="custom-control custom-checkbox">
                      <input type="checkbox" name="remember" class="custom-control-input" tabindex="3" id="remember-me">
                      <label class="custom-control-label" for="remember-me">{$i18n->get('remember-me')}</label>
                    </div>
                  </div>

                  <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-lg btn-block login" tabindex="4">
                      {$i18n->get('login')}
                    </button>
                  </div>
              </form>
              {if $malio_config['enable_telegram'] == true}
              <div class="text-center mt-4 mb-3 login-form-item">
                <div class="text-job text-muted">{$i18n->get('or')}</div>
              </div>
              <div class="form-group login-form-item">
                <button data-toggle="modal" id="telegram-login-button" data-target="#telegram-modal" class="btn btn-info btn-lg btn-block" tabindex="4" style="box-shadow:none;">
                  <i class="fab fa-telegram-plane"></i> {$i18n->get('login-with-telegram')}
                </button>
              </div>
              {/if}

            </div>
          </div>
          <div class="mt-5 text-muted text-center login-form-item">
            {$i18n->get('dont-have-an-account-question-mark')}
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
  {/if}

  {if $malio_config['login_style'] == 'wallpaper'}
  <div id="app">
    <section class="section">
      <div class="d-flex flex-wrap align-items-stretch">
        <div class="col-lg-4 col-md-6 col-12 order-lg-1 min-vh-100 order-2 bg-white">
          <div class="p-4 m-3">
            <img src="/theme/malio/assets/img/stisla-fill.svg" alt="logo" width="80" class="shadow-light rounded-circle mb-5 mt-2">
            <h4 class="text-dark font-weight-normal">{$i18n->get('login_welcome')}</h4>
            <p class="text-muted">{$i18n->get('login_slogan')}</p>

            <form action="javascript:void(0);" method="POST" class="needs-validation" novalidate="">
              <div class="login-form-item">
                <div class="form-group">
                  <label for="email">{$i18n->get('email')}</label>
                  <input id="email" type="email" class="form-control" name="email" tabindex="1" required autofocus>
                  <div class="invalid-feedback">
                    {$i18n->get('please-fill-in-your-email')}
                  </div>
                </div>

                <div class="form-group">
                  <div class="d-block">
                    <label for="password" class="control-label">{$i18n->get('password')}</label>
                    {if $malio_config['enable_telegram'] == true}
                    <div class="float-right">
                      <a href="/password/reset" class="text-small">
                        {$i18n->get('forgot-password-question-mark')}
                      </a>
                    </div>
                    {/if}
                  </div>
                  <input id="password" type="password" class="form-control" name="password" tabindex="2" required>
                  <div class="invalid-feedback">
                    {$i18n->get('please-fill-in-your-password')}
                  </div>
                </div>
              </div>

              <div id="2fa-form" class="form-group" style="display: none;">
                <label for="2fa-code">二步验证</label>
                <input id="2fa-code" type="number" class="form-control" name="2fa-code" tabindex="1" maxlength="6" placeholder="请输入6位验证码" required>
                <div class="invalid-feedback">
                  请输入验证码
                </div>
              </div>

              {if $geetest_html != null}
              <div class="form-group">
                <div class="embed-captcha"></div>
              </div>
              {/if}

              {if $recaptcha_sitekey != null}
                <div class="form-group">
                  <div class="g-recaptcha" data-sitekey="{$recaptcha_sitekey}"></div>
                </div>
              {/if}

              <div class="form-group login-form-item">
                <div class="custom-control custom-checkbox">
                  <input type="checkbox" name="remember" class="custom-control-input" tabindex="3" id="remember-me">
                  <label class="custom-control-label" for="remember-me">{$i18n->get('remember-me')}</label>
                </div>
              </div>

              <div class="form-group text-right">
                {if $malio_config['enable_telegram'] == false}
                <a href="/password/reset" class="float-left mt-3 login-form-item">
                  {$i18n->get('forgot-password-question-mark')}
                </a>
                {/if}
                {if $malio_config['enable_telegram'] == true}
                <a href="##" id="telegram-login-button" data-toggle="modal" data-target="#telegram-modal" class="float-left mt-3 login-form-item">
                  {$i18n->get('login-with-telegram')}
                </a>
                {/if}
                <button type="submit" class="btn btn-primary btn-lg btn-icon icon-right login" tabindex="4">
                  {$i18n->get('login')}
                </button>
              </div>
            </form>

            <div class="mt-5 text-center login-form-item">
              {$i18n->get('dont-have-an-account-question-mark')}
            </div>

            <div class="text-center mt-5 text-small">
              Copyright &copy; 2020 {$config["appName"]}
              <div class="mt-2" id="copyright"></div>
            </div>
          </div>
        </div>
        <div class="col-lg-8 col-12 order-lg-2 order-1 min-vh-100 background-walk-y position-relative overlay-gradient-bottom" data-background="/theme/malio/assets/img/unsplash/login-bg.jpg" style='background-image: url("/theme/malio/assets/img/unsplash/login-bg.jpg");'>
          <div class="absolute-bottom-left index-2">
            <div class="text-light p-5 pb-2">
              <div class="mb-5 pb-3">
                <h1 class="mb-2 display-4 font-weight-bold">{$welcome}</h1>
                <h5 class="font-weight-normal text-muted-transparent">Bali, Indonesia</h5>
              </div>
              Photo by <a class="text-light" target="_blank" href="https://unsplash.com/photos/a8lTjWJJgLA">Justin Kauffman</a> on <a class="text-light" target="_blank" href="https://unsplash.com">Unsplash</a>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
  {/if}

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

  <!-- Page Specific JS File -->
  <script src="/theme/malio/js/malio.js?{$malio_config['malio_js_version']}"></script>

  <script>
  var code = "UG93ZXJlZCBieSA8YSBocmVmPSIvc3RhZmYiPlNTUEFORUw8L2E+IDxkaXYgY2xhc3M9ImJ1bGxldCI+PC9kaXY+VGhlbWUgYnkgPGEgaHJlZj0iaHR0cHM6Ly90Lm1lL2VkaXRYWSIgdGFyZ2V0PSJibGFuayI+ZWRpdFhZPC9hPg==";
  $('#copyright').html(atob(code));
  </script>

  {if $geetest_html != null}
  <script src="//static.geetest.com/static/tools/gt.js"></script>
  <script>
    captcha = '';
    var handlerEmbed = function (captchaObj) {
      captchaObj.onSuccess(function () {
          validate = captchaObj.getValidate();
      });
      captchaObj.appendTo(".embed-captcha");
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

  <script>
    var twoFA = false;
    function login() {
      if (!$("#password").val() || !$("#email").val()) {
        return false;
      }

      {if $geetest_html != null}
      validate = captcha.getValidate();
      if (typeof validate === 'undefined' || !validate) {
        swal('请验证身份', '请滑动验证码来完成验证。', 'info');
        return;
      }
      {/if}

      if (twoFA == true) {
        if (!$("#2fa-code").val()) {
          return false;
        }
      }

      $.ajax({
        type: "POST",
        url: "/auth/login",
        dataType: "json",
        data: {
          email: $("#email").val(),
          passwd: $("#password").val(),
          code: $("#2fa-code").val(),{if $recaptcha_sitekey != null}
          recaptcha: grecaptcha.getResponse(),{/if}
          remember_me: $("#remember-me:checked").val(){if $geetest_html != null},
          geetest_challenge: validate.geetest_challenge,
          geetest_validate: validate.geetest_validate,
          geetest_seccode: validate.geetest_seccode{/if}
        },
        success: function (data) {
          if (data.ret == 1) {
            window.location.assign('/user')
          } else if(data.ret == 2) {
            $('.login-form-item').hide('500');
            $('form').removeClass('was-validated');
            $('#2fa-form').show('fast');
            {if $geetest_html != null}
            captcha.reset();
            {/if}
            {if $recaptcha_sitekey != null}
            grecaptcha.reset();
            {/if}
          } else {
            {if $geetest_html != null}
            captcha.reset();
            {/if}
            {if $recaptcha_sitekey != null}
            grecaptcha.reset();
            {/if}
            var errorMsg = '密码或邮箱不正确';
            if (twoFA == true) {
              errorMsg = '两步验证码错误'
            }
            swal('出错了', errorMsg, 'error');
          }
        }
      });
    }
    $("html").keydown(function (event) {
      if (event.keyCode == 13) {
        login();
      }
    });
    $(".login").click(function () {
      login();
    });
  </script>

{if $malio_config['enable_telegram'] == true}
<div class="modal fade" tabindex="-1" role="dialog" id="telegram-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Telegram 一键登录</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center mt-4" id="telegram-login-box"></div>
        <div class="text-center mt-4 mb-3">
          <div class="text-job text-muted">或者添加机器人账号 <a href="https://t.me/{$telegram_bot}">@{$telegram_bot}</a>，发送下面的数字给它</div>
        </div>
        <div class="text-center">
            <h2><code id="code_number" style="color: #6777ef">{$login_number}</code></h2>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
  $(document).ready(function () {
    var el = document.createElement('script');
    document.getElementById('telegram-login-box').append(el);
    el.onload = function () {
      $('#telegram-alert').remove()
    }
    el.src = 'https://telegram.org/js/telegram-widget.js?4';
    el.setAttribute('data-size', 'large')
    el.setAttribute('data-telegram-login', '{$telegram_bot}')
    el.setAttribute('data-auth-url', '{$base_url}/auth/telegram_oauth')
    el.setAttribute('data-request-access', 'write')
  });
</script>
<script>
  $(document).ready(function () {
    $("#telegram-login-button").click(
      function () {
        tgLogin();
      }
    );

    function tgLogin() {
      $.ajax({
        type: "POST",
        url: "qrcode_check",
        dataType: "json",
        data: {
          token: "{$login_token}",
          number: "{$login_number}"
        },
        success: (data) => {
          if (data.ret > 0) {
            clearTimeout(tid);

            $.ajax({
              type: "POST",
              url: "/auth/qrcode_login",
              dataType: "json",
              data: {
                token: "{$login_token}",
                number: "{$login_number}"
              },
              success: (data) => {
                if (data.ret) {
                  window.location.href = '/user'
                }
              },
              error: (jqXHR) => {
                swal('TG登录失败','请使用账号密码登录', 'error');
              }
            });
          } else {
            if (data.ret === -1) {
              $('#code_number').replaceWith('<code id="code_number">此数字已经过期，请刷新页面后重试。</code>');
            }
          }
        },
        error: (jqXHR) => {
          if (jqXHR.status !== 200 && jqXHR.status !== 0) {
            swal('TG登录失败','请使用账号密码登录', 'error');
          }
        }
      });
      tid = setTimeout(tgLogin, 2500); //循环调用触发setTimeout
    }
  })
</script>
{/if}

{if $recaptcha_sitekey != null}
    <script src="https://recaptcha.net/recaptcha/api.js" async defer></script>
{/if}
</body>

</html>