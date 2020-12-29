<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>账号已被禁用 &mdash; {$config["appName"]}</title>

</head>

<body>
  <div id="app">
    <div class="main-wrapper">
      {include file='user/navbar.tpl'}

      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>账号已被禁用</h1>
          </div>
          <div class="section-body">
            <div class="col-12">
                <div class="card">
                  <div class="card-header">
                    <h5>您由于某些原因而被管理员禁用了账户，请联系管理员。</h5>
                  </div>
                </div>
              </div>
          </div>
        </section>
      </div>
      {include file='user/footer.tpl'}
    </div>
  </div>

  {include file='user/scripts.tpl'}

</body>

</html>