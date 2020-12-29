<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>Android 使用教程 &mdash; {$config["appName"]}</title>

  <style>
    .btn-app {
      background: linear-gradient(to right, #303030, #303030) !important;
      color: white !important;
      border-color: #303030;
      box-shadow: 0 2px 6px #30303063;
      margin-bottom: 16px;
    }

    .card a {
      color: #E91E63;
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
      color: #E91E63;
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
      background-color: #E91E63;
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
            <h1>Android 使用教程</h1>
            {if $malio_config['display_more_app_button'] == true}
            <div class="section-header-breadcrumb">
              <div class="btn-group dropleft">
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  其他客户端
                </button>
                <div class="dropdown-menu dropleft">
                  <a class="dropdown-item has-icon" href="/user/tutorial?os=android&client=ssr"><i class="malio-ssr"></i>SSR</a>
                  <a class="dropdown-item has-icon" href="/user/tutorial?os=android&client=kitsunebi"><i class="malio-kitsunebi"></i>Kitsunebi</a>
                  <a class="dropdown-item has-icon" href="/user/tutorial?os=android&client=v2rayng"><i class="malio-v2rayng"></i>v2rayNG</a>
                </div>
              </div>
            </div>
            {/if}
          </div>
          <div class="section-body">
            <div class="row mt-sm-4">
              <div class="col-12">
                {if !URL::SSCanConnect($user, $mu)}
                <div class="alert alert-warning alert-has-icon">
                  <div class="alert-icon"><i class="fas fa-exclamation-triangle"></i></div>
                  <div class="alert-body">
                    <div class="alert-title">无法使用此客户端</div>
                    您的加密、混淆和协议不兼容 SS 客户端。如需使用，请在 <a href="/user/edit"><u>连接设置</u></a> 页面更改 “加密方式”、“混淆和协议” 为 SS 可连接的选项。
                  </div>
                </div>
                {/if}
                <div class="card">
                  <div class="card-body">
                    <ul class="steps">
                      <li>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">1.</label>
                            <p>下载 Surfboard 客户端。</p>
                            <a href="/client-download/surfboard.apk" class="btn btn-icon icon-left btn-primary btn-app btn-lg btn-round" target="blank"><i class="fas fa-download"></i> 下载客户端</a>
                            <button id="surfboard-download-qrcode" type="button" class="qrcode-btn btn">
                              <i class="fas fa-qrcode"></i>
                            </button>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic hide-on-mobie">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/android-surfboard-1.png">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">2.</label>
                            <p>点击这个按钮 👇👇👇</p>
                            <a href="##" class="btn btn-icon icon-left btn-primary btn-app btn-lg btn-round" onclick="importSublink()"><i class="malio-surfboard"></i> 一键导入 Surfboard 配置</a>
                            <button id="surfboard-qrcode" type="button" class="qrcode-btn btn">
                              <i class="fas fa-qrcode"></i>
                            </button>
                            <p class="text-muted" style="font-size: 13px">一键导入不成功？<a href="#manual-import" class="text-muted "><u>试试手动导入</u> →</a></p>
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
                            <p>选择客户端底栏的 Switch，然后轻点右下角的红色启动按钮即可启用。</p>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/android-surfboard-3.png">
                            </div>
                          </div>
                        </div>
                      </li>
                    </ul>
                  </div>
                </div>
                <div class="text-center">
                  <h3 style="margin-top: 50px;margin-bottom: 30px;">🤔</h3>
                </div>
                <div class="card">
                  <div class="card-body">
                    <div class="faq">
                      <div class="row mt-2">
                        <div id="manual-import" class="col-sm-6 col-xs-12 col-md-6 col-lg-6">
                          <h6>Surfboard 无法一键导入，如何手动导入配置？</h6>
                          <p class="mb-4 font-13">
                            <a href="##" class="copy-text" data-clipboard-text="{$subInfo['surfboard']}{if $malio_config['enable_sub_extend'] == true}&extend=1{/if}" style="color:#E91E63">点此复制 Surfboard 托管配置链接</a>
                            ，选择 Surfboard 底栏第三个的 “Profies”，轻点右下角红色+号按钮，选择 “Dwonload from url”，粘贴托管配置链接。
                          </p>
                        </div>
                        <div class="col-sm-6 col-xs-12 col-md-6 col-lg-6">
                          <h6>Surfboard 如何切换节点？</h6>
                          <p class="mb-4 font-13">
                            选择客户端底栏的 Config，然后选择 Proxy 分组下的节点即可切换节点。
                          </p>
                        </div>
                        <div class="col-sm-6 col-xs-12 col-md-6 col-lg-6">
                          <h6>Surfboard 如何更新节点？</h6>
                          <p class="mb-4 font-13">
                            选择客户端底栏的 Profile，长按顶部的 .bin 文件，选择 Check update 即可更新节点。
                          </p>
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

  <script src="https://cdn.jsdelivr.net/npm/bowser@1.9.4/bowser.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/kjua@0.1.2/dist/kjua.min.js"></script>

  <script>
    var appName = "{$config['appName']}";
    function importSublink() {
      oneclickImport('surfboard', '{$subInfo["surfboard"]}{if $malio_config["enable_sub_extend"] == true}&extend=1{/if}')
    }
    createQRCode('surfboard-download-qrcode', '{$config["baseUrl"]}/client-download/surfboard.apk', '扫描二维码下载客户端')
    createQRCode('surfboard-qrcode', 'surfboard:///install-config?url=' + encodeURIComponent('{$subInfo["surfboard"]}{if $malio_config["enable_sub_extend"] == true}&extend=1{/if}'), '打开Surfboard 👉Profile 👉右下角红色添加按钮 👉Scan qrcode')
  </script>
</body>

</html>