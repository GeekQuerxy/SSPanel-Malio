<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
  <title>重置密码 &mdash; {$config["appName"]}</title>

  <!-- General CSS Files -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.8.2/css/all.min.css">
  
  <!-- CSS Libraries -->

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
          <div class="col-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4">
            <div class="login-brand">
              <img src="/theme/malio/assets/img/stisla-fill.svg" alt="logo" width="100" class="shadow-light rounded-circle">
            </div>

            <div class="card card-primary">
              <div class="card-header">
                <h4>重置密码</h4>
              </div>

              <div class="card-body">
                <p class="text-muted">请填写新密码</p>
                <div class="form-group">
                  <label for="password">新密码</label>
                  <input id="password" type="password" class="form-control pwstrength" data-indicator="pwindicator" name="password" tabindex="2" required>
                  <div id="pwindicator" class="pwindicator">
                    <div class="bar"></div>
                    <div class="label"></div>
                  </div>
                </div>

                <div class="form-group">
                  <label for="repasswd">重复密码</label>
                  <input id="repasswd" type="password" class="form-control" name="repasswd" tabindex="2" required>
                </div>

                <div class="form-group">
                  <button id="reset" type="submit" class="btn btn-primary btn-lg btn-block" tabindex="4">
                    重置
                  </button>
                </div>
              </div>
            </div>
            <div class="mt-5 text-muted text-center">
              <a href="/auth/login">返回登录</a>
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

  <!-- Page Specific JS File -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.25.6/dist/sweetalert2.all.min.js"></script>
  <script src="/theme/malio/js/malio.js?{$malio_config['malio_js_version']}"></script>

  <script>
    $(document).ready(function () {
      function reset() {
        $.ajax({
          type: "POST",
          url: "/password/token/{$token}",
          dataType: "json",
          data: {
            password: $("#password").val(),
            repasswd: $("#repasswd").val(),
          },
          success: function (data) {
            if (data.ret) {
              swal({
                type: 'success',
                title: '成功重置密码',
                showCloseButton: true,
                onClose: () => {
                  window.location.assign('/auth/login')
                }
              })
            } else {
              swal({
                type: 'error',
                title: '出了点问题',
                showCloseButton: true,
                text: data.msg
              })
            }
          }
        });
      }

      $("html").keydown(function (event) {
        if (event.keyCode == 13) {
          reset();
        }
      });
      $("#reset").click(function () {
        reset();
      });
    })
  </script>

  <script>
    var code = "UG93ZXJlZCBieSA8YSBocmVmPSIvc3RhZmYiPlNTUEFORUw8L2E+IDxkaXYgY2xhc3M9ImJ1bGxldCI+PC9kaXY+VGhlbWUgYnkgPGEgaHJlZj0iaHR0cHM6Ly90Lm1lL2VkaXRYWSIgdGFyZ2V0PSJibGFuayI+ZWRpdFhZPC9hPg==";
    $('#copyright').html(atob(code));
  </script>
</body>

</html>
