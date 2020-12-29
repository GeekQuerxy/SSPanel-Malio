<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('shared-account')} &mdash; {$config["appName"]}</title>

  <style>
    .section .section-title:before {
      border-radius: 5px;
      height: 8px;
      width: 8px;
      margin-top: 4px;
      margin-right: 8px;
    }
  </style>
</head>

<body>
  <div id="app">
    <div class="main-wrapper">
      {include file='user/navbar.tpl'}

      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>{$i18n->get('shared-account')}</h1>
          </div>
          <div class="section-body">
            <div class="row">
              {foreach $malio_config['share_account'] as $class_name => $class}
              <div class="col-12 col-md-6 col-lg-3">
                <div class="card">
                  <div class="card-header">
                    <h4>{$class_name}</h4>
                  </div>
                  <div class="card-body">
                      {foreach $class as $account}
                      <div class="netfix-title section-title mt-0">{$account['name']}</div>
                      {if $user->class >= $account['class']}
                      {$i18n->get('account')}: <a href="##" class="copy-text" data-clipboard-text="{$account['account']}">{$account['account']}</a><br>
                      {$i18n->get('password')}: <a href="##" class="copy-text" data-clipboard-text="{$account['passwd']}">*********({$i18n->get('click-to-copy')})</a>
                      {else}
                      您目前订阅的会员计划无法查看此共享账号，请升级会员计划。
                      {/if}
                      {/foreach}
                  </div>
                </div>
              </div>
              {/foreach}
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