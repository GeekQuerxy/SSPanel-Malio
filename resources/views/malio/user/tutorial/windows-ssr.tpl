<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>Windows 使用教程 &mdash; {$config["appName"]}</title>

  <style>
    .btn-app {
      background: linear-gradient(to right, #e780a3, #e780a3) !important;
      color: white !important;
      border-color: #e780a3;
      box-shadow: 0 2px 6px #e780a2b0;
      margin-bottom: 16px;
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
      color: #e780a3;
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
      background-color: #e780a3;
      display: inline-block;
      float: left;
      margin-top: 6px;
      margin-right: 8px;
    }

    .faq p {
      font-weight: normal !important;
    }

    .card a {
      color: #e780a3;
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
            <h1>Windows 使用教程</h1>
            {if $malio_config['display_more_app_button'] == true || $malio_config['enable_windows_gaming_tutorial'] == true}
            <div class="section-header-breadcrumb">
              {if $malio_config['enable_windows_gaming_tutorial'] == true}
              <div id="checkin-div" class="breadcrumb-item active">
                <a href="/user/tutorial?os=windows&client=netch" class="btn btn-icon icon-left btn-primary {if $malio_config['display_more_app_button'] == true}mr-2{/if}"><i class="fas fa-gamepad"></i> 游戏加速教程</a>
              </div>
              {/if}
              {if $malio_config['display_more_app_button'] == true}
              <div class="btn-group dropleft">
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  其他客户端
                </button>
                <div class="dropdown-menu dropleft">
                  <a class="dropdown-item has-icon" href="/user/tutorial?os=windows&client=cfw"><i class="malio-clash"></i>Clash for Windows</a>
                </div>
              </div>
              {/if}
            </div>
            {/if}
          </div>
          <div class="section-body">
            <div class="row mt-sm-4">
              <div class="col-12">
                {if !URL::SSRCanConnect($user, $mu)}
                <div class="alert alert-warning alert-has-icon">
                  <div class="alert-icon"><i class="fas fa-exclamation-triangle"></i></div>
                  <div class="alert-body">
                    <div class="alert-title">无法使用此客户端</div>
                    您的加密、混淆和协议不兼容 SSR 客户端。如需使用，请在 <a href="/user/edit"><u>连接设置</u></a> 页面更改 “加密方式”、“混淆和协议” 为 SSR 可连接的选项。
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
                            <p>下载 SSR 客户端，解压后以管理员身份运行 ShadowsocksR-dotnet4.0.exe。若系统提示需要安装 .NET Framework，请<a href="https://www.microsoft.com/net/download/dotnet-framework-runtime" target="blank">点此</a>访问微软官网下载安装。</p>
                            <a href="/client-download/ssr.7z" class="btn btn-icon icon-left btn-primary btn-app btn-lg btn-round" target="blank"><i class="fas fa-download"></i> 下载客户端</a>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic hide-on-mobie">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/windows-ssr-1.jpg">
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
                            <a href="##" class="btn btn-icon icon-left btn-primary btn-app btn-lg btn-round" onclick="importSublink('ssr')"><i class="malio-ssr"></i> 一键导入订阅链接到 SSR</a>
                            <p class="text-muted" style="font-size: 13px">一键导入不成功？<a href="#manual-import" class="text-muted "><u>试试手动导入</u> →</a></p>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img src="/theme/malio/img/tutorial/windows-ssr-2.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">3.</label>
                            <p>再次右键点击小飞机，选择 “服务器订阅” > “更新SSR服务器订阅(不通过代理)”</p>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/windows-ssr-3.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">4.</label>
                            <p>右键点击小飞机，选择 “服务器” > “{$config['appName']}”，可随意切换节点。选择节点后即可正常使用。</p>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/windows-ssr-4.jpg">
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
                      <div class="row mt-2 mb-2">
                        <div class="col-sm-6 col-xs-12 col-md-6 col-lg-6" id="manual-import">
                          <h6>SSR 无法一键导入，如何手动导入配置？</h6>
                          <p class="mb-4 font-13">
                            <a href="##" class="copy-text" data-clipboard-text="{$subInfo['ssr']}{if $malio_config['enable_sub_extend'] == true}&extend=1{/if}">点此复制 SSR 订阅链接</a>，在状态栏找到小飞机，右键点击，选中 “服务器订阅” > “SSR服务器订阅设置”，添加并粘贴订阅链接。
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

  <script>
    function importSublink(client) {
      if (client == 'ssr') {
        oneclickImport('ssr', '{$subInfo["ssr"]}{if $malio_config["enable_sub_extend"] == true}&extend=1{/if}')
      };
    }
    appName = "{$config['appName']}";
  </script>
</body>

</html>