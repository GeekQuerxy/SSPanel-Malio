<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('store')} &mdash; {$config["appName"]}</title>

  <style>
    [type=reset], [type=submit], button, html [type=button] {
      -webkit-appearance: none;
    }
    .colors .active {
      background-color: #6777ef !important;
      color: white !important;
      box-shadow: 0 2px 6px #acb5f6;
      border: 2px solid #6777ef !important;
    }

    .colors .color:hover {
      border: 2px solid #6777ef;
      transition: 0.3s ease;
    }

    .colors .color {
      color: #282B43;
      background-color: transparent;
      background-image: none;
      cursor: pointer;
      border: 2px solid #f1f2f5;
      border-radius: 4px;
      font-size: 1rem;
      font-weight: 500;
      -webkit-touch-callout: none;
      -webkit-user-select: none;
      -khtml-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
    }

    #payment-selection #alipay {
      color: #029de3;
      border: 2px solid #f1f2f5;
      transition: 0.3s ease;
    }

    #payment-selection #wechat {
      color: #00b235;
      border: 2px solid #f1f2f5;
    }

    #payment-selection #qqpay {
      color: #11b7f5;
      border: 2px solid #f1f2f5;
    }

    #payment-selection #crypto {
      color: #ffa425;
      border: 2px solid #f1f2f5;
    }

    #payment-selection #unionpay i {
      font-size: 1.2rem;
      vertical-align: -3px;
    }

    #payment-selection #alipay:hover {
      color: #029de3;
      border: 2px solid #029de3;
    }

    #payment-selection #wechat:hover {
      color: #00b235;
      border: 2px solid #00b235;
    }

    #payment-selection #qqpay:hover {
      color: #11b7f5;
      border: 2px solid #11b7f5;
    }

    #payment-selection #crypto:hover {
      color: #ffa425;
      border: 2px solid #ffa425;
    }

    #payment-selection #alipay[class*="active"] {
      background: #029de3 !important;
      box-shadow: 0 2px 6px #029ce370;
      border: 2px solid #029de3 !important;
    }

    #payment-selection #wechat[class*="active"] {
      background: #00b235 !important;
      box-shadow: 0 2px 6px #00b23570;
      border: 2px solid #00b235 !important;
    }

    #payment-selection #qqpay[class*="active"] {
      background: #11b7f5 !important;
      box-shadow: 0 2px 6px #11b8f570;
      border: 2px solid #11b7f5 !important;
    }

    #payment-selection #crypto[class*="active"] {
      background: #ffa425 !important;
      box-shadow: 0 2px 6px #ffa42580;
      border: 2px solid #ffa425 !important;
    }

    #payment-selection .fas,
    .far,
    .fab,
    .fal {
      font-size: 1rem;
    }

    .colors .color {
      height: auto !important;
    }

    .color .pricing-inside {
      display: block;
      font-weight: bold;
      font-size: 2.8em;
    }

    .color .pricing-super {
      vertical-align: super;
      padding-right: 3px;
      font-size: 0.5em;
      margin-left: 6px;
      margin-right: 0px;
      font-weight: 500;
    }

    .color .per-month {
      position: relative;
      color: #B1C1CA;
      font-weight: 500;
      font-size: 0.2em;
      top: -0.1em;
      left: -1.6em;
    }

    #plan-selection .color[class*="active"] .badge {
      background: #fff;
      color: #6777ef;
    }
  </style>
</head>

<body>
  <div id="app">
    <div class="main-wrapper">
      {include file='user/navbar.tpl'}

      {if $malio_config['shop_style'] == 'plans'}
      <!-- Main Content -->
      <div id="main-page" class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>{$i18n->get('store')}</h1>
            {if $malio_config['shop_enable_traffic_package'] == true && $user->class > 0}
            <div class="section-header-breadcrumb">
              <div class="breadcrumb-item active">
                <a href="#" class="btn btn-icon icon-left btn-primary" data-toggle="modal" data-target="#traffic-package-modal"><i class="fas fa-gas-pump"></i> {$i18n->get('purchase-data-add-on')}</a>
              </div>
            </div>
            {/if}
          </div>
          <div class="section-body">
            <h2 class="section-title">{$i18n->get('store-title')}</h2>
            <p class="section-lead">{$i18n->get('store-sub-title')}</p>

            <div class="row">
              {if $malio_config['shop_enable_trail_plan'] == true && $user->class < 0}
              {$plan = $I18N['trial_plan'][$i18n->lang]}
              <div class="col-12 col-md-3 col-lg-3">
                <div class="pricing pricing-highlight">
                  <div class="pricing-title">
                    {$plan['name']}
                  </div>
                  <div class="pricing-padding">
                    <div class="pricing-price">
                      <div>{$plan['currency']}{$plan['price']}</div>
                      <div>{$plan['billing']}</div>
                    </div>
                    <div class="pricing-details">
                      {foreach $plan['features'] as $feature}
                      <div class="pricing-item">
                        {if $feature['support'] == true}
                        <div class="pricing-item-icon"><i class="fas fa-check"></i></div>
                        {else}
                        <div class="pricing-item-icon bg-danger text-white"><i class="fas fa-times"></i></div>
                        {/if}
                        <div class="pricing-item-label">{$feature['name']}</div>
                      </div>
                      {/foreach}
                    </div>
                  </div>
                  <div class="pricing-cta">
                    <a href="##" onclick="buyConfirm({$malio_config['shop_trail_plan_shopid']})">{$i18n->get('start-trail')} <i class="fas fa-arrow-right"></i></a>
                  </div>
                </div>
              </div>
              {/if}

              {foreach $I18N['plans-info'][$i18n->lang] as $name => $plan}
              <div class="col-12 {if $malio_config['shop_one_row_plans'] == '4' || ($malio_config['shop_enable_trail_plan'] == true && $user->class < 0)}col-md-3 col-lg-3{else}col-md-4 col-lg-4{/if}">
                <div class="pricing pricing-highlight">
                  <div class="pricing-title">
                    {$plan['name']}
                  </div>
                  <div class="pricing-padding">
                    <div class="pricing-price">
                      <div>{$plan['currency']}{$plan['price']}</div>
                      <div>{$plan['billing']}</div>
                    </div>
                    <div class="pricing-details">
                      {foreach $plan['features'] as $feature}
                      <div class="pricing-item">
                        {if $feature['support'] == true}
                        <div class="pricing-item-icon"><i class="fas fa-check"></i></div>
                        {else}
                        <div class="pricing-item-icon bg-danger text-white"><i class="fas fa-times"></i></div>
                        {/if}
                        <div class="pricing-item-label">{$feature['name']}</div>
                      </div>
                      {/foreach}
                    </div>
                  </div>
                  <div class="pricing-cta" onclick="subscribePlan('{$name}')">
                    <a href="#">{$i18n->get('subscribe')} <i class="fas fa-arrow-right"></i></a>
                  </div>
                </div>
              </div>
              {/foreach}
            </div>
          </div>
        </section>
      </div>
      <div id="buy-page" class="main-content" style="display:none">
        <section class="section">
          <div class="section-header">
            <div class="section-header-back">
              <a href="##" onclick="backToShop()" class="btn btn-icon"><i class="fas fa-arrow-left"></i></a>
            </div>
            <h1>{$i18n->get('subscribe-plan')}</h1>
          </div>
          <div class="section-body">
            <div class="invoice">
              <div class="invoice-print">

                <div class="row" id="plan-selection">
                  <div class="col-md-12">
                    <div class="section-title" style="margin-top: 0;">{$i18n->get('choose-plan')}</div>
                    <div class="colors">
                      {foreach $I18N['plans-info'][$i18n->lang] as $name => $plan}
                      {$price_exploded = explode(".",$plan['price'])}
                      <div id="{$name}" class="color col-12 col-md-2 col-lg-2" onclick="selectItem('plan','{$name}')">
                        <span class="pricing-inside"><span class="pricing-super">¥</span>{intval($plan['price'])}<span class="pricing-super">.{if count($price_exploded) == 2}{$price_exploded[1]}{else}0{/if}</span><span class="per-month">/{$i18n->get('mo')}</span></span>
                        <span class="badge badge-primary">{$plan['name']}</span>
                      </div>
                      {/foreach}
                    </div>
                  </div>
                </div>

                <div class="row mt-4" id="time-selection">
                  <div class="col-12">
                    <div class="section-title">{$i18n->get('choose-plan-time')}</div>
                    <div class="colors">
                      <div id="1month" class="color col-12 col-md-2 col-lg-2 active" onclick="selectItem('time','1month')">
                        {$i18n->get('1-month')}
                      </div>
                      <div id="3month" class="color col-12 col-md-2 col-lg-2" onclick="selectItem('time','3month')">
                        {$i18n->get('3-months')}
                      </div>
                      <div id="6month" class="color col-12 col-md-2 col-lg-2" onclick="selectItem('time','6month')">
                        {$i18n->get('6-months')}
                      </div>
                      <div id="12month" class="color col-12 col-md-2 col-lg-2" onclick="selectItem('time','12month')">
                        {$i18n->get('12-months')}
                      </div>
                    </div>
                  </div>
                </div>

                {if $malio_config['shop_enable_autorenew'] == true}
                <div class="row mt-4" id="autorenew-selection">
                  <div class="col-12">
                    <div class="section-title">{$i18n->get('autorenew')}</div>
                    <div class="colors row">
                      <div id="autorenew-off" class="color col-12 col-md-2 col-lg-2 active" onclick="selectItem('autorenew','autorenew-off')">
                        {$i18n->get('autorenew-disable')}
                      </div>
                      <div id="autorenew-on" class="color col-12 col-md-2 col-lg-2" onclick="selectItem('autorenew','autorenew-on')">
                        {$i18n->get('autorenew-enable')}
                      </div>
                    </div>
                  </div>
                </div>
                {/if}

                <div class="row mt-4" id="payment-selection">
                  <div class="col-12">
                    <div class="section-title">{$i18n->get('payment')}</div>
                    <div class="colors row">
                      {if $config['payment_system'] != malio}
                        <div id="alipay" class="color col-12 col-md-2 col-lg-2 active" onclick="selectItem('payment','alipay')">
                          <i class="fab fa-alipay" style="font-size: 1.1rem;vertical-align: -1px;margin-right: 2px;"></i> {$i18n->get('alipay')}
                        </div>
                        {if $config['payment_system'] != 'f2fpay' && $config['payment_system'] != 'spay' && $config['payment_system'] != 'payssion'}
                        <div id="wechat" class="color col-12 col-md-2 col-lg-2" onclick="selectItem('payment','wechat')">
                          <i class="malio-wechat-pay" style="font-size: 1.1rem;vertical-align: -1px;"></i> {$i18n->get('wechat-pay')}
                        </div>
                        {/if}
                        {if $config['payment_system'] == 'bitpayx'}
                        <div id="crypto" class="color col-12 col-md-2 col-lg-2" onclick="selectItem('payment','crypto')">
                          <i class="fab fa-btc"></i> {$i18n->get('cryptocurrency')}
                        </div>
                        {/if}
                        {if $config['payment_system'] == 'codepay' || $config['payment_system'] == 'flyfoxpay'}
                        <div id="qqpay" class="color col-12 col-md-2 col-lg-2" onclick="selectItem('payment','qqpay')">
                          <i class="fab fa-qq"></i> {$i18n->get('qq-wallet')}
                        </div>
                        {/if}
                        {if $config['payment_system'] == 'payssion'}
                        <div id="unionpay" class="color col-12 col-md-2 col-lg-2" onclick="selectItem('payment','unionpay')">
                          <i class="malio-unionpay"></i> {$i18n->get('unionpay')}
                        </div>
                        {/if}
                      {else}
                        {if $malio_config['mups_alipay'] != 'none'}
                        <div id="alipay" class="color col-12 col-md-2 col-lg-2 active" onclick="selectItem('payment','alipay')">
                          <i class="fab fa-alipay" style="font-size: 1.1rem;vertical-align: -1px;margin-right: 2px;"></i> {$i18n->get('alipay')}
                        </div>
                        {/if}
                        {if $malio_config['mups_wechat'] != 'none'}
                        <div id="wechat" class="color col-12 col-md-2 col-lg-2" onclick="selectItem('payment','wechat')">
                          <i class="malio-wechat-pay" style="font-size: 1.1rem;vertical-align: -1px;"></i> {$i18n->get('wechat-pay')}
                        </div>
                        {/if}
                      {/if}
                    </div>
                    <p class="text-muted">{$i18n->get('payment-notice')}</p>
                  </div>
                </div>

                <div class="row mt-4">
                  <div class="col-lg-8">
                    <div class="section-title">{$i18n->get('read-before-subscribe')}</div>
                    <p class="text-muted">
                      {$i18n->get('read-before-subscribe-content')}
                    </p>
                  </div>
                  <div class="col-lg-4 text-right">
                    <div class="invoice-detail-item">
                      <div class="invoice-detail-name">{$i18n->get('product-name')}</div>
                      <div id="shop-name" class="invoice-detail-value">Null</div>
                    </div>
                    <div class="invoice-detail-item">
                      <div class="invoice-detail-name">{$i18n->get('total-price')}</div>
                      <div id="total" class="invoice-detail-value">Null</div>
                    </div>
                    <div id="coupon-row" class="invoice-detail-item" style="display: none">
                      <div class="invoice-detail-name">{$i18n->get('discount')}</div>
                      <div id="coupon-money" class="invoice-detail-value">Null</div>
                    </div>
                    <div class="invoice-detail-item">
                      <div class="invoice-detail-name">{$i18n->get('pay-with-balance')}</div>
                      <div id="account-money" class="invoice-detail-value">¥ -{$user->money}</div>
                    </div>
                    <hr class="mt-2 mb-2">
                    <div class="invoice-detail-item">
                      <div class="invoice-detail-name">{$i18n->get('still-need-to-pay')}</div>
                      <div id="pay-amount" class="invoice-detail-value invoice-detail-value-lg">Null</div>
                    </div>
                  </div>
                </div>

                <hr class="mt-2">
                <div class="text-md-right">
                  <div class="float-lg-left mb-lg-0 mb-3">
                    <button id="coupon-btn" class="btn btn-primary btn-icon icon-left" data-toggle="modal" data-target="#coupon-modal"><i class="fas fa-tag"></i> {$i18n->get('apply-promo-code')}</button>
                  </div>
                  <button id="pay-confirm" class="btn btn-warning btn-icon icon-left"><i class="fas fa-check"></i> {$i18n->get('pay-now')}</button>
                </div>

              </div>
            </div>
          </div>
      </div>
      
      {elseif $malio_config['shop_style'] == 'legacy'}
      <div id="main-page" class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>{$i18n->get('store')}</h1>
            <div class="section-header-breadcrumb">
              <div class="breadcrumb-item active">
                {if $malio_config['shop_enable_traffic_package'] == true && $user->class > 0}
                <a href="#" class="btn btn-icon icon-left btn-primary" data-toggle="modal" data-target="#traffic-package-modal"><i class="fas fa-gas-pump"></i> {$i18n->get('purchase-data-add-on')}</a>
                {/if}
              </div>
            </div>
          </div>
          <div class="section-body">
            <h2 class="section-title">{$i18n->get('store-title')}</h2>
            <p class="section-lead">{$i18n->get('store-sub-title')}</p>

            <div class="row">
              {foreach $shops as $shop}
              {if $malio_config['shop_trail_plan_shopid'] == $shop->id && $user->class > 0}
              {continue}
              {/if}
              <div class="col-12 col-md-4 col-lg-4">
                <div class="pricing pricing-highlight">
                  <div class="pricing-title">
                    {$shop->name}
                  </div>
                  <div class="pricing-padding">
                    <div class="pricing-price">
                      <div>¥{$shop->price}</div>
                      <div>{$shop->expire()} {$i18n->get('days')}</div>
                    </div>
                    <div class="pricing-details">
                      <div class="pricing-item">
                        <div class="pricing-item-icon"><i class="fas fa-check"></i></div>
                        <div class="pricing-item-label">{$shop->bandwidth()}GB {$i18n->get('data')}</div>
                      </div>
                      {if {$shop->connector()} != '0' }
                      <div class="pricing-item">
                        <div class="pricing-item-icon"><i class="fas fa-check"></i></div>
                        <div class="pricing-item-label">{$shop->connector()} {$i18n->get('online-devices')}</div>
                      </div>
                      {/if}
                      {if {$shop->speedlimit()} != '0' }
                      <div class="pricing-item">
                        <div class="pricing-item-icon"><i class="fas fa-check"></i></div>
                        <div class="pricing-item-label">{$shop->speedlimit()}Mbps {$i18n->get('speedlimit')}</div>
                      </div>
                      {/if}
                      {if {$shop->reset()} != '0' }
                      <div class="pricing-item">
                        <div class="pricing-item-icon"><i class="fas fa-check"></i></div>
                        <div class="pricing-item-label">每 {$shop->reset()} 天重置流量为 {$shop->reset_value()}GB</div>
                      </div>
                      {/if}
                      {foreach $shop->content_extra() as $service}
                      <div class="pricing-item">
                        <div class="pricing-item-icon"><i class="fas fa-check"></i></div>
                        <div class="pricing-item-label">{$service[1]}</div>
                      </div>
                      {/foreach}
                    </div>
                  </div>
                  <div class="pricing-cta">
                    <a href="##" data-toggle="modal" data-target="#legacy-modal-1" onclick="legacySelect({$shop->id})">{$i18n->get('purchase')} <i class="fas fa-arrow-right"></i></a>
                  </div>
                </div>
              </div>
              {/foreach}
            </div>
          </div>
        </section>
      </div>
      {/if}
    </div>
    </section>
  </div>
  {include file='user/footer.tpl'}
  </div>
  </div>

  {include file='user/scripts.tpl'}
  <script src="https://cdn.jsdelivr.net/npm/kjua@0.1.2/dist/kjua.min.js"></script>

  {if $malio_config['shop_style'] == 'plans'}
  <script>
    var userMoney = '{$user->money}';
    var paymentSystem = "{$config['payment_system']}";
    updateCheckoutInfo();
  </script>
  {/if}

  {if $malio_config['shop_enable_coupon'] == true}
  <div class="modal fade" tabindex="-1" role="dialog" id="coupon-modal">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">{$i18n->get('apply-promo-code')}</h5>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <label>{$i18n->get('enter-promo-code')}</label>
            <input id="coupon-code" type="text" class="form-control" onclick="hideFeedback('coupon-feedback')">
            <div id="coupon-feedback" class="invalid-feedback">
              feedback
            </div>
          </div>
        </div>
        <div class="modal-footer bg-whitesmoke br">
          <button onclick="updateCoupon()" type="button" class="btn btn-primary">{$i18n->get('validate-code')}</button>
          <button onclick="cancelCoupon()" type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
        </div>
      </div>
    </div>
  </div>
  {/if}

{if $config['payment_system'] == 'bitpayx'}
<div class="modal fade" tabindex="-1" role="dialog" id="bitpayx-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('payment')}</h5>
      </div>
      <div class="modal-body">
        <div style="text-align: center">{$i18n->get('pay-now-modal-text')}</div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <a id="to-bitpayx" href="##" target="blank" class="btn btn-primary">{$i18n->get('continue-pay')}</a>
      </div>
    </div>
  </div>
</div>
{/if}

{if $config['payment_system'] == 'stripe'}
<div class="modal fade" tabindex="-1" role="dialog" id="stripe-alipay-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('payment')}</h5>
      </div>
      <div class="modal-body">
        <div style="text-align: center">{$i18n->get('pay-now-modal-text')}</div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <a id="to-stripe" href="##" target="blank" class="btn btn-primary">{$i18n->get('continue-pay')}</a>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" tabindex="-1" role="dialog" id="stripe-wechat-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('open-app-to-scan-qrcode',[{$i18n->get('wechat-pay')}])}</h5>
      </div>
      <div class="modal-body">
        <p>{$i18n->get('shop-dont-close-windows-hint')}</p>
        <div id="stripe-qr" style="text-align: center"></div>
      </div>
    </div>
  </div>
</div>
{/if}

{if $config['payment_system'] == 'f2fpay' || $config['payment_system'] == 'f2fpay_payjs'}
<div class="modal fade" tabindex="-1" role="dialog" id="f2fpay-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('open-app-to-scan-qrcode',[{$i18n->get('alipay')}])}</h5>
      </div>
      <div class="modal-body">
        <p>{$i18n->get('shop-dont-close-windows-hint')}</p>
        <div id="f2fpay-qr" style="text-align: center"></div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <a id="to-alipay-app" href="##" target="blank" class="btn btn-primary">{$i18n->get('go-to-alipay-app')}</a>
      </div>
    </div>
  </div>
</div>
{/if}

{if $config['payment_system'] == 'spay'}
<div class="modal fade" tabindex="-1" role="dialog" id="spay-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('payment')}</h5>
      </div>
      <div class="modal-body">
        <div style="text-align: center">{$i18n->get('pay-now-modal-text')}</div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <a id="to-spay" href="##" target="blank" class="btn btn-primary">{$i18n->get('continue-pay')}</a>
      </div>
    </div>
  </div>
</div>
{/if}

{if $config['payment_system'] == 'codepay'}
<div class="modal fade" tabindex="-1" role="dialog" id="codepay-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('payment')}</h5>
      </div>
      <div class="modal-body">
        <div style="text-align: center">{$i18n->get('pay-now-modal-text')}</div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <a id="to-codepay" href="##" target="blank" class="btn btn-primary">{$i18n->get('continue-pay')}</a>
      </div>
    </div>
  </div>
</div>
{/if}

{if $config['payment_system'] == 'tomatopay'}
<div class="modal fade" tabindex="-1" role="dialog" id="tmtpay-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('payment')}</h5>
      </div>
      <div class="modal-body">
        <div style="text-align: center">{$i18n->get('pay-now-modal-text')}</div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <a id="to-tmtpay" href="##" type="button" target="blank" class="btn btn-primary">{$i18n->get('continue-pay')}</a>
      </div>
    </div>
  </div>
</div>
{/if}

{if $config['payment_system'] == 'payssion'}
<div class="modal fade" tabindex="-1" role="dialog" id="payssion-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('payment')}</h5>
      </div>
      <div class="modal-body">
        <div style="text-align: center">{$i18n->get('pay-now-modal-text')}</div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <a id="to-payssion" href="##" type="button" target="blank" class="btn btn-primary">{$i18n->get('continue-pay')}</a>
      </div>
    </div>
  </div>
</div>
{/if}

{if $config['payment_system'] == 'flyfoxpay'}
<div class="modal fade" tabindex="-1" role="dialog" id="flyfox-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('payment')}</h5>
      </div>
      <div class="modal-body">
        <div style="text-align: center">{$i18n->get('pay-now-modal-text')}</div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <a id="to-flyfox" href="##" type="button" target="blank" class="btn btn-primary">{$i18n->get('continue-pay')}</a>
      </div>
    </div>
  </div>
</div>
{/if}

{if $config['payment_system'] == 'yftpay'}
<div class="modal fade" tabindex="-1" role="dialog" id="yftpay-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('payment')}</h5>
      </div>
      <div class="modal-body">
        <div style="text-align: center">{$i18n->get('pay-now-modal-text')}</div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <a id="to-yftpay" href="##" type="button" target="blank" class="btn btn-primary">{$i18n->get('continue-pay')}</a>
      </div>
    </div>
  </div>
</div>
{/if}

{if $config['payment_system'] == 'payjs' || $config['payment_system'] == 'f2fpay_payjs'}
<div class="modal fade" tabindex="-1" role="dialog" id="payjs-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('open-app-to-scan-qrcode',[{$i18n->get('wechat-pay')}])}</h5>
      </div>
      <div class="modal-body">
        <p>{$i18n->get('shop-dont-close-windows-hint')}</p>
        <div id="payjs-qr" style="text-align: center"></div>
      </div>
    </div>
  </div>
</div>
{/if}

{if $malio_config['shop_enable_traffic_package'] == true && $user->class > 0}
<div class="modal fade" tabindex="-1" role="dialog" id="traffic-package-modal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('purchase-data-add-on')}</h5>
      </div>
      <div class="modal-body">
        <div class="form-group">
          {$traffic_package_counter = 0}
          {foreach $malio_config['shop_traffic_packages'] as $package}
          <div class="custom-control custom-radio">
            <input type="radio" value="{$package['shopid']}" id="tp-{$package['shopid']}" name="traffic-package-radio" class="custom-control-input" {if $traffic_package_counter == 0}checked{$traffic_package_counter = 1}{/if}>
            <label class="custom-control-label" for="tp-{$package['shopid']}">
              {$i18n->get('data-add-on-item',[$package['price'],$package['traffic']])}
              </label>
          </div>
          {/foreach}
        </div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <button onclick="buyTrafficPackage()" type="button" data-dismiss="modal" class="btn btn-primary">{$i18n->get('purchase')}</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>
{/if}


{if $malio_config['shop_style'] == 'legacy'}
<div class="modal fade" tabindex="-1" role="dialog" id="legacy-modal-1">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('notice')}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>{$i18n->get('shop-ask-if-user-have-promo-code')}</p>
        <div class="form-group">
          <input id="legacy-coupon" type="text" class="form-control" placeholder="" onclick="hideFeedback('legacy-coupon-feedback')">
          <div id="legacy-coupon-feedback" class="invalid-feedback">
            feedback
          </div>
        </div>
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <button onclick="legacyModalNext()" type="button" target="blank" class="btn btn-primary">{$i18n->get('next')}</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" tabindex="-1" role="dialog" id="legacy-modal-2">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">{$i18n->get('confirm')}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id="legacy-shop-name" style="display: none">{$i18n->get('product-name')}: </p>
        <p id="legacy-discount" style="display: none">{$i18n->get('discount')}: </p>
        <p id="legacy-total" style="display: none">{$i18n->get('total')}: </p>
        {if $malio_config['shop_enable_autorenew'] == true}
        <div class="custom-control custom-checkbox">
          <input type="checkbox" class="custom-control-input" id="legacy-autorenew">
          <label class="custom-control-label" for="legacy-autorenew">{$i18n->get('enable')} {$i18n->get('autorenew')}</label>
        </div>
        {/if}
      </div>
      <div class="modal-footer bg-whitesmoke br">
        <button onclick="legacyBuy()" type="button" target="blank" class="btn btn-primary"  data-dismiss="modal">{$i18n->get('confirm')}</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">{$i18n->get('cancel')}</button>
      </div>
    </div>
  </div>
</div>
{/if}

</body>
</html>