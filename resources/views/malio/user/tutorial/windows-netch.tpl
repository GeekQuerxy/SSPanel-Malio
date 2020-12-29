<!DOCTYPE html>
<html lang="en">

<head>
  {include file='user/head.tpl'}

  <title>Windows 游戏加速教程 &mdash; {$config["appName"]}</title>

  <style>
    .btn-app {
      background: linear-gradient(to right, #2669b5, #2d97d5) !important;
      color: white !important;
      border-color: #2d97d5;
      box-shadow: 0 2px 6px #2d97d5b0;
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
      color: #2975bd;
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
      background-color: #2975bd;
      display: inline-block;
      float: left;
      margin-top: 6px;
      margin-right: 8px;
    }

    .faq p {
      font-weight: normal !important;
    }

    .card a {
      color: #2975bd;
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
            <h1>Windows 游戏加速教程</h1>
            {if $malio_config['display_more_app_button'] == true}
            <div class="section-header-breadcrumb">
              <div class="btn-group dropleft">
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  其他客户端
                </button>
                <div class="dropdown-menu dropleft">
                  <a class="dropdown-item has-icon" href="/user/tutorial?os=windows&client=cfw"><i class="malio-clash"></i>Clash for Windows</a>
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
                            <p>下载 Netch 客户端，解压后以管理员身份运行 Netch.exe。若系统提示需要安装 .NET Framework，请<a href="https://www.microsoft.com/net/download/dotnet-framework-runtime" target="blank">点此</a>访问微软官网下载安装。</p>
                            <a href="/client-download/netch.7z" class="btn btn-icon icon-left btn-primary btn-app btn-lg btn-round" target="blank"><i class="fas fa-download"></i> 下载客户端</a>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic hide-on-mobie">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/windows-netch-1.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">2.</label>
                            <p>打开程序后，选中 “订阅” > “管理订阅链接”</p>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img src="/theme/malio/img/tutorial/windows-netch-2.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">2.</label>
                            <p>粘贴订阅链接到左下角的链接，备注填写为，点击添加，然后点击保存</p>
                            {if (in_array("ssr",$malio_config['support_sub_type']))}
                            <a href="##" class="btn btn-icon icon-left btn-primary btn-app copy-text btn-lg btn-round" data-clipboard-text="{$subInfo['ssr']}{if $malio_config['enable_sub_extend'] == true}&extend=1{/if}"><i class="malio-ssr"></i> 复制 SSR 订阅链接</a>
                            {/if}
                            {if (in_array("v2ray",$malio_config['support_sub_type']))}
                            <a href="##" class="btn btn-icon icon-left btn-primary btn-app copy-text btn-lg btn-round" data-clipboard-text="{$subInfo['v2ray']}{if $malio_config['enable_sub_extend'] == true}&extend=1{/if}"><i class="malio-v2ray"></i> 复制 V2Ray 订阅链接</a>
                            {/if}
                            {if (in_array("ss",$malio_config['support_sub_type']))}
                            <a href="##" class="btn btn-icon icon-left btn-primary btn-app copy-text btn-lg btn-round" data-clipboard-text="{$subInfo['ss']}{if $malio_config['enable_sub_extend'] == true}&extend=1{/if}"><i class="malio-ssr"></i> 复制 SS 订阅链接</a>
                            {/if}
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img src="/theme/malio/img/tutorial/windows-netch-3.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">3.</label>
                            <p>如果需要加速的游戏不在列表里面，那么就选中 “模式” > “创建进程模式”</p>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/windows-netch-4.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">4.</label>
                            <p>点击 “扫描” 选取你游戏安装目录后选择确定即可添加，点击保存即可选择应用此模式</p>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/windows-netch-6.jpg">
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <hr>
                        <div class="row">
                          <div class="left-text col-xs-12 col-md-6 col-lg-6">
                            <label class="step-no">5.</label>
                            <p>最后选择模式，点击启动即可使用。</p>
                          </div>
                          <div class="right-pic col-xs-12 col-md-6 col-lg-6">
                            <div class="tutorial-pic">
                              <img style="border:1px solid #f0f0f0" src="/theme/malio/img/tutorial/windows-netch-7.jpg">
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