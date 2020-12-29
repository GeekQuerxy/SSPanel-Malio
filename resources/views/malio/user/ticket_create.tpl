<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>{$i18n->get('new-ticket')} &mdash; {$config["appName"]}</title>

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
              <a href="/user/ticket" class="btn btn-icon"><i class="fas fa-arrow-left"></i></a>
            </div>
            <h1>{$i18n->get('new-ticket')}</h1>
          </div>

          <div class="section-body">
            <h2 class="section-title">{$i18n->get('notice')}</h2>
            <p class="section-lead">
              {$i18n->get('new-ticket-notice')}
            </p>

            <div class="row">
              <div class="col-12">
                <div class="card">
                  <div class="card-header">
                    <h4>{$i18n->get('new-ticket')}</h4>
                  </div>
                  <div class="card-body">
                    <div class="form-group row mb-4">
                      <label class="col-form-label text-md-right col-12 col-md-3 col-lg-3">{$i18n->get('title')}</label>
                      <div class="col-sm-12 col-md-7">
                        <input id="title" type="text" class="form-control">
                      </div>
                    </div>
                    <div class="form-group row mb-4">
                      <label class="col-form-label text-md-right col-12 col-md-3 col-lg-3">{$i18n->get('content')}</label>
                      <div class="col-sm-12 col-md-7">
                        <textarea class="form-control" style="height: 200px;" id="ticket-content"></textarea>
                      </div>
                    </div>
                    <div class="form-group row mb-4">
                      <label class="col-form-label text-md-right col-12 col-md-3 col-lg-3"></label>
                      <div class="col-sm-12 col-md-7">
                        <button id="create-ticket" class="btn btn-primary" onclick="createTicket()">{$i18n->get('submit')}</button>
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