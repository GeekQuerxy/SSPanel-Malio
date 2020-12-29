<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('config-history')} &mdash; {$config["appName"]}</title>

</head>

<body>
  <div id="app">
    <div class="main-wrapper">
      {include file='user/navbar.tpl'}

      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>{$i18n->get('config-history')}</h1>
          </div>
          <div class="section-body">
            <h2 class="section-title">{$i18n->get('notice')}</h2>
            <p class="section-lead">{$i18n->get('config-history-notice')}</p>
            <div class="row">
              <div class="col-12">
                <div class="card">
                  <div class="card-body">
                    <div class="table-responsive">
                      <table class="table table-striped table-md">
                        <tbody>
                          <tr>
                            <th>ID</th>
                            <th>{$i18n->get('type')}</th>
                            <th>IP</th>
                            <th>{$i18n->get('location')}</th>
                            <th>{$i18n->get('date')}</th>
                            <th>User-Agent</th>
                          </tr>
                          {if count($logs) == 0}
                          <tr>
                            <td colspan="6"><strong>{$i18n->get('no-config-history-yet')}</strong></td>
                          </tr>
                          {else}
                          {foreach $logs as $log}
                          <tr>
                            <td>#{$log->id}</td>
                            <td>{$log->subscribe_type}</td>
                            <td>{$log->request_ip}</td>
                            {assign var="location" value=$iplocation->getlocation($log->request_ip)}
                            <td>{iconv("gbk", "utf-8//IGNORE", $location.country)} {iconv("gbk", "utf-8//IGNORE", $location.area)}</td>
                            <td>{$log->request_time}</td>
                            <td>{$log->request_user_agent}</td>
                          </tr>
                          {/foreach}
                          {/if}
                        </tbody>
                      </table>
                    </div>
                    <div class="pagination-render float-right">
                      {$logs->render()}
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