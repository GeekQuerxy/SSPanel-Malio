<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('my-tickets')} &mdash; {$config["appName"]}</title>
  <style>
    .table-links a {
      font-weight: normal;
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
            <h1>{$i18n->get('my-tickets')}</h1>
            <div class="section-header-breadcrumb">
              <a href="/user/ticket/create" class="btn btn-primary btn-icon icon-left"><i class="fas fa-plus"></i> {$i18n->get('new-ticket')}</a>
            </div>
          </div>
          <div class="section-body">
            <div class="row">
              <div class="col-12">
                <div class="card">
                  <div class="card-body">

                    <div class="table-responsive">
                      <table class="table table-striped">
                        <tbody>
                          <tr>
                            <th>{$i18n->get('title')}</th>
                            <th>{$i18n->get('create-at')}</th>
                            <th>{$i18n->get('status')}</th>
                            <th>{$i18n->get('action')}</th>
                          </tr>
                          {foreach $tickets as $ticket}
                          <tr>
                            <td>
                              <a href="/user/ticket/{$ticket->id}/view" style="color:#6a757e">{$ticket->title}</a>
                            </td>
                            <td>{$ticket->datetime()}</td>
                            <td>
                              {if $ticket->status==1}
                              <div class="badge badge-success">{$i18n->get('ticket-open')}</div>
                              {else}
                              <div class="badge badge-secondary">{$i18n->get('ticket-closed')}</div>
                              {/if}
                            </td>
                            <td>
                                {if $ticket->status==1}
                                <a href="/user/ticket/{$ticket->id}/view" class="btn btn-primary">{$i18n->get('reply-ticket')}</a>
                                <a href="##" onclick="closeTicket({$ticket->id})" class="btn btn-secondary ml-1">{$i18n->get('close-ticket')}</a>
                                {else}
                                <a href="/user/ticket/{$ticket->id}/view" class="btn btn-secondary">{$i18n->get('view-ticket')}</a>
                                {/if}
                            </td>
                          </tr>
                          {/foreach}
                        </tbody>
                      </table>
                      <div class="pagination-render float-right">
                        {$tickets->render()}
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