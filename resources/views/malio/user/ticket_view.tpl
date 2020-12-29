<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('view-ticket')} &mdash; {$config["appName"]}</title>

  <!-- CSS Libraries -->
  <link rel="stylesheet" href="/theme/malio/assets/modules/summernote/summernote-bs4.css">

  <style>
    .tickets .ticket-content {
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
            <div class="section-header-back">
              <a href="/user/ticket" class="btn btn-icon"><i class="fas fa-arrow-left"></i></a>
            </div>
            <h1>{$i18n->get('view-ticket')}</h1>
          </div>
          <div class="section-body">
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-body">
                    <div class="tickets">
                      <div class="ticket-content">

                        {if $ticket_status==1}
                        <div class="ticket-form">
                          <div class="form-group">
                            <textarea class="form-control" placeholder="" style="height: 200px;" id="ticket-content"></textarea>
                          </div>
                          <div class="form-group text-right">
                            <button id="ticket-reply" onclick="replyTicket({$id})" class="btn btn-primary btn-lg mr-2">
                              {$i18n->get('reply-ticket')}
                            </button>
                            <button id="close_directly" onclick="closeTicket({$id})" class="btn btn-warning btn-lg">
                              {$i18n->get('close-ticket')}
                            </button>
                          </div>
                        </div>
                        {/if}

                        {foreach $ticketset as $ticket}
                        <div class="ticket-header mt-4">
                          <div class="ticket-sender-picture img-shadow">
                            <img src="{$ticket->User()->gravatar}" alt="image">
                          </div>
                          <div class="ticket-detail">
                            <div class="ticket-title">
                              <h4>{$ticket->User()->user_name}</h4>
                            </div>
                            <div class="ticket-info">
                              <div class="text-muted font-weight-600">{$ticket->datetime()}</div>
                            </div>
                          </div>
                        </div>
                        <div class="ticket-description">
                          {$ticket->content}
                        </div>
                        <div class="ticket-divider"></div>
                        {/foreach}
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