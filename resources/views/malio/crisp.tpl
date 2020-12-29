<!-- Crisp Chat  -->
<script type="text/javascript">
window.$crisp = [];
window.CRISP_WEBSITE_ID = "{$malio_config['crisp_wesite_id']}";
CRISP_TOKEN_ID = '{$user->uuid}';
(function () {
    d = document;
    s = d.createElement("script");
    s.src = "https://client.crisp.chat/l.js";
    s.async = 1;
    d.getElementsByTagName("head")[0].appendChild(s);
})();
</script>