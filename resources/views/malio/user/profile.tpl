<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('my-account')} &mdash; {$config["appName"]}</title>

  <style>
    .card-large-icons p {
      font-weight: 400;
    }
    .card-large-icons {
      width: 100%;
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
            <h1>{$i18n->get('my-account')}</h1>
          </div>
          <div class="section-body">
            <h2 class="section-title">Hi, {$user->user_name}!</h2>
            <p class="section-lead">
              {$user->email}
            </p>
            <div class="row mt-sm-4">
              <div class="col-lg-6">
                <div class="card card-large-icons">
                  <div class="card-icon bg-primary text-white">
                    <i class="fas fa-lock"></i>
                  </div>
                  <div class="card-body">
                    <h4>{$i18n->get('change-password')}</h4>
                    <p>{$i18n->get('change-password-desc')}</p>
                    <a href="##" class="card-cta" data-toggle="modal" data-target="#change-password-modal">{$i18n->get('change')} <i class="fas fa-chevron-right"></i></a>
                  </div>
                </div>
              </div>
              {if $malio_config['enable_telegram'] == true}
              <div class="col-lg-6">
                <div class="card card-large-icons">
                  <div class="card-icon bg-primary text-white">
                    <i class="fab fa-telegram-plane"></i>
                  </div>
                  <div class="card-body">
                    <h4>{$i18n->get('connect-to-telegram')}</h4>
                    {if $user->telegram_id == 0}
                    <p>{$i18n->get('connect-to-telegram-desc',[$telegram_bot])}</p>
                    {else}
                    <p>{$i18n->get('currently-connected-to-telegram-account')}<a href="https://t.me/{$user->im_value}" target="blank">@{$user->im_value}</a></p>
                    {/if}
                    <a href="##" class="card-cta" data-toggle="modal" data-target="#telegram-modal">{if $user->telegram_id == 0}{$i18n->get('telegram-connect')}{else}{$i18n->get('connect-to-another-account')}{/if} <i class="fas fa-chevron-right"></i></a>
                  </div>
                </div>
              </div>
              {/if}
              {if $malio_config['enable_2fa'] == true}
              <div class="col-lg-6">
                <div class="card card-large-icons">
                  <div class="card-icon bg-primary text-white">
                    <i class="fas fa-shield-alt"></i>
                  </div>
                  <div class="card-body">
                    <h4>{$i18n->get('two-factor-authentication')}</h4>
                    {if $user->ga_enable==1}
                    <p>{$i18n->get('2fa-enbaled-desc')}</p>
                    <a href="##" id="2fa-off" class="card-cta">{$i18n->get('disable-2fa')} <i class="fas fa-chevron-right"></i></a>
                    {else}
                    <p>{$i18n->get('2fa-desc')}</p>
                    <a href="##" class="card-cta" data-toggle="modal" data-target="#ga-modal">{$i18n->get('2fa-enable')} <i class="fas fa-chevron-right"></i></a>
                    {/if}
                  </div>
                </div>
              </div>
              {/if}
              {if $malio_config['enable_delete'] == true}
              <div class="col-lg-6">
                <div class="card card-large-icons">
                  <div class="card-icon bg-primary text-white">
                    <i class="fas fa-skull"></i>
                  </div>
                  <div class="card-body">
                    <h4>{$i18n->get('delete-account')}</h4>
                    <p>{$i18n->get('delete-account-desc')}</p>
                    <a href="##" class="card-cta"  data-toggle="modal" data-target="#kill-modal">{$i18n->get('delete-account-button')} <i class="fas fa-chevron-right"></i></a>
                  </div>
                </div>
              </div>
              {/if}
              <div class="col-12">
                <div class="card">
                  <div class="card-header">
                    <h4>{$i18n->get('5-mins-used-ip')}</h4>
                  </div>
                  <div class="card-body">
                    <table class="table table-striped">
                      <thead>
                        <tr>
                          <th scope="col">IP</th>
                          <th scope="col">{$i18n->get('location')}</th>
                        </tr>
                      </thead>
                      <tbody>
                        {if empty($userip)}
                        <tr>
                          <td colspan="2"><strong>{$i18n->get('not-use-service-in-5-mins')}</strong></td>
                        </tr>
                        {else}
                        {foreach $userip as $single=>$location}
                        <tr>
                          <td>{$single}</td>
                          <td>{$location}</td>
                        </tr>
                        {/foreach}
                        {/if}
                      </tbody>
                    </table>
                  </div>
                </div>
                <div class="card">
                  <div class="card-header">
                    <h4>{$i18n->get('10-login-ip')}</h4>
                  </div>
                  <div class="card-body">
                    <table class="table table-striped">
                      <thead>
                        <tr>
                          <th scope="col">IP</th>
                          <th scope="col">{$i18n->get('location')}</th>
                        </tr>
                      </thead>
                      <tbody>
                        {foreach $userloginip as $single=>$location}
                        <tr>
                          <td>{$single}</td>
                          <td>{$location}</td>
                        </tr>
                        {/foreach}
                      </tbody>
                    </table>
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
  <script src="//cdn.jsdelivr.net/npm/jquery-qrcode2@1.0.0/dist/jquery-qrcode.min.js"></script>
</body>

<div class="modal fade" tabindex="-1" role="dialog" id="change-password-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('change-password')}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label>{$i18n->get('current-password')}</label>
            <input id="oldpwd" type="password" class="form-control">
          </div>
          <div class="form-group">
            <label>{$i18n->get('new-password')}</label>
            <input id="pwd" type="password" class="form-control">
          </div>
          <div class="form-group">
            <label>{$i18n->get('confirm-new-password')}</label>
            <input id="repwd" type="password" class="form-control">
          </div>
        </div>
        <div class="modal-footer bg-whitesmoke br">
        <button type="button" class="btn btn-primary" onclick="passwordConfirm()">{$i18n->get('change-password-modal-confirm')}</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>

{if $malio_config['enable_delete'] == true}
<div class="modal fade" tabindex="-1" role="dialog" id="kill-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('delete-account')}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </div>
        <div class="modal-body">
          <p class="text-danger">{$i18n->get('delete-account-modal-desc')}</p>
          <div class="form-group">
            <label>{$i18n->get('delete-account-enter-password-hint')}</label>
            <input id="passwd" type="password" class="form-control">
          </div>
        </div>
        <div class="modal-footer bg-whitesmoke br">
        <button type="button" class="btn btn-danger" onclick="killConfirm()">{$i18n->get('delete-account-confirm')}</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>
{/if}

{if $malio_config['enable_telegram'] == true}
<div class="modal fade" tabindex="-1" role="dialog" id="telegram-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('connect-to-telegram')}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>{$i18n->get('telegram-modal-desc',[$telegram_bot])}</p>
        <h2 style="text-align: center"><code>{$bind_token}</code></h2>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>
{/if}

{if $malio_config['enable_2fa'] == true}
<div class="modal fade" tabindex="-1" role="dialog" id="ga-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('two-factor-authentication')}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>{$i18n->get('2fa-modal-setp-1-desc')}</p>
        <div id="ga-qr" style="text-align: center"></div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <button type="button" class="btn btn-primary" onclick="twofaNext()">{$i18n->get('next')}</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" tabindex="-1" role="dialog" id="ga-setp-2-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('two-factor-authentication')}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>{$i18n->get('2fa-modal-setp-2-desc')}</p>
        <div class="form-group">
          <label>{$i18n->get('6-digit-code')}</label>
          <input id="ga-code" type="number" class="form-control">
        </div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <button type="button" class="btn btn-primary" onclick="twofaConfirm()">{$i18n->get('enable')}</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>

<script>
  jQuery('#ga-qr').qrcode({
    "text": '{$user->getGAurl()}'
  });
</script>
{/if}
</html>