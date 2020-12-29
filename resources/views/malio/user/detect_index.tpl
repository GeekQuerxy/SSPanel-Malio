<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('audit-rules')} &mdash; {$config["appName"]}</title>

</head>

<body>
  <div id="app">
    <div class="main-wrapper">
      {include file='user/navbar.tpl'}

      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>{$i18n->get('audit-rules')}</h1>
          </div>
          <div class="section-body">
            <h2 class="section-title">{$i18n->get('notice')}</h2>
            <p class="section-lead">{$i18n->get('audit-rules-notice')}</p>
            <div class="row">
              <div class="col-12">
                <div class="card">
                  <div class="card-header">
                    <h4>{$i18n->get('rules')}</h4>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive">
                      <table class="table table-striped">
                        <tr>
                          <th>ID</th>
                          <th>{$i18n->get('name')}</th>
                          <th>{$i18n->get('description')}</th>
                          <th>{$i18n->get('regex')}</th>
                          <th>{$i18n->get('type')}</th>
                        </tr>
                        {foreach $rules as $rule}
                        <tr>
                          <td>#{$rule->id}</td>
                          <td>{$rule->name}</td>
                          <td>{$rule->text}</td>
                          <td>{$rule->regex}</td>
                          {if $rule->type == 1}
                          <td>数据包明文匹配</td>
                          {/if}
                          {if $rule->type == 2}
                          <td>数据包 hex 匹配</td>
                          {/if}
                        </tr>
                        {/foreach}
                      </table>
                    </div>
                    <div class="pagination-render float-right">
                      {$rules->render()}
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