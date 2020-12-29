<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('aff')} &mdash; {$config["appName"]}</title>

  <style>
    .hero.hero-bg-image::before {
      background-color: rgba(0, 0, 0, 0.4);
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
            <h1>{$i18n->get('aff')}</h1>
          </div>
          <div class="section-body">
            <div class="row">
              <div class="col-12">
                <div class="card card-hero">
                  <div class="card-header" style="border-radius: 3px;box-shadow: 0 2px 6px #ffc36f;border: none;background-image: linear-gradient(to bottom, #ffa425, #ffc36f) ">
                    <div class="card-icon">
                      <i class="fas fa-laugh-squint" style="color:#ffc36f"></i>
                    </div>
                    <h4 class="mt-2">¥ {$paybacks_sum}</h4>
                    <div class="card-description">{$i18n->get('total-aff-reward')}</div>
                  </div>
                </div>

                <div class="hero text-white hero-bg-image hero-bg-parallax mb-4" data-background="/theme/malio/img/soroush-karimi-crjPrExvShc-unsplash.jpg" style="background-image: url(&quot;/theme/malio/img/soroush-karimi-crjPrExvShc-unsplash.jpg&quot;);">
                  <div class="hero-inner">
                    <h2>{$i18n->get('aff-card-title')}</h2>
                    {if $config['code_payback'] > 0}
                    <p class="lead">{$i18n->get('aff-card-content-1',[$config["code_payback"]])}</p>
                    {/if}
                    {if $config['invite_gift'] > 0}
                    <p class="lead">{$i18n->get('aff-card-content-2',[$config["invite_gift"]])}</p>
                    {/if}
                    {if $config['invite_get_money'] > 0}
                    <p class="lead">{$i18n->get('aff-card-content-3',[$config["invite_get_money"]])}</p>
                    {/if}
                    <div class="mt-4">
                      <a href="##" data-clipboard-text="{$config["baseUrl"]}/auth/register?code={$code->code}" class="btn btn-outline-white btn-lg btn-round btn-icon icon-left copy-text"><i class="far fa-copy"></i> {$i18n->get('copy-inivtation-link')}</a>
                      {if $user->invite_num >= 0}<div class="mt-2 ml-2" style="font-size: 0.8em;color: rgba(255, 255, 255, 0.486)">{$i18n->get('chances-of-invitation-left',[$user->invite_num])}</div>{/if}
                    </div>
                  </div>
                </div>

                <div class="card">
                  <div class="card-header">
                    <h4>{$i18n->get('inivitation-link-settings')}</h4>
                  </div>
                  <div class="card-body">
                    <div class="buttons">
                      {if $config['invite_price']>=0}
                      <a href="##" class="btn btn-primary" data-toggle="modal" data-target="#buy-invite-modal">{$i18n->get('purchase-invitation-chances')}</a>
                      {/if}
                      {if $config['custom_invite_price']>=0}
                      <a href="##" class="btn btn-primary"  data-toggle="modal" data-target="#custom-invite-modal">{$i18n->get('customize-my-link')}</a>
                      {/if}
                      <button class="btn btn-primary"  data-toggle="modal" data-target="#reset-invite-modal">{$i18n->get('reset-my-link')}</button>
                    </div>
                  </div>
                </div>

                <div class="card">
                  <div class="card-header">
                    <h4>{$i18n->get('affiliation-history')}</h4>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive">
                      <table class="table table-striped table-md">
                        <tr>
                          <th scope="col">ID</th>
                          <th scope="col">{$i18n->get('invitee-id')}</th>
                          <th scope="col">{$i18n->get('reward')}</th>
                        </tr>
                        {if count($paybacks) == 0}
                        <tr>
                          <td colspan="3"><strong>{$i18n->get('no-affiliation-history')}</strong></td>
                        </tr>
                        {else}
                        {foreach $paybacks as $payback}
                        <tr>
                          <td>{$payback->id}</td>
                          <td>{$payback->userid}</td>
                          <td>¥ {$payback->ref_get}</td>
                        </tr>
                        {/foreach}
                        {/if}
                      </table>
                    </div>
                    <div class="pagination-render float-right">
                      {$paybacks->render()}
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

{if $config['invite_price']>=0}
<div class="modal fade" tabindex="-1" role="dialog" id="buy-invite-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('purchase-invitation-chances')}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <p>{$i18n->get('invitation-chances-price',[$config['invite_price']])}</p>
          <label>{$i18n->get('enter-invitation-chances')}</label>
          <input id="buy-invite-num" type="number" class="form-control" required autofocus onclick="hideFeedback('invite-times-warn')">
          <div class="invalid-feedback" id="invite-times-warn">
            {$i18n->get('please-enter-the-amount-of-chances-feedback')}
          </div>
        </div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <button type="button" class="btn btn-primary" onclick="buyInvite()">{$i18n->get('purchase')}</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>
{/if}

{if $config['custom_invite_price']>=0}
<div class="modal fade" tabindex="-1" role="dialog" id="custom-invite-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('customize-invitation-link')}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <p>{$i18n->get('customize-invitation-link-price',[$config['custom_invite_price']])}</p>
          <label>{$i18n->get('enter-customize-invitation-link-postfix')}</label>
          <input id="custom-invite-link" type="text" class="form-control">
          <div class="invalid-feedback" id="custom-invite-feedback">
            {$i18n->get('please-enter-postfix-inivitation-link-feedback')}
          </div>
        </div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <button type="button" class="btn btn-primary" onclick="customInviteConfirm()">{$i18n->get('confirm')}</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>
{/if}

<div class="modal fade" tabindex="-1" role="dialog" id="reset-invite-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('reset-invitation-link')}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>{$i18n->get('reset-invitation-link-desc')}</p>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <a class="btn btn-primary" href="/user/inviteurl_reset">{$i18n->get('confirm')}</a>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>

</html>