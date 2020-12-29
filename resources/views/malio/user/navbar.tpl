<div class="navbar-bg"></div>
<nav class="navbar navbar-expand-lg main-navbar">
  <form class="form-inline mr-auto">
    <ul class="navbar-nav mr-3">
      <li><a href="#" data-toggle="sidebar" class="nav-link nav-link-lg"><i class="fas fa-bars"></i></a></li>
    </ul>
  </form>
  <ul class="navbar-nav navbar-right">
    {if $malio_config['enable_i18n'] == true}
    <li class="dropdown dropdown-list-toggle"><a href="#" data-toggle="dropdown" class="nav-link nav-link-lg nav-link-user"><i class="fas fa-language" style="vertical-align: -2px; padding-right: 2px;"></i> {if $i18n->lang == 'en'}English{else}简体中文{/if}</a>
      <div class="dropdown-menu dropdown-menu-right">
        <a href="##" class="dropdown-item has-icon" onclick="changeLang('en')">
          🇬🇧 English
        </a>
        <a href="##" class="dropdown-item has-icon" onclick="changeLang('zh-cn')">
          🇨🇳 简体中文
        </a>
      </div>
    </li>
    {else}
    <li class="dropdown dropdown-list-toggle"></li>
    {/if}
    <li class="dropdown"><a href="#" data-toggle="dropdown" class="nav-link dropdown-toggle nav-link-lg nav-link-user">
        <img alt="image" src="{$user->gravatar}?d=retro" class="rounded-circle mr-1">
        <div class="d-sm-none d-lg-inline-block">Hi, {$user->user_name}</div>
      </a>
      <div class="dropdown-menu dropdown-menu-right">
        <a href="/user/profile" class="dropdown-item has-icon">
          <i class="fas fa-user"></i> {$i18n->get('my-account')}
        </a>
        {if $malio_config['enable_wallet'] == true}
        <a href="/user/code" class="dropdown-item has-icon">
          <i class="fas fa-wallet"></i> {$i18n->get('wallet')}
        </a>
        {/if}
        {if $malio_config['enable_invite'] == true && $user->class >=0}
        <a href="/user/invite" class="dropdown-item has-icon">
          <i class="fas fa-laugh-squint"></i> {$i18n->get('aff')}
        </a>
        {/if}
        <div class="dropdown-divider"></div>
        <a href="/user/logout" class="dropdown-item has-icon text-danger">
          <i class="fas fa-sign-out-alt"></i> {$i18n->get('logout')}
        </a>
      </div>
    </li>
  </ul>
</nav>
<div class="main-sidebar sidebar-style-2">
  <aside id="sidebar-wrapper">
    <div class="sidebar-brand">
      <a href="/">{$I18N["appName"][$i18n->lang]}</a>
    </div>
    <div class="sidebar-brand sidebar-brand-sm">
      <a href="/">{$malio_config["small_brand"]}</a>
    </div>
    <ul class="sidebar-menu">
      <li><a class="nav-link" href="/user"><i class="fab fa-fort-awesome"></i> <span>{$i18n->get('dashboard')}</span></a></li>
      <li><a class="nav-link" href="/user/shop"><i class="fas fa-store"></i> <span>{$i18n->get('store')}</span></a></li>
      <li class="menu-header">{$i18n->get('my')}</li>
      <li><a class="nav-link" href="/user/profile"><i class="fas fa-user"></i> <span>{$i18n->get('my-account')}</span></a></li>
      {if $malio_config['enable_wallet'] == true}
      <li><a class="nav-link" href="/user/code"><i class="fas fa-wallet"></i> <span>{$i18n->get('wallet')}</span></a></li>
      {/if}
      {if $malio_config['enable_invite'] == true && $user->class >=0}
      <li><a class="nav-link" href="/user/invite"><i class="fas fa-laugh-squint"></i> <span>{$i18n->get('aff')}</span></a></li>
      {/if}
      <li class="menu-header">{$i18n->get('usage')}</li>
      <li><a class="nav-link" href="/user/node"><i class="fas fa-server"></i> <span>{$i18n->get('servers')}</span></a></li>
      <li><a class="nav-link" href="/user/tutorial"><i class="fas fa-book"></i> <span>{$i18n->get('apps-and-tutorial')}</span></a></li>
      {if $malio_config['enable_user_sub_log'] == true && $user->class >=0}
      <li><a class="nav-link" href="/user/subscribe_log"><i class="fas fa-stream"></i> <span>{$i18n->get('config-history')}</span></a></li>
      {/if}
      {if $malio_config['enable_share_account_page'] == true && $user->class >=0}
      <li><a class="nav-link" href="/user/share-account"><i class="fas fa-share"></i> <span>{$i18n->get('shared-account')}</span></a></li>
      {/if}
      {if $malio_config['enable_ticket'] == true}
      <li class="dropdown">
          <a href="#ticket" class="nav-link has-dropdown"><i class="fas fa-headset"></i> <span>{$i18n->get('ticket-support')}</span></a>
          <ul class="dropdown-menu">
            <li><a class="nav-link" href="/user/ticket/create"><span>{$i18n->get('new-ticket')}</span></a></li>
            <li><a class="nav-link" href="/user/ticket">{$i18n->get('my-tickets')}</a></li>
          </ul>
        </li>
      {/if}
      {if $user->class >=0}
      {if $malio_config['enable_relay'] == true}
      <li class="dropdown">
        <a href="#node-settings" class="nav-link has-dropdown"><i class="fas fa-cog"></i><span>{$i18n->get('server-settings')}</span></a>
        <ul class="dropdown-menu">
          <li><a class="nav-link" href="/user/relay"><span>{$i18n->get('relay-settings')}</span></a></li>
          <li><a class="nav-link" href="/user/edit">{$i18n->get('server-settings')}</a></li>
        </ul>
      </li>
      {else}
      <li><a class="nav-link" href="/user/edit"><i class="fas fa-cog"></i> <span>{$i18n->get('server-settings')}</span></a></li>
      {/if}
      {/if}
      {if $malio_config['enable_detect'] == true && $user->class >=0}
      <li class="dropdown">
        <a href="#detect" class="nav-link has-dropdown"><i class="fas fa-balance-scale"></i><span>{$i18n->get('audit-system')}</span></a>
        <ul class="dropdown-menu">
          <li><a class="nav-link" href="/user/detect">{$i18n->get('audit-rules')}</a></li>
          <li><a class="nav-link" href="/user/detect/log">{$i18n->get('audit-logs')}</a></li>
        </ul>
      </li>
      {/if}
    </ul>

    {if $malio_config['enable_sidebar_button'] == true && $user->class >= $malio_config['telegram_group_class']}
    <div class="mt-4 {if !$user->isAdmin()}mb-4{/if} p-3 hide-sidebar-mini">
        <a href="##" onclick="joinTelegramGroup()" class="btn btn-primary btn-lg btn-block btn-icon-split">
            <i class="fab fa-telegram-plane"></i> {$i18n->get('join-telegram-group')}
        </a>
    </div>
    {/if}
    {if $can_backtoadmin}
    <div class="mb-4 mt-4 p-3 hide-sidebar-mini">
      <a href="/user/backtoadmin" class="btn btn-warning btn-lg btn-block btn-icon-split">
          <i class="fas fa-tachometer-alt"></i>返回管理员身份
      </a>
    </div>
    {/if}
    {if $user->isAdmin()}
    <div class="mb-4 {if $malio_config['enable_sidebar_button'] != true}mt-4{/if} p-3 hide-sidebar-mini">
        <a href="/admin" class="btn btn-warning btn-lg btn-block btn-icon-split">
            <i class="fas fa-tachometer-alt"></i>管理面板
        </a>
    </div>
    {/if}
  </aside>
</div>