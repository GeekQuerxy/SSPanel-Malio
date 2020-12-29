<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('server-settings')} &mdash; {$config["appName"]}</title>

</head>

<body>
  <div id="app">
    <div class="main-wrapper">
      {include file='user/navbar.tpl'}

      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>{$i18n->get('server-settings')}</h1>
          </div>
          <div class="section-body">
            <h2 class="section-title">{$i18n->get('notice')}</h2>
            <p class="section-lead">
              {$i18n->get('server-settings-notice')}
            </p>

            <div id="output-status"></div>
            <div class="row">
              <div class="col-md-4">
                <div class="card">
                  <div class="card-header">
                    <h4>Jump to</h4>
                  </div>
                  <div class="card-body">
                    <ul class="nav nav-pills flex-column" id="settings" role="tablist">
                      <li class="nav-item"><a class="nav-link active" id="password-tab" data-toggle="tab" href="#password" role="tab" aria-controls="password" aria-selected="true">{$i18n->get('server-password')}</a></li>
                      {if $malio_config['enable_method'] == true}<li class="nav-item"><a class="nav-link" id="method-tab" data-toggle="tab" href="#method" role="tab" aria-controls="method" aria-selected="false">{$i18n->get('encryption')}</a></li>{/if}
                      {if $malio_config['enable_protocol'] == true}<li class="nav-item"><a class="nav-link" id="protocol-tab" data-toggle="tab" href="#protocol" role="tab" aria-controls="protocol" aria-selected="false">{$i18n->get('protocol-and-obfs')}</a></li>{/if}
                      <li class="nav-item"><a class="nav-link" id="resetlink-tab" data-toggle="tab" href="#resetlink" role="tab" aria-controls="resetlink" aria-selected="false">{$i18n->get('reset-config-url')}</a></li>
                      {if $malio_config['enable_reset_port'] == true && $config['port_price'] >= 0}<li class="nav-item"><a class="nav-link" id="resetport-tab" data-toggle="tab" href="#resetport" role="tab" aria-controls="resetport" aria-selected="false">{$i18n->get('reset-port')}</a></li>{/if}
                    </ul>
                  </div>
                </div>
              </div>
              <div class="col-md-8">
                <div class="tab-content no-padding" id="settings2Content">
                  <div class="tab-pane fade active show" id="password" role="tabpanel" aria-labelledby="password-tab">
                    <div class="card">
                      <div class="card-header">
                        <h4>{$i18n->get('server-password')}</h4>
                      </div>
                      <div class="card-body">
                        <p>{$i18n->get('server-password-desc')}<br>{$i18n->get('current-server-password')}: <code id="ss-current-password">{$user->passwd}</code></p>
                        <div class="form-group">
                          <div class="input-group mb-3">
                            <input id="ss-password" type="text" class="form-control" placeholder="{$i18n->get('enter-new-server-password')}" aria-label="">
                            <div class="input-group-append">
                              <button id="ss-random-password" class="btn btn-warning" type="button">{$i18n->get('ramdom-password')}</button>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="card-footer bg-whitesmoke text-md-right">
                        <button id="ss-password-confirm" class="btn btn-primary">{$i18n->get('apply-changes')}</button>
                      </div>
                    </div>
                  </div>
                  {if $malio_config['enable_method'] == true}
                  <div class="tab-pane fade" id="method" role="tabpanel" aria-labelledby="method-tab">
                    <div class="card">
                      <div class="card-header">
                        <h4>{$i18n->get('encryption')}</h4>
                      </div>
                      <div class="card-body">
                        <p>{$i18n->get('encryption-desc')}<br>
                          {$i18n->get('current-encryption')}: <code id="current-method">[{if URL::CanMethodConnect($user->method) == 2}SS/SSD{else}SS/SSR{/if}] {$user->method}</code>
                        </p>
                        <div class="form-group">
                          <select id="method-select" class="form-control">
                            {$method_list = $config_service->getSupportParam('method')}
                            {foreach $method_list as $method}
                            <option value="{$method}">[{if URL::CanMethodConnect($method) == 2}SS/SSD{else}SS/SSR{/if}] {$method}</option>
                            {/foreach}
                          </select>
                        </div>
                      </div>
                      <div class="card-footer bg-whitesmoke text-md-right">
                        <button id="method-confirm" class="btn btn-primary">{$i18n->get('apply-changes')}</button>
                      </div>
                    </div>
                  </div>
                  {/if}
                  {if $malio_config['enable_protocol'] == true}
                  <div class="tab-pane fade" id="protocol" role="tabpanel" aria-labelledby="protocol-tab">
                    <div class="card">
                      <div class="card-header">
                        <h4>{$i18n->get('protocol-and-obfs')}</h4>
                      </div>
                      <div class="card-body">
                        <p>{$i18n->get('protocol-desc')}
                          {$i18n->get('current-protocol')}: <code id="current-protocol">[{if URL::CanProtocolConnect($user->protocol) == 3}SS/SSD/SSR{else}SSR{/if}] {$user->protocol}</code>
                        </p>
                        <div class="form-group">
                          <select id="protocol-selection" class="form-control">
                            {$protocol_list = $config_service->getSupportParam('protocol')}
                            {foreach $protocol_list as $protocol}
                            <option value="{$protocol}">[{if URL::CanProtocolConnect($protocol) == 3}SS/SSD/SSR{else}SSR{/if}] {$protocol}</option>
                            {/foreach}
                          </select>
                        </div>
                      </div>
                      <hr>
                      <div class="card-body">
                        <p>{$i18n->get('obfs-desc')}
                          {$i18n->get('current-obfs')}: <code id="current-obfs">[{if URL::CanObfsConnect($user->obfs) >= 3}SS/SSD/SSR{elseif URL::CanObfsConnect($user->obfs) == 1}SSR{else}SS/SSD{/if}] {$user->obfs}</code>
                        </p>
                        <div class="form-group">
                          <select id="obfs" class="form-control">
                            {$obfs_list = $config_service->getSupportParam('obfs')}
                            {foreach $obfs_list as $obfs}
                            <option value="{$obfs}">[{if URL::CanObfsConnect($obfs) >= 3}SS/SSD/SSR{else}{if URL::CanObfsConnect($obfs) == 1}SSR{else}SS/SSD{/if}{/if}] {$obfs}</option>
                            {/foreach}
                          </select>
                        </div>
                      </div>
                      <hr>
                      <div class="card-body">
                        <p>{$i18n->get('current-obfs-param')}: <code id="current-obfs-param">{$user->obfs_param}</code>
                        </p>
                        <div class="form-group">
                          <input id="obfs-param" type="text" class="form-control" placeholder="{$i18n->get('enter-your-obfs-param')}" aria-label="">
                        </div>
                      </div>
                      <div class="card-footer bg-whitesmoke text-md-right">
                        <button id="protocol-obfs-confirm" class="btn btn-primary">{$i18n->get('apply-changes')}</button>
                      </div>
                    </div>
                  </div>
                  {/if}
                  <div class="tab-pane fade" id="resetlink" role="tabpanel" aria-labelledby="resetlink-tab">
                    <div class="card">
                      <div class="card-header">
                        <h4>{$i18n->get('reset-config-url')}</h4>
                      </div>
                      <div class="card-body">
                        <p>{$i18n->get('reset-config-url-desc')}</p>
                        {$i18n->get('currnt-config-url')}: <code>{$config['subUrl']}{$ssr_sub_token}</code>
                      </div>
                      <div class="card-footer bg-whitesmoke text-md-right">
                        <button id="reset-sub-link" class="btn btn-danger">{$i18n->get('reset')}</button>
                      </div>
                    </div>
                  </div>
                  {if $malio_config['enable_reset_port'] == true && $config['port_price'] >= 0}
                  <div class="tab-pane fade" id="resetport" role="tabpanel" aria-labelledby="resetport-tab">
                    <div class="card">
                      <div class="card-header">
                        <h4>{$i18n->get('reset-port')}</h4>
                      </div>
                      <div class="card-body">
                        <p>{$i18n->get('reset-port-desc')}</p>
                        <p>{$i18n->get('current-port')}: <code id="current-port">{$user->port}</code></p>
                      </div>
                      <div class="card-footer bg-whitesmoke text-md-right">
                        <button id="reset-port-confirm" class="btn btn-primary">{$i18n->get('submit')}</button>
                      </div>
                    </div>
                    {if $config['port_price_specify']>=0}
                    <div class="card">
                      <div class="card-header">
                        <h4>{$i18n->get('customize-port')}</h4>
                      </div>
                      <div class="card-body">
                        <p>{$i18n->get('customize-port-desc',[$config['port_price_specify'], $config['min_port'],$config['max_port']])}</p>
                        <p>{$i18n->get('current-port')}: <code id="current-port-2">{$user->port}</code></p>

                        <div class="form-group">
                          <input id="port-specify" type="text" class="form-control" placeholder="{$i18n->get('customize-port-input-placeholder')}" aria-label="">
                        </div>
                      </div>
                      <div class="card-footer bg-whitesmoke text-md-right">
                        <button id="portspecify" class="btn btn-primary">{$i18n->get('submit')}</button>
                      </div>
                    </div>
                    {/if}
                  </div>
                  {/if}
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