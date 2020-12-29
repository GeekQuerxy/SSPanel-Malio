<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('relay-settings')} &mdash; {$config["appName"]}</title>

</head>

<body>
  <div id="app">
    <div class="main-wrapper">
      {include file='user/navbar.tpl'}

      <!-- Main Content -->
      <div class="main-content">
        <section class="section">
          <div class="section-header">
            <h1>{$i18n->get('relay-settings')}</h1>
            <div class="section-header-breadcrumb">
              <a href="/user/relay/create" class="btn btn-primary btn-icon icon-left"><i class="fas fa-plus"></i> {$i18n->get('add-rule')}</a>
            </div>
          </div>
          <div class="section-body">
            <h2 class="section-title">{$i18n->get('notice')}</h2>
            <p class="section-lead">
              {$i18n->get('relay-notice')}
            </p>
            <div class="row">
              <div class="col-12">
                <div class="card">
                  <div class="card-header">
                    <h4>{$i18n->get('all-rules')}</h4>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <div class="col-12 col-sm-12 col-md-2">
                        <ul class="nav nav-pills flex-column" id="myTab4" role="tablist">
                          <li class="nav-item">
                            <a class="nav-link active show" id="home-tab4" data-toggle="tab" href="#home4" role="tab" aria-controls="home" aria-selected="true">{$i18n->get('rules-table')}</a>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link" id="profile-tab4" data-toggle="tab" href="#profile4" role="tab" aria-controls="profile" aria-selected="false">{$i18n->get('relay-table')}</a>
                          </li>
                        </ul>
                      </div>
                      <div class="col-12 col-sm-12 col-md-10">
                        <div class="tab-content no-padding" id="myTab2Content">
                          <div class="tab-pane fade active show" id="home4" role="tabpanel" aria-labelledby="home-tab4">
                            <div class="table-responsive">
                              <table class="table table-striped">
                                <tr>
                                  <th>{$i18n->get('relay-server-origin')}</th>
                                  <th>{$i18n->get('target-server')}</th>
                                  <th>{$i18n->get('port')}</th>
                                  <th>{$i18n->get('priority')}</th>
                                  <th>{$i18n->get('action')}</th>
                                </tr>
                                {if count($rules) == 0}
                                <tr>
                                  <td colspan="5"><strong>{$i18n->get('no-relay-rule')}</strong></td>
                                </tr>
                                {else}
                                {foreach $rules as $rule}
                                <tr>
                                  {if $rule->source_node_id == 0}
                                  <td>所有节点</td>
                                  {else}
                                  <td>{$rule->Source_Node()->name}</td>
                                  {/if}
                                  {if $rule->Dist_Node() == null}
                                  <td>不进行中转</td>
                                  {else}
                                  <td>{$rule->Dist_Node()->name}</td>
                                  {/if}
                                  <td>{if $rule->port == 0}所有端口{else}{$rule->port}{/if}</td>
                                  <td>{$rule->priority}</td>
                                  <td>
                                    {if $rule->user_id != 0}
                                    <a href="/user/relay/{$rule->id}/edit" class="btn btn-primary">{$i18n->get('edit')}</a>
                                    {/if}
                                    <a href="##" onclick="deleteRelayRule('{$rule->id}')" class="btn btn-secondary {if $rule->user_id != 0}ml-1{/if}">{$i18n->get('delete')}</a>
                                  </td>
                                </tr>
                                {/foreach}
                                {/if}
                              </table>
                              {$rules->render()}
                            </div>
                          </div>
                          <div class="tab-pane fade" id="profile4" role="tabpanel" aria-labelledby="profile-tab4">
                            <div class="table-responsive">
                              <table class="table table-striped">
                                <tr>
                                  <th>{$i18n->get('port')}</th>
                                  <th>{$i18n->get('relay-server-origin')}</th>
                                  <th>{$i18n->get('target-server')}</th>
                                  <th>{$i18n->get('relay-server-in-between')}</th>
                                  <th>{$i18n->get('status')}</th>
                                </tr>
                                {if count($pathset) == 0}
                                <tr>
                                  <td colspan="5"><strong>{$i18n->get('no-relay-info')}</strong></td>
                                </tr>
                                {else}
                                {foreach $pathset as $path}
                                <tr>
                                  <td>{$path->port}</td>
                                  <td>{$path->begin_node->name}</td>
                                  <td>{$path->end_node->name}</td>
                                  <td>{$path->path}</td>
                                  <td>
                                    <div class="badge badge-{if $path->status == '通畅'}success{else}danger{/if}">{$path->status}</div>
                                  </td>
                                </tr>
                                {/foreach}
                                {/if}
                              </table>
                              {$rules->render()}
                            </div>
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
      {include file='user/footer.tpl'}
    </div>
  </div>

  {include file='user/scripts.tpl'}

</body>

</html>