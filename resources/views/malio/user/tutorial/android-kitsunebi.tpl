<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>Android 使用教程 &mdash; {$config["appName"]}</title>

  <style>
    .btn-app {
      background: linear-gradient(to right, #f2885b, #e83c9a) !important;
      color: white !important;
      border-color: #f2885b;
      box-shadow: 0 2px 4px #ff567885;
      margin-bottom: 16px;
    }

    .card a {
      color: #ff5678;
    }

    .steps {
      margin: 10px;
      padding: 0px;
    }

    li {
      list-style: none;
    }

    .step-no {
      font-size: 30px;
      font-weight: 700;
      color: #ff5678;
    }

    .right-pic {
      text-align: right;
    }

    .tutorial-pic img {
      border-radius: 5px;
      width: 100%;
      max-width: 24rem;
    }

    @media (max-width: 767px) {
      .right-pic {
        display: block;
      }

      .tutorial-pic img {
        margin-top: 16px;
        border-radius: 5px;
        max-width: 100%;
      }

      .qrcode-btn {
        display: none
      }

      .hide-on-mobie {
        display: none;
      }
    }

    .faq h6 {
      color: #191d21;
    }

    .faq h6:before {
      content: ' ';
      border-radius: 5px;
      height: 6px;
      width: 6px;
      background-color: #ff5678;
      display: inline-block;
      float: left;
      margin-top: 6px;
      margin-right: 8px;
    }

    .faq p {
      font-weight: normal !important;
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
              <a href="/user/tutorial" class="btn btn-icon"><i class="fas fa-arrow-left"></i></a>
            </div>
            <h1>Android 使用教程</h1>
            {if $malio_config['display_more_app_button'] == true}
            <div class="section-header-breadcrumb">
              <div class="btn-group dropleft">
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                其他客户端
                </button>
                <div class="dropdown-menu dropleft">
                    <a class="dropdown-item has-icon" href="/user/tutorial?os=android&client=surfboard"><i class="malio-surfboard"></i>Surfboard</a>
                  <a class="dropdown-item has-icon" href="/user/tutorial?os=android&client=ssr"><i class="malio-ssr"></i>SSR</a>
                  <a class="dropdown-item has-icon" href="/user/tutorial?os=android&client=v2rayng"><i class="malio-v2rayng"></i>v2rayNG</a>
                </div>
              </div>
            </div>
            {/if}
          </div>
          <div class="section-body">
            <div class="row mt-sm-4">
              <div class="col-12">
                <div class="card">
                  <div class="card-body">
                    <ul class="steps">
                      <li>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">1.</label>
                            <p>下载 Kitsunebi 客户端。</p>
                            <a href="/client-download/kitsunebi.apk" class="btn btn-icon icon-left btn-primary btn-app btn-lg btn-round" target="blank"><i class="fas fa-download"></i> 下载客户端</a>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic hide-on-mobie">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/blank-red.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">2.</label>
                            <p>点击右上角 <i class="fas fa-plus"></i> 按钮，选择 “订阅”，再点击右上角 <i class="fas fa-plus"></i> 按钮，备注填写为 “{$config['appName']}”，粘贴 Kitsunebi 订阅链接到URL，然后右上角保存。点击 <i class="fas fa-history" style="transform: rotateY(180deg);"></i> 按钮更新节点列表。</p>
                            <a href="##" class="btn btn-icon icon-left btn-primary btn-app copy-text btn-lg btn-round" data-clipboard-text="{$subInfo['v2ray']}{if $malio_config['enable_sub_extend'] == true}&extend=1{/if}"><i class="malio-kitsunebi"></i> 复制 Kitsunebi 订阅链接</a>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img src="/theme/malio/img/tutorial/blank-red.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">3.</label>
                            <p>返回主界面，点击右上角 <i class="fas fa-plus"></i> 按钮，选择 “规则集”。再点击右上角 <i class="fas fa-plus"></i> 按钮，选择 “新建”，点击列表第一个的 <i class="fas fa-pen"></i> 按钮，点击右上角 <i class="fas fa-plus"></i> 按钮，选择 “设置更新URL”，粘贴远程规则集链接。</p>
                            <a href="##" class="btn btn-icon icon-left btn-primary btn-app copy-text btn-lg btn-round" data-clipboard-text="https://raw.githubusercontent.com/ConnersHua/Profiles/master/Kitsunebi/Basic.conf"><i class="malio-kitsunebi"></i> 复制远程规则集链接</a>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/blank-red.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">4.</label>
                            <p>返回主界面，选择任一节点，点击右下角启动按钮即可启动代理。</p>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/blank-red.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                    </ul>
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