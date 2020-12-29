<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>支付结果 &mdash; {$config["appName"]}</title>

</head>

<body>
  <div id="app">
    <div class="main-wrapper">
      {include file='user/navbar.tpl'}

      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-body">
            <!--
            <div class="col-12">
              <div class="card">
                <div class="card-header">
                  {if ($success == 1)}
                  <h5>已充值成功 {$money} 元</h5>
                  {else}
                  <h5>正在处理您的支付，请您稍等。此页面会自动刷新，或者您可以选择关闭此页面，余额将自动到账</h5>
                  <script>
                    setTimeout('window.location.reload()', 5000);
                  </script>
                  {/if}
                </div>
              </div>
            </div>
          -->

            <div class="row">
              <div class="col-12 col-md-12 col-sm-12">
                <div class="card">
                  <div class="card-body">
                    <div class="empty-state" data-height="600" style="height: 600px;">
                      <img class="img-fluid" src="/theme/malio/img/card_payment_online_1.svg" alt="image">
                      {if $success == 1}
                      <h2 class="mt-4">{$i18n->get('payment-result-confirmed')}</h2>
                      <p class="lead">
                        {$i18n->get('payment-result-confirmed-info', [$money])}
                      </p>
                      {else}
                      <h2 class="mt-4">{$i18n->get('payment-result-waiting')}</h2>
                      <p class="lead">
                        {$i18n->get('payment-result-waiting-info')}
                      </p>
                      <script>
                        setTimeout('window.location.reload()', 5000);
                      </script>
                      {/if}
                      <a href="/user/code" class="mt-4 bb">{$i18n->get('go-to-my-wallet')}</a>
                    </div>
                  </div>
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