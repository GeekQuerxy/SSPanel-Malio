<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('add-rule')} &mdash; {$config["appName"]}</title>

  <!-- CSS Libraries -->
  <link rel="stylesheet" href="/theme/malio/assets/modules/summernote/summernote-bs4.css">

</head>

<body>
  <div id="app">
    <div class="main-wrapper">
      {include file='user/navbar.tpl'}

      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-header">
            <div class="section-header-back">
              <a href="/user/relay" class="btn btn-icon"><i class="fas fa-arrow-left"></i></a>
            </div>
            <h1>{$i18n->get('add-rule')}</h1>
          </div>

          <div class="section-body">
            <div class="row">
              <div class="col-12">
                <div class="card">
                  <div class="card-body">
                    <div class="form-group">
                      <label>{$i18n->get('relay-server-origin')}</label>
                      <select class="form-control form-control-sm" id="source_node">
                        {foreach $source_nodes as $source_node}
                        <option value="{$source_node->id}">{$source_node->name}</option>
                        {/foreach}
                      </select>
                    </div>
                    <div class="form-group">
                      <label>{$i18n->get('target-server')}</label>
                      <select class="form-control form-control-sm" id="dist_node">
                        <option value="-1">{$i18n->get('no-relay')}</option>
                        {foreach $dist_nodes as $dist_node}
                        <option value="{$dist_node->id}">{$dist_node->name}</option>
                        {/foreach}
                      </select>
                    </div>
                    <div class="form-group">
                      <label>{$i18n->get('port')}</label>
                      <select class="form-control form-control-sm" id="port">
                        {foreach $ports as $port}
                        <option value="{$port}">{$port}</option>
                        {/foreach}
                      </select>
                    </div>
                    <div class="form-group">
                      <label>{$i18n->get('priority')}</label>
                      <input type="number" value="0" class="form-control" id="priority">
                    </div>
                  </div>
                  <div class="card-footer bg-whitesmoke text-md-right">
                    <button class="btn btn-primary" id="add-relay-rule">{$i18n->get('add-rule')}</button>
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