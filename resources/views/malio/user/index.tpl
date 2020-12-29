<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('dashboard')} &mdash; {$config["appName"]}</title>

  <!-- C3 chart css -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/c3@0.6.8/c3.min.css">

  <style>
    .card-header i {
      vertical-align: 1px;
      font-size: 1rem;
    }

    .section .section-header .section-header-breadcrumb {
      flex-basis: 0;
    }

    .wizard-step-active {
      cursor: pointer;
    }

    .btn-quantumult {
      background: linear-gradient(to right, black, black) !important;
      color: white !important;
      border-color: transparent;
      border: none;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.38);
      margin-bottom: 16px;
    }
    .btn-shadowrocket {
      background: linear-gradient(to right, #3671b9, #3671b9) !important;
      color: white !important;
      border-color: transparent;
      border: none;
      box-shadow: 0 2px 6px #3671b99a;
      margin-bottom: 16px;
    }
    .btn-kitsunebi {
      background: linear-gradient(to right, #f2885b, #e83c9a) !important;
      color: white !important;
      border-color: transparent;
      border: none;
      box-shadow: 0 2px 4px #ff567885;
      margin-bottom: 16px;
    }
    .btn-ssr {
      background: linear-gradient(to right, #e780a3, #e780a3) !important;
      color: white !important;
      border-color: transparent;
      border: none;
      box-shadow: 0 2px 6px #e780a2b0;
      margin-bottom: 16px;
    }
    .btn-v2ray {
      background: linear-gradient(to right, #df268f, #a73178) !important;
      color: white !important;
      border-color: transparent;
      border: none;
      box-shadow: 0 2px 6px #df268f63;
      margin-bottom: 16px;
    }
    .btn-ss {
      background: linear-gradient(to right, #187abb, #187abb) !important;
      color: white !important;
      border-color: transparent;
      border: none;
      box-shadow: 0 2px 6px #3671b99a;
      margin-bottom: 16px;
    }
    .btn-surge {
      background: linear-gradient(to right, #5c97f0, #b769f3) !important;
      color: white !important;
      border-color: transparent;
      border: none;
      box-shadow: 0 2px 6px #8d7cfab2;
      margin-bottom: 16px;
    }
    .btn-clash {
      background: linear-gradient(to right, #49BCFC, #3B92F8) !important;
      color: white !important;
      border-color: transparent;
      border: none;
      box-shadow: 0 2px 6px rgba(73, 189, 252, 0.521);
      margin-bottom: 16px;
    }
    .btn-surfboard {
      background: linear-gradient(to right, #303030, #303030) !important;
      color: white !important;
      border-color: transparent;
      border: none;
      box-shadow: 0 2px 6px #3030306e;
      margin-bottom: 16px;
    }
    .wizard-steps .wizard-step .wizard-step-label {
        text-transform: none;
    }
    {if $malio_config['index_subinfo_buttons_align'] == true}
    .buttons a {
      width: 230px;
    }
    {/if}
  </style>
</head>

<body>
  <div id="app">
    <div class="main-wrapper">
      {include file='user/navbar.tpl'}

      {if $user->class != -1}
      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>{$i18n->get('dashboard')}</h1>
            <div class="section-header-breadcrumb">
              <div id="checkin-div" class="breadcrumb-item active">
                {if $user->isAbleToCheckin() }
                <a href="#" onclick="checkin()" class="btn btn-icon icon-left btn-primary"><i class="far fa-calendar-check"></i> {$i18n->get('daily-bonus')}</a>
                {else}
                <a href="#" class="btn btn-icon disabled icon-left btn-primary"><i class="far fa-calendar-check"></i> {$i18n->get('alredy-got-daily-bonus')}</a>
                {/if}
              </div>
            </div>
          </div>
          {if substr($user->unusedTraffic(),0,-2) <= 0 and $user->class != 0}
            <div class="alert alert-warning">
              {$i18n->get('no-available-data-alert')}
            </div>
            {/if}
            {if $user->class == 0}
            <div class="alert alert-warning">
              {$i18n->get('plan-expired-alert')}
            </div>
            {/if}
            {if substr($user->unusedTraffic(),0,-2) <= 5 && substr($user->unusedTraffic(),0,-2) > 0 && {substr($user->unusedTraffic(),-2)} == 'GB'}
              <div class="alert alert-primary">
                {$i18n->get('no-enough-data-alert')}
              </div>
              {/if}
              {if ($user->lastSsTime() == '从未使用喵' and $user->class>0) || $malio_config['index_show_alert_to_tutorial'] == true}
              <div class="alert alert-primary">
                <a href="/user/tutorial" class="alert-link" style="font-weight:400">{$i18n->get('new-user-guide-alert')}</a>
              </div>
              {/if}
              <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-12">
                  <div class="card card-statistic-2">
                    <div class="card-icon shadow-primary bg-primary">
                      <i class="fas fa-crown"></i>
                    </div>
                    <div class="card-wrap">
                      <div class="card-header">
                        <h4>{$i18n->get('your-plan')}</h4>
                      </div>
                      <div class="card-body">
                        {if $user->class_expire!="1989-06-04 00:05:00" && $user->class >= 1}
                        <span class="counter">{$class_left_days}</span> {$i18n->get('days')}
                        {elseif $user->class <= 0}
                        <span class="counter">0</span> {$i18n->get('days')}
                        {else}
                          {$i18n->get('lifetime')}
                        {/if}
                      </div>
                    </div>
                    <div class="card-stats">
                      <div class="card-stats-title" style="padding-top: 0;padding-bottom: 4px;">
                        <nav aria-label="breadcrumb">
                          <ol class="breadcrumb">
                            <li class="breadcrumb-item active" aria-current="page">
                              {if $user->class == 0}
                                {$i18n->get('plan-expired')}:
                              {else}
                                {$I18N['class-plan-name-map'][$i18n->lang][$user->class]}:
                              {/if}

                              {if $user->class_expire!="1989-06-04 00:05:00"}
                                {$i18n->get('plan-expire-at',[substr($user->class_expire, 0, 10)])}
                              {else}
                              {$i18n->get('lifetime')}
                              {/if}
                            </li>
                          </ol>
                        </nav>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-12">
                  <div class="card card-statistic-2">
                    <div class="card-icon shadow-success bg-success">
                      <i class="fas fa-tint"></i>
                    </div>
                    <div class="card-wrap">
                      <div class="card-header">
                        <h4>{$i18n->get('available-data')}</h4>
                      </div>
                      <div class="card-body">
                        <span class="counter">{substr($user->unusedTraffic(),0,-2)}</span> {substr($user->unusedTraffic(),-2)}
                      </div>
                      <div class="card-stats">
                        <div class="card-stats-title" style="padding-top: 0;padding-bottom: 4px;">
                          <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                              <li class="breadcrumb-item active" aria-current="page">{$i18n->get('used-today')}: {$user->TodayusedTraffic()}</li>
                            </ol>
                          </nav>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-12">
                  <div class="card card-statistic-2">
                    <div class="card-icon shadow-info bg-info">
                      <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="card-wrap">
                      <div class="card-header">
                        <h4>{$i18n->get('online-devices')}</h4>
                      </div>
                      <div class="card-body">
                        <span class="counter">{$user->online_ip_count()}</span> / {if $user->node_connector == 0}∞{else}<span class="counterup">{$user->node_connector}</span>{/if}
                      </div>
                      <div class="card-stats">
                        <div class="card-stats-title" style="padding-top: 0;padding-bottom: 4px;">
                          <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                              <li class="breadcrumb-item active" aria-current="page">{$i18n->get('last-used-time')}: {if $user->lastSsTime() == '从未使用喵'}{$i18n->get('never-used')}{else}{substr($user->lastSsTime(), 5)}{/if}</li>
                            </ol>
                          </nav>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-12">
                  <div class="card card-statistic-2">
                    <div class="card-icon shadow-warning bg-warning">
                      <i class="fas fa-wallet"></i>
                    </div>
                    <div class="card-wrap">
                      <div class="card-header">
                        <h4>{$i18n->get('balance')}</h4>
                      </div>
                      <div class="card-body">
                        ¥ <span class="counter">{$user->money}</span>
                      </div>
                      <div class="card-stats">
                        <div class="card-stats-title" style="padding-top: 0;padding-bottom: 4px;">
                          <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                              <li class="breadcrumb-item active" aria-current="page">{$i18n->get('total-aff-reward')}: ¥{$paybacks_sum}</li>
                            </ol>
                          </nav>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-12 col-md-7 col-lg-7">
                  <div class="card">
                    <div class="card-header">
                      <h4><i class="fas fa-bullhorn"></i> {$i18n->get('announcement')}</h4>
                    </div>
                    <div class="card-body">
                      {$ann->content}
                    </div>
                  </div>

                  <div class="card">
                    <div class="card-header">
                      <h4><i class="fas fa-chart-bar" style="vertical-align: -1px;"></i> {$i18n->get('data-usage-72-hours')}</h4>
                      <div class="card-header-action" id="loadTrafficChart-div">
                        <a href="##" onclick="loadTrafficChart()" class="btn btn-primary" style="display: inline-block">
                          {$i18n->get('load-data')}
                        </a>
                      </div>
                    </div>
                    <div id="chartCardbox" class="card-body">
                      <div id="scatter-plot"></div>
                    </div>
                  </div>
                </div>
                
                <div class="col-12 col-md-5 col-lg-5">
                  <div class="card">
                    <div class="card-header">
                      <h4><i class="fas fa-chart-pie"></i> {$i18n->get('data-useage')}</h4>
                    </div>
                    <div class="card-body">
                      <div id="pie-chart"></div>
                    </div>
                  </div>

                  {if $malio_config['enable_share'] == true}
                  <div class="card">
                    <div class="card-header">
                      <h4><i class="fas fa-share"></i> {$i18n->get('shared-account')}</h4>
                    </div>
                    <div class="card-body">
                      <div id="accordion">
                        {foreach $malio_config['share_account'] as $class_name => $class}
                        <div class="accordion">
                          <div class="accordion-header collapsed" role="button" data-toggle="collapse" data-target="#panel-body-{$class_name}" aria-expanded="false">
                            <h4>{$class_name}</h4>
                          </div>
                          <div class="accordion-body collapse" id="panel-body-{$class_name}" data-parent="#accordion">
                            {foreach $class as $account}
                            <p class="mb-2">
                              <p class="lead"><b>{$account['name']}</b></p>
                              {if $user->class >= $account['class']}
                              {$i18n->get('account')}: <a href="##" class="copy-text" data-clipboard-text="{$account['account']}">{$account['account']}</a><br>
                              {$i18n->get('password')}: <a href="##" class="copy-text" data-clipboard-text="{$account['passwd']}">*********({$i18n->get('click-to-copy')})</a>
                              {else}
                              {$i18n->get('no-access-to-shared-account-desc')}
                              {/if}
                            </p>
                            {/foreach}
                          </div>
                        </div>
                        {/foreach}
                      </div>
                    </div>
                  </div>
                  {/if}

                  {if $malio_config['enable_index_subinfo'] == true}
                  <div class="card">
                    <div class="card-header">
                      <h4><i class="fas fa-bolt"></i> {$i18n->get('quick-import')}</h4>
                    </div>
                    <div class="card-body">
                      <div class="buttons">
                        {if (in_array("ss",$malio_config['support_sub_type'])) || (in_array("v2ray",$malio_config['support_sub_type']))}
                        {if (!in_array("clash",$malio_config['index_hidden_import_buttons']))}
                          <a href="##" class="btn btn-icon icon-left btn-primary btn-clash btn-lg btn-round" onclick="importSublink('clash')"><i class="malio-clash"></i> {$i18n->get('import-clash-config')}</a>
                        {/if}
                        {/if}
                        
                        {if (in_array("ss",$malio_config['support_sub_type'])) || (in_array("v2ray",$malio_config['support_sub_type']))}
                        {if (!in_array("kitsunebi",$malio_config['index_hidden_import_buttons']))}
                        <a href="##" class="btn btn-icon icon-left btn-primary btn-kitsunebi copy-text btn-lg btn-round" data-clipboard-text="{$subInfo['kitsunebi']}"><i class="malio-kitsunebi"></i> {$i18n->get('copy-kitsunebi-config-url')}</a>
                        {/if}
                        {/if}

                        {if (!in_array("quantumult",$malio_config['index_hidden_import_buttons']))}
                          {if $malio_config['quantumult_mode'] == 'single'}
                            <a href="##" id="quan_sub" class="btn btn-icon icon-left btn-primary btn-quantumult btn-lg btn-round copy-config" onclick="importSublink('quantumult')"><i class="malio-quantumult"></i> {$i18n->get('import-quantumult-config')}</a>
                          {elseif $malio_config['quantumult_mode'] == 'all'}
                            <a href="##" id="quan_sub" class="btn btn-icon icon-left btn-primary btn-quantumult btn-lg btn-round copy-config" onclick="Copyconfig(&quot;{$subInfo['quantumult_sub']}&quot;,&quot;#quan_sub&quot;,&quot;quantumult://settings?configuration=clipboard&quot;)"><i class="malio-quantumult"></i> {$i18n->get('import-quantumult-config')}</a>
                          {/if}
                        {/if}

                        {if (!in_array("shadowrocket",$malio_config['index_hidden_import_buttons']))}
                          <a href="##" class="btn btn-icon icon-left btn-primary btn-shadowrocket btn-lg btn-round" onclick="importSublink('shadowrocket')"><i class="malio-shadowrocket"></i> {$i18n->get('import-shadowrocket-config')}</a>
                        {/if}

                        {if (in_array("ss",$malio_config['support_sub_type']))}
                        {if (!in_array("surge",$malio_config['index_hidden_import_buttons']))}
                          <div class="dropdown d-inline">
                            <button class="btn btn-primary btn-surge dropdown-toggle btn-icon btn-round btn-lg" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                              <i class="malio-surge mr-1"></i> {$i18n->get('import-surge-config')}
                            </button>
                            <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 28px, 0px); top: 0px; left: 0px; will-change: transform;">
                              <a class="dropdown-item" href="##" onclick="importSublink('surge2')"> {$i18n->get('import-surge-version-config',['2'])}</a>
                              <a class="dropdown-item copy-text" href="##" data-clipboard-text="{$subInfo['surge']}"> {$i18n->get('copy-surge-version-config-url',['2'])}</a>
                              <a class="dropdown-item" href="##" onclick="importSublink('surge3')"> {$i18n->get('import-surge-version-config',['3'])}</a>
                              <a class="dropdown-item copy-text" href="##" data-clipboard-text="{$subInfo['surge3']}"> {$i18n->get('copy-surge-version-config-url',['3'])}</a>
                              <a class="dropdown-item" href="##" onclick="importSublink('surge4')"> {$i18n->get('import-surge-version-config',['4'])}</a>
                              <a class="dropdown-item copy-text" href="##" data-clipboard-text="{$subInfo['surge4']}"> {$i18n->get('copy-surge-version-config-url',['4'])}</a>
                            </div>
                          </div>
                        {/if}

                        {if (!in_array("surfboard",$malio_config['index_hidden_import_buttons']))}
                          <a href="##" class="btn btn-icon icon-left btn-primary btn-surfboard btn-lg btn-round" onclick="importSublink('surfboard')"><i class="malio-surfboard"></i> {$i18n->get('import-surfboard-config')}</a>
                        {/if}
                        
                        {if (!in_array("ss",$malio_config['index_hidden_import_buttons']))}
                          <a href="##" class="btn btn-icon icon-left btn-primary btn-ss copy-text btn-lg btn-round" data-clipboard-text="{$subInfo['ss']}{if $malio_config['enable_sub_extend'] == true}&extend=1{/if}"><i class="malio-ssr"></i> {$i18n->get('copy-ss-config-url')}</a>
                        {/if}
                        {/if}

                        {if (in_array("v2ray",$malio_config['support_sub_type']))}
                        {if (!in_array("v2ray",$malio_config['index_hidden_import_buttons']))}
                          <a href="##" class="btn btn-icon icon-left btn-primary btn-v2ray copy-text btn-lg btn-round" data-clipboard-text="{$subInfo['v2ray']}{if $malio_config['enable_sub_extend'] == true}&extend=1{/if}"><i class="malio-v2rayng"></i> {$i18n->get('copy-v2ray-config-url')}</a>
                        {/if}
                        {/if}
                        
                        {if (!in_array("ssd",$malio_config['index_hidden_import_buttons']))}
                        <a href="##" class="btn btn-icon icon-left btn-primary btn-quantumult copy-text btn-lg btn-round" data-clipboard-text="{$subInfo['ssd']}"><i class="malio-ssr"></i> {$i18n->get('copy-ssd-config-url')}</a>
                        {/if}
                        
                        {if (in_array("ssr",$malio_config['support_sub_type']))}
                        {if (!in_array("ssr",$malio_config['index_hidden_import_buttons']))}
                        <div class="dropdown d-inline">
                          <button class="btn btn-primary btn-ssr dropdown-toggle btn-icon btn-round btn-lg" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="malio-ssr mr-1"></i> {$i18n->get('ssr-config')}
                          </button>
                          <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 28px, 0px); top: 0px; left: 0px; will-change: transform;">
                            <a class="dropdown-item" href="##" onclick="importSublink('ssr')"> {$i18n->get('import-ssr-config')}</a>
                            <a class="dropdown-item copy-text" href="##" data-clipboard-text="{$subInfo['ssr']}{if $malio_config['enable_sub_extend'] == true}&extend=1{/if}"> {$i18n->get('copy-ssr-config-url')}</a>
                          </div>
                        </div>
                        {/if}
                        {/if}
                        
                        
                        {if (!in_array("copy-ss",$malio_config['index_hidden_import_buttons']))}
                        <a href="##" id="ss-all-urls" class="btn btn-icon icon-left btn-primary btn-ss copy-config btn-lg btn-round" onclick="Copyconfig('/user/getUserAllURL?type=ss','#ss-all-urls','')"><i class="malio-ssr"></i> {$i18n->get('copy-ss-urls')}</a>
                        {/if}
                        
                        {if (!in_array("copy-ssr",$malio_config['index_hidden_import_buttons']))}
                        <a href="##" id="ssr-all-urls" class="btn btn-icon icon-left btn-primary btn-ssr copy-config btn-lg btn-round" onclick="Copyconfig('/user/getUserAllURL?type=ssr','#ssr-all-urls','')"><i class="malio-ssr"></i> {$i18n->get('copy-ssr-urls')}</a>
                        {/if}
                      
                        {if (!in_array("copy-vmess",$malio_config['index_hidden_import_buttons']))}
                        <a href="##" id="v2ray-all-urls" class="btn btn-icon icon-left btn-primary btn-v2ray copy-config btn-lg btn-round" onclick="Copyconfig('/user/getUserAllURL?type=v2ray','#v2ray-all-urls','')"><i class="malio-v2rayng"></i> {$i18n->get('copy-vmess-urls')}</a>
                        {/if}
                      </div>
                    </div>
                  </div>
                  {/if}

                </div>
              </div>
        </section>
      </div>
      {else}
      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-body">
                  <h3 class="animated tada mt-5 text-center" style="color:#191d21">👋 Hi, {$user->user_name}</h3>
                  <h5 class="mb-5 mt-2 text-center" style="color:#191d21d5">{$i18n->get('new-user-guide-lead')}</h5>
                  <div class="row mt-4">
                    <div class="col-12 col-lg-8 offset-lg-2">
                      <div class="wizard-steps">
                        <div class="wizard-step wizard-step-active" onclick="location='/user/shop'">
                          <div class="wizard-step-icon">
                            <i class="fas fa-shopping-cart"></i>
                          </div>
                          <div class="wizard-step-label">
                            {$i18n->get('new-user-guide-setp-1')}
                          </div>
                        </div>
                        <div class="wizard-step wizard-step-active" onclick="location='/user/tutorial'">
                          <div class="wizard-step-icon">
                            <i class="fas fa-download"></i>
                          </div>
                          <div class="wizard-step-label">
                            {$i18n->get('new-user-guide-setp-2')}
                          </div>
                        </div>
                        <div class="wizard-step wizard-step-success">
                          <div class="wizard-step-icon">
                            <i class="fas fa-grin-squint"></i>
                          </div>
                          <div class="wizard-step-label">
                            {$i18n->get('new-user-guide-setp-3')}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
      {/if}
      {include file='user/footer.tpl'}
    </div>
  </div>

  {if $malio_config['enable_index_popup_ann'] == true}
  <div class="modal fade" tabindex="-1" role="dialog" id="popup-ann-modal">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">{$i18n->get('important-announcement')}</h5>
        </div>
        <div class="modal-body">
          <p>{$malio_config['index_popup_ann_content']}</p>
        </div>
        <div class="modal-footer bg-whitesmoke br">
          <button type="button" class="btn btn-primary" data-dismiss="modal">{$i18n->get('read')}</button>
        </div>
      </div>
    </div>
  </div>
  {/if}

  {include file='user/scripts.tpl'}

  <!-- Counter Up  -->
  <script src="https://cdn.jsdelivr.net/npm/waypoints@4.0.0/lib/jquery.waypoints.min.js"></script>
  <script src="/theme/malio/js/jquery.counterup.min.js"></script>

  <script src="https://cdn.jsdelivr.net/npm/bowser@1.9.4/bowser.min.js"></script>

  <!-- C3 Chart -->
  <script src="https://cdn.jsdelivr.net/npm/d3@3.5.0/d3.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/c3@0.4.10/c3.min.js"></script>

  <script>
    trafficDountChat(
      '{$user->LastusedTraffic()}',
      '{$user->TodayusedTraffic()}',
      '{$user->unusedTraffic()}',
      '{number_format($user->last_day_t/$user->transfer_enable*100,2)}',
      '{number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100,2)}',
      '{number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100,2)}'
    )

    $('.counter').counterUp({
      delay: 10,
      time: 1000
    });

    function importSublink(client) {
      if (client == 'quantumult') {
        oneclickImport('quantumult', '{if $malio_config["quantumult_sub_type"]=="v2ray"}{$subInfo["quantumult_v2"]}{elseif $malio_config["quantumult_sub_type"]=="ss"}{$subInfo["ss"]}{elseif $malio_config["quantumult_sub_type"]=="ssr"}{$subInfo["ssr"]}{/if}');
      }
      if (client == 'shadowrocket') {
        oneclickImport('shadowrocket','{$subInfo["shadowrocket"]}')
      };
      if (client == 'surfboard') {
        oneclickImport('surfboard','{$subInfo["surfboard"]}')
      };
      if (client == 'surge2') {
        oneclickImport('surge','{$subInfo["surge2"]}')
      };
      if (client == 'surge3') {
        oneclickImport('surge3','{$subInfo["surge3"]}')
      };
      if (client == 'surge4') {
        oneclickImport('surge3','{$subInfo["surge4"]}')
      };
      if (client == 'clash') {
        oneclickImport('clash','{$subInfo["clash"]}')
      };
      if (client == 'ssr') {
        oneclickImport('ssr','{$subInfo["ssr"]}')
      }
    }

    appName = "{$config['appName']}";

    setTimeout(loadTrafficChart(), 3000);
  </script>

  <script>
    function Copyconfig(url, id, jumpurl = "") {
      $.ajax({
        url: url,
        type: 'GET',
        async: false,
        success: function (res) {
          if (res) {
            $("#result").modal();
            $("#msg").html("获取成功");
            $(id).data('data', res);
            console.log(res);
          } else {
            $("#result").modal();
            $("#msg").html("获取失败，请稍后再试");
          }
        }
      });
      const clipboard = new ClipboardJS('.copy-config', {
        text: function () {
          return $(id).data('data');
        }
      });
      clipboard.on('success', function (e) {
        var title = '已复制到您的剪贴板';
        if (jumpurl != '') {
          title = '复制成功，即将跳转到 APP';
        }
        swal({
          type: 'success',
          title: title,
          showConfirmButton: false,
          timer: 1500,
          onClose: () => {
            if (jumpurl != "") {
              window.setTimeout(function () {
                window.location.href = jumpurl;
              }, 1000);
            }
          }
        })
      });
      clipboard.on("error", function (e) {
        console.error('Action:', e.action);
        console.error('Trigger:', e.trigger);
        console.error('Text:', e.text);
      });
    }
  </script>

  {if $malio_config['enable_index_popup_ann'] == true}
  <script>
  {if $malio_config['enable_index_popup_ann_time'] == true}
      function setCookie(name, value) {
          var exp = new Date();
          exp.setTime(exp.getTime() + 1 * 60 * 1000*60*24);
          document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString() + ";path=/";
          }
  
      function ReadCookie(name) {
          var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
          if (arr = document.cookie.match(reg)) return unescape(arr[2]);
          else return null;
          }
          if (ReadCookie("cnxad_lunbo") == "" || ReadCookie("cnxad_lunbo") == null) {
              $('#popup-ann-modal').modal('show');
              setCookie("cnxad_lunbo", "yes");
              }
  {else}
      $('#popup-ann-modal').modal('show');
  {/if}
  </script>
  {/if}
</body>

</html>
