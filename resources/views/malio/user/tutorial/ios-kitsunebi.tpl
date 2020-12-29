<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>iOS 使用教程 &mdash; {$config["appName"]}</title>

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

    .qrcode-btn {
      color: #a2a2a2;
      margin-left: 2px;
      background: none;
      margin-bottom: 16px;
    }

    .qrcode-btn:hover,
    .qrcode-btn:active,
    .qrcode-btn:focus {
      color: black;
      border-color: none;
      box-shadow: none;
      background: none;
    }

    .qrcode-btn i {
      vertical-align: -1px !important;
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
            <h1>iOS 使用教程</h1>
            {if $malio_config['display_more_app_button'] == true}
            <div class="section-header-breadcrumb">
              <div class="btn-group dropleft">
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  其他客户端
                </button>
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
                            {if $malio_config['enable_ios_apple_id'] == true}
                            <p>在 App Store 登录本站提供的美区 Apple ID 下载客户端。<br>
                              为了保护您的隐私，请勿在手机设置里直接登录，仅在 App Store 登录即可。
                            </p>
                            {if $user->class>0}
                            <p>Apple ID：<a class="copy-text" data-clipboard-text="{$malio_config['ios_apple_id']}" href="##">{$malio_config['ios_apple_id']}</a><br>
                              密码：<a class="copy-text" data-clipboard-text="{$malio_config['ios_apple_id_password']}" href="##">********(点击复制)</a></p>
                            {else}
                            <p>购买会员计划后，刷新本页即可看到免费提供的 Apple ID。</p>
                            {/if}
                            {else}
                            <p>这是一个付费软件，你需要购买才能使用。</p>
                            {/if}
                            <a href="https://apps.apple.com/us/app/kitsunebi-proxy-utility/id1446584073" class="btn btn-icon icon-left btn-primary btn-app btn-lg btn-round" target="blank"><i class="fab fa-apple"></i> 打开 App Store 下载</a>
                            <button id="kitsunebi-download-qrcode" type="button" class="qrcode-btn btn">
                              <i class="fas fa-qrcode"></i>
                            </button>
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
                            <p>打开 Kitsunebi，点击底部导航栏的「服务器」进入服务器页面。点击右上角的加号，从弹出菜单中选择第四个「订阅」。在「备注」中输入本站名称，随后在「URL」中粘贴上方 获取订阅 中您需要使用的订阅类型，打开自动更新的开关，随后点击右上角储存。</p>
                            <a href="##" class="btn btn-icon icon-left btn-primary btn-app btn-lg btn-round copy-text" data-clipboard-text="{$subInfo['kitsunebi']}{if $malio_config['enable_sub_extend'] == true}&extend=1{/if}"><i class="malio-kitsunebi"></i> 复制 Kitsunebi 托管配置链接</a>
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
                            <p>点击本站订阅名称旁的感叹号进入订阅页面，随后点击「从 URL 更新」，此时会自动更新获取服务器。</p>
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
                            <p>将服务器页面的「操作模式」更改为 Rule。在订阅组中选择您需要的节点，随后点击底部导航栏的「状态」进入状态页面，打开开关即可。</p>
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
  <script src="https://cdn.jsdelivr.net/npm/kjua@0.1.2/dist/kjua.min.js"></script>
  <script>
  createQRCode('kitsunebi-download-qrcode', 'https://apps.apple.com/us/app/kitsunebi-proxy-utility/id1446584073','扫描二维码下载客户端')
  </script>

</body>

</html>