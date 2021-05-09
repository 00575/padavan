<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - ShadowSocks 基本配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<link rel="shortcut icon" href="images/favicon.ico">
<link rel="icon" href="images/favicon.png">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/engage.itoggle.css">

<script type="text/javascript" src="/jquery.js"></script>
<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/bootstrap/js/engage.itoggle.min.js"></script>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/itoggle.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script>
var $j = jQuery.noConflict();

$j(document).ready(function() {
	init_itoggle('ss_enable',change_ss_enable);
	init_itoggle('ss_tochina_enable');
	init_itoggle('ss_udp_enable',change_ss_udp_enable);
	init_itoggle('ss_DNS_Redirect',change_ss_DNS_Redirect);
	init_itoggle('ss_pdnsd_all',change_ss_pdnsd_all);
	init_itoggle('ss_3p_enable',change_ss_3p_enable);
	init_itoggle('ss_3p_gfwlist');
	init_itoggle('ss_3p_kool');
	init_itoggle('ss_sub1');
	init_itoggle('ss_sub2');
	init_itoggle('ss_sub3');
	init_itoggle('ss_keep_check');
});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "ss_L2"); %>,<% nvram_get_x("", "ss_L3"); %>);
	show_footer();
	
	ss_method_protocol_obfs_reset();
	document.getElementById("ss_method").options[0].text = '<% nvram_get_x("", "ss_method"); %>';
	document.getElementById("ss_method").options[0].value = '<% nvram_get_x("", "ss_method"); %>';
	
	change_ss_udp_enable();
	change_ss_DNS_Redirect();
	change_dns_start_dnsproxy();
	change_ss_pdnsd_all();
	change_ss_mode_bridge();
	//change_ss_type_bridge();
	change_ss_3p_enable();
	change_ss_enable(1);
	change_ss_dnsproxy_x();
	if (!login_safe())
		textarea_scripts_enabled(0);
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.shadowsocks_mydomain_script.sh'], v);
	inputCtrl(document.form['scripts.shadowsocks_ss_spec_lan.sh'], v);
	inputCtrl(document.form['scripts.shadowsocks_ss_spec_wan.sh'], v);
}

function applyRule(){
	change_ss_mode_bridge();
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_SS.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function button_script3(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' button_script3 ',
	});
}

function button_updatess(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' updatess ',
	});
}

function button_swap(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' swapss ',
	});
}

function button_script4(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' button_script4 ',
	});
}

function done_validating(action){
	refreshpage();
}

function change_ss_enable(mflag){
	var m = document.form.ss_mode_x.value;
	var is_local_port = (m == "3") ? 1 : 0;
}

function change_ss_mode_bridge(){
	var m = document.form.ss_mode_x.value;
	var is_ss_pdnsd_wo_redir = 1;
	var is_ss_multiport = (m == "1") ? 0 : 1;
	var is_ss_tochina_enable = (m == "1" || m == "2") ? 0 : 1;
	var is_ss_gfwlist = (m == "1" || m == "0") ? 1 : 0;
	var is_local_port = (m == "3") ? 1 : 0;
	var is_ss_pdnsd_all = (m == "0") ? 1 : 0;
	if(is_local_port == "1"){
		var is_ss_tochina_enable = 0;
		var is_ss_multiport = 0;
		var is_ss_pdnsd_wo_redir = 0;
		showhide_div("run_ss_local_tr", 0);
	}

	change_ss_udp_enable();
	showhide_div("local_port", is_local_port);
	showhide_div("local_address", is_local_port);
	showhide_div("ss_pdnsd_wo_redir_tr", is_ss_pdnsd_wo_redir);
	showhide_div("ss_usage_tr", 1);
	showhide_div("ss_multiport_tr", is_ss_multiport);
	showhide_div("ss_tochina_enable_tr", is_ss_tochina_enable);
	showhide_div("ss_udp_enable_tr", is_ss_multiport);
	showhide_div("ss_upd_rules_tr", is_ss_multiport);
	showhide_div("ss_pdnsd_all_tr", is_ss_pdnsd_all);
	change_ss_DNS_Redirect();
	change_ss_3p_enable();
	var mm = document.form.ss_run_ss_local.value;
	var is_ss_run_ss_local = (mm == "1") ? 1 : 0;
	if(is_local_port == "0"){
		showhide_div("run_ss_local_tr", 1);
		showhide_div("local_port", is_ss_run_ss_local);
		showhide_div("local_address", is_ss_run_ss_local);
	}
}
//同时启用ss-local
function click_run_ss_local(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.ss_run_ss_local.value = v;
	change_ss_mode_bridge();
}
//SS和SSR切换1
function change_ss_type_bridge(){
	var is_ss_type = 1;
	showhide_div("ssr_type_protocol_tr", is_ss_type);
	showhide_div("ssr_type_obfs_tr", is_ss_type);
	showhide_div("ssr_type_obfs_custom_tr", is_ss_type);
	showhide_div("ssr_type_protocol_custom_tr", is_ss_type);
	
	if(document.form.ss_type.value == 1){
		document.form.ssr_type_protocol_tmp_write.value = "";
		document.form.ssr_type_protocol_write.value = "";
		document.form.ssr_type_protocol.value = "";
		document.form.ssr_type_obfs_tmp_write.value = "";
		document.form.ssr_type_obfs_write.value = "";
		document.form.ssr_type_obfs.value = "";
	}else{
		document.form.ssr_type_protocol_tmp_write.value = "origin";
		document.form.ssr_type_protocol_write.value = "origin";
		document.form.ssr_type_protocol.value = "origin";
		document.form.ssr_type_obfs_tmp_write.value = "plain";
		document.form.ssr_type_obfs_write.value = "plain";
		document.form.ssr_type_obfs.value = "plain";
		document.form.ssr_type_protocol_custom.value = "";
		document.form.ssr_type_obfs_custom.value = "";
	}
	change_tmp_write();
}

function change_dns_start_dnsproxy(){
	var m = document.form.app_112.value;
	var is_dns_start_dnsproxy = (m == "1") ? 0 : 1;
	showhide_div("ss_pdnsd_wo_redir_tr", is_dns_start_dnsproxy);
}

function change_ss_dnsproxy_x(){
	if(document.form.ss_dnsproxy_x_tmp.value == 2){
		alert("由于已经开启 ChinaDNS 、ChinaDNS-NG 、 SmartDNS 服务，只允许使用 dnsmasq ，若需更换请关闭上述 DNS 服务后刷新页面。");
	}
	if(document.form.app_1.value != 0 && document.form.app_6.value == 8053){
		document.form.ss_dnsproxy_x.value = 2;
		document.form.ss_dnsproxy_x_tmp.value = 2;
	}else{
		document.form.ss_dnsproxy_x_tmp.value = 1;
	}
}

function ss_method_protocol_obfs_reset(){
	var re_usage = ' ' + document.form.ss_usage.value + ' ';
	re_usage = re_usage.replace(' -s ', ' 丨 -s ').replace(' -p ', ' 丨 -p ').replace(' -l ', ' 丨 -l ').replace(' -k ', ' 丨 -k ').replace(' -m ', ' 丨 -m ').replace(' -a ', ' 丨 -a ');
	re_usage = re_usage.replace(' -f ', ' 丨 -f ').replace(' -t ', ' 丨 -t ').replace(' -T ', ' 丨 -T ').replace(' -c ', ' 丨 -c ').replace(' -n ', ' 丨 -n ').replace(' -i ', ' 丨 -i ');
	re_usage = re_usage.replace(' -b ', ' 丨 -b ').replace(' -u ', ' 丨 -u ').replace(' -U ', ' 丨 -U ').replace(' -6 ', ' 丨 -6 ').replace(' -d ', ' 丨 -d ');
	re_usage = re_usage.replace(' --tcp-incoming-sndbuf ', ' 丨 --tcp-incoming-sndbuf ').replace(' --tcp-outgoing-sndbuf ', ' 丨 --tcp-outgoing-sndbuf ');
	re_usage = re_usage.replace(' --reuse-port ', ' 丨 --reuse-port ').replace(' --fast-open ', ' 丨 --fast-open ').replace(' --acl ', ' 丨 --acl ');
	re_usage = re_usage.replace(' --mtu ', ' 丨 --mtu ').replace(' --no-delay ', ' 丨 --no-delay ').replace(' --key ', ' 丨 --key ').replace(' --plugin ', ' 丨 --plugin ').replace(' --plugin-opts ', ' 丨 --plugin-opts ');
	re_usage = re_usage.replace(' -v ', ' 丨 -v ').replace(' -h ', ' 丨 -h ').replace(' --help ', ' 丨 --help ');
	re_usage = re_usage.replace(' -o ', ' 丨 -o ').replace(' -O ', ' 丨 -O ').replace(' -g ', ' 丨 -g ').replace(' -G ', ' 丨 -G ');
	var patt1=/--plugin[ ]+[^丨]+/;
	var re_txt = String(re_usage.match(patt1)).replace('--plugin ', '').replace(/^(\s|\u00A0)+/,'').replace(/(\s|\u00A0)+$/,'');
	if(re_txt != "null"){
		document.form.ss_plugin_name.value = re_txt;
	}else{
		document.form.ss_plugin_name.value = "";
	}
	var patt1=/--plugin-opts[ ]+[^丨]+/;
	var re_txt = String(re_usage.match(patt1)).replace('--plugin-opts ', '').replace(/^(\s|"|\u00A0)+/,'').replace(/(\s|"|\u00A0)+$/,'');
	if(re_txt != "null"){
		document.form.ss_plugin_config.value = re_txt;
	}else{
		document.form.ss_plugin_config.value = "";
	}
	var patt1=/-G[ ]+[^丨]+/;
	var re_txt = String(re_usage.match(patt1)).replace('-G ', '').replace(/^(\s|\u00A0)+/,'').replace(/(\s|\u00A0)+$/,'');
	if(re_txt != "null")
		document.form.ssr_type_protocol_custom.value = re_txt;
	var patt1=/-g[ ]+[^丨]+/;
	var re_txt = String(re_usage.match(patt1)).replace('-g ', '').replace(/^(\s|\u00A0)+/,'').replace(/(\s|\u00A0)+$/,'');
	if(re_txt != "null")
		document.form.ssr_type_obfs_custom.value = re_txt;
	var patt1=/-O[ ]+[^丨]+/;
	var re_txt = String(re_usage.match(patt1)).replace('-O ', '').replace(/^(\s|\u00A0)+/,'').replace(/(\s|\u00A0)+$/,'');
	if(re_txt != "null"){
		document.form.ssr_type_protocol_tmp_write.value = re_txt;
		document.form.ssr_type_protocol_write.value = re_txt;
		document.form.ssr_type_protocol.value = re_txt;
	}
	var patt1=/-o[ ]+[^丨]+/;
	var re_txt = String(re_usage.match(patt1)).replace('-o ', '').replace(/^(\s|\u00A0)+/,'').replace(/(\s|\u00A0)+$/,'');
	if(re_txt != "null"){
		document.form.ssr_type_obfs_tmp_write.value = re_txt;
		document.form.ssr_type_obfs_write.value = re_txt;
		document.form.ssr_type_obfs.value = re_txt;
	}
	document.form.ss_method_tmp_write.value = document.form.ss_method.value;
	document.form.ss_method_write.value = document.form.ss_method.value;
	change_tmp_write();
}

function change_tmp_write(){
	if (document.form.ss_method_tmp_write.value != document.form.ss_method.value || document.form.ss_method_tmp_write.value != document.form.ss_method_write.value){
		if (document.form.ss_method_tmp_write.value != document.form.ss_method.value)
			var tmp_write = document.form.ss_method.value;
		if (document.form.ss_method_tmp_write.value != document.form.ss_method_write.value)
			var tmp_write = document.form.ss_method_write.value;
		if (tmp_write == "")
			var tmp_write = "none";
		document.form.ss_method.value = tmp_write;
		document.form.ss_method_write.value = tmp_write;
		document.form.ss_method_tmp_write.value = tmp_write;
		document.getElementById("ss_method").options[0].text = tmp_write;
		document.getElementById("ss_method").options[0].value = tmp_write;
		document.getElementById("ss_method").options[0].selected = true;
	}
	if (document.form.ssr_type_protocol_tmp_write.value != document.form.ssr_type_protocol.value || document.form.ssr_type_protocol_tmp_write.value != document.form.ssr_type_protocol_write.value){
		if (document.form.ssr_type_protocol_tmp_write.value != document.form.ssr_type_protocol.value)
			var tmp_write = document.form.ssr_type_protocol.value;
		if (document.form.ssr_type_protocol_tmp_write.value != document.form.ssr_type_protocol_write.value)
			var tmp_write = document.form.ssr_type_protocol_write.value;
		if (tmp_write == "")
			var tmp_write = "origin";
		document.form.ssr_type_protocol.value = tmp_write;
		document.form.ssr_type_protocol_write.value = tmp_write;
		document.form.ssr_type_protocol_tmp_write.value = tmp_write;
		document.getElementById("ssr_type_protocol").options[0].text = tmp_write;
		document.getElementById("ssr_type_protocol").options[0].value = tmp_write;
		document.getElementById("ssr_type_protocol").options[0].selected = true;
	}
	if (document.form.ssr_type_obfs_tmp_write.value != document.form.ssr_type_obfs.value || document.form.ssr_type_obfs_tmp_write.value != document.form.ssr_type_obfs_write.value){
		if (document.form.ssr_type_obfs_tmp_write.value != document.form.ssr_type_obfs.value)
			var tmp_write = document.form.ssr_type_obfs.value;
		if (document.form.ssr_type_obfs_tmp_write.value != document.form.ssr_type_obfs_write.value)
			var tmp_write = document.form.ssr_type_obfs_write.value;
		if (tmp_write == "")
			var tmp_write = "plain";
		document.form.ssr_type_obfs.value = tmp_write;
		document.form.ssr_type_obfs_write.value = tmp_write;
		document.form.ssr_type_obfs_tmp_write.value = tmp_write;
		document.getElementById("ssr_type_obfs").options[0].text = tmp_write;
		document.getElementById("ssr_type_obfs").options[0].value = tmp_write;
		document.getElementById("ssr_type_obfs").options[0].selected = true;
	}
	change_ss_usage_value();
}

function change_ss_usage_value(){
	//SS和SSR切换
	var method_x = document.form.ss_method.value;
	if (method_x == "aes-128-cfb" || method_x == "aes-128-ctr" || method_x == "aes-128-gcm" || method_x == "aes-192-cfb" || method_x == "aes-192-ctr" || method_x == "aes-192-gcm" || method_x == "aes-256-cfb" || method_x == "aes-256-ctr" || method_x == "aes-256-gcm" || method_x == "bf-cfb" || method_x == "camellia-128-cfb" || method_x == "camellia-192-cfb" || method_x == "camellia-256-cfb" || method_x == "chacha20" || method_x == "chacha20-ietf" || method_x == "chacha20-ietf-poly1305" || method_x == "rc4-md5" || method_x == "salsa20" || method_x == "xchacha20-ietf-poly1305"){
		if (document.form.ssr_type_protocol_tmp_write.value == "origin" && document.form.ssr_type_obfs_tmp_write.value == "plain"){
			document.form.ss_type.value = "0";
			document.form.ssr_type_protocol_custom.value = "";
			document.form.ssr_type_obfs_custom.value = "";
		}else{
			document.form.ss_type.value = "1";
		}
	}else{
		document.form.ss_type.value = "1";
	}
	
	var ss_usage_value = " ";
	var tmp_write = document.form.ssr_type_protocol_tmp_write.value;
	if (tmp_write == "")
		var tmp_write = "origin";
	var ss_usage_value = ss_usage_value + ' -O ' + tmp_write;

	var tmp_write = document.form.ssr_type_obfs_tmp_write.value;
	if (tmp_write == "")
		var tmp_write = "plain";
	var ss_usage_value = ss_usage_value + ' -o ' + tmp_write;

	var tmp_write = document.form.ssr_type_protocol_custom.value;
	//if (tmp_write != "")
		var ss_usage_value = ss_usage_value + ' -G ' + tmp_write;

	var tmp_write = document.form.ssr_type_obfs_custom.value;
	//if (tmp_write != "")
		var ss_usage_value = ss_usage_value + ' -g ' + tmp_write;

	var tmp_write = document.form.ss_plugin_name.value;
	//if (tmp_write != "")
		var ss_usage_value = ss_usage_value + ' --plugin ' + tmp_write;
	
	var tmp_write = document.form.ss_plugin_config.value;
	//if (tmp_write != "")
		var ss_usage_value = ss_usage_value + ' --plugin-opts ' + tmp_write;

	var ss_usage_value = ss_usage_value + ' ';
	document.form.ss_usage.value = ss_usage_value;
}

function change_ss_3p_enable(){
	var m = document.form.ss_3p_enable[0].checked;
	var is_ss_3p_enable = (m == "1") ? 1 : 0;
	showhide_div("ss_3p_gfwlist_tr", is_ss_3p_enable);
	showhide_div("ss_3p_kool_tr", is_ss_3p_enable);
	showhide_div("ss_gfwlist3_tr", is_ss_3p_enable);
	showhide_div("ss_gfwlist4_tr", is_ss_3p_enable);
	showhide_div("ss_gfwlist5_tr", is_ss_3p_enable);

}

function change_ss_udp_enable(){
	var m = document.form.ss_udp_enable[0].checked;
	var is_ss_udp_enable = (m == "1") ? 1 : 0;
	showhide_div("ss_upd_rules_tr", is_ss_udp_enable);
	
}

function change_ss_DNS_Redirect(){
	var m = document.form.ss_DNS_Redirect[0].checked;
	var is_ss_DNS_Redirect = (m == "1") ? 1 : 0;
	showhide_div("ss_DNS_Redirect_IP_tr", is_ss_DNS_Redirect);
}

function change_ss_pdnsd_all(){
	var m = document.form.ss_pdnsd_all[0].checked;
	var is_ss_pdnsd_all = (m == "1") ? 1 : 0;
	showhide_div("ss_pdnsd_cn_all_tr", is_ss_pdnsd_all);
}
</script>
</head>

<body onload="initial();" onunLoad="return unload_body();">

<div class="wrapper">
	<div class="container-fluid" style="padding-right: 0px">
		<div class="row-fluid">
			<div class="span3"><center><div id="logo"></div></center></div>
			<div class="span9" >
				<div id="TopBanner"></div>
			</div>
		</div>
	</div>

	<div id="Loading" class="popup_bg"></div>

	<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

	<form method="post" name="form" id="ruleForm" action="/start_apply.htm" target="hidden_frame">

	<input type="hidden" name="current_page" value="Advanced_Extensions_SS.asp">
	<input type="hidden" name="next_page" value="">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="LANHostConfig;General;">
	<input type="hidden" name="group_id" value="">
	<input type="hidden" name="action_mode" value="">
	<input type="hidden" name="action_script" value="">
	<input type="hidden" name="wan_ipaddr" value="<% nvram_get_x("", "wan0_ipaddr"); %>" readonly="1">
	<input type="hidden" name="wan_netmask" value="<% nvram_get_x("", "wan0_netmask"); %>" readonly="1">
	<input type="hidden" name="dhcp_start" value="<% nvram_get_x("", "dhcp_start"); %>">
	<input type="hidden" name="dhcp_end" value="<% nvram_get_x("", "dhcp_end"); %>">
	<input type="hidden" name="ss_run_ss_local" value="<% nvram_get_x("", "ss_run_ss_local"); %>" />
	<input type="hidden" name="app_1" value="<% nvram_get_x("", "app_1"); %>" />
	<input type="hidden" name="app_6" value="<% nvram_get_x("", "app_6"); %>" />
	<input type="hidden" name="ss_dnsproxy_x_tmp" value="" />

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span3">
				<!--Sidebar content-->
				<!--=====Beginning of Main Menu=====-->
				<div class="well sidebar-nav side_nav" style="padding: 0px;">
					<ul id="mainMenu" class="clearfix"></ul>
					<ul class="clearfix">
						<li>
							<div id="subMenu" class="accordion"></div>
						</li>
					</ul>
				</div>
			</div>
			
			<div class="span9">
				<!--Body content-->
				<div class="row-fluid">
					<div class="span12">
						<div class="box well grad_colour_dark_blue">
							<h2 class="box_head round_top">ShadowSocks - 基本配置</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;"><#SSConfig_display1_sectiondesc#>&nbsp;<span style="color:#FF0000;">更多的 SS 设置，需要到页面最下面的脚本功能详细配置。</span>
									<div>项目地址: <a href="https://github.com/shadowsocks/shadowsocks-libev" target="blank">Shadowsocks</a> <a href="https://github.com/shadowsocksr-rm/shadowsocks-rss/" target="blank">ShadowsocksR</a></div>
									<div><span style="color:#888;"><% nvram_get_x("", "gfwlist3"); %></span></div></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="3" style="background-color: #E3E3E3;">开关</th>
											<td style="border-top: 0 none;"></td>
										</tr>
										<tr>
											<th width="30%">ShadowSocks 开关</th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_enable_on_of">
														<input type="checkbox" id="ss_enable_fake" <% nvram_match_x("", "ss_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ss_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_enable" id="ss_enable_1" class="input" value="1" onClick="change_ss_enable(1);" <% nvram_match_x("", "ss_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_enable" id="ss_enable_0" class="input" value="0" onClick="change_ss_enable(1);" <% nvram_match_x("", "ss_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<input class="btn btn-success" style="width:60px" type="button" value="重启" onclick="button_updatess()" /> &nbsp;&nbsp;
												<input class="btn btn-primary" style="width:75px" type="button" value="切换线路" onclick="button_swap()" />
											</td>
										</tr>
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">ShadowSocks 信息</th>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">代理类型</th>
											<td style="border-top: 0 none;" >
												<select name="ss_type" class="input" onChange="change_ss_type_bridge();">
													<option value="0" <% nvram_match_x("","ss_type", "0","selected"); %>>SS</option>
													<option value="1" <% nvram_match_x("","ss_type", "1","selected"); %>>SSR</option>
												</select>
											</td>
											<td style="border-top: 0 none;" >
												<label id="run_ss_local_tr" class="checkbox inline"><input type="checkbox" name="run_ss_local_fake" value="" style="margin-left:10;" onclick="click_run_ss_local(this);" <% nvram_match_x("", "ss_run_ss_local", "1", "checked"); %>/>同时启用 ss-local</label>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">工作模式</th>
											<td style="border-top: 0 none;">
												<select name="ss_mode_x" class="input" onChange="change_ss_mode_bridge();">
													<option value="0" <% nvram_match_x("","ss_mode_x", "0","selected"); %>>【1】大陆白名单</option>
													<option value="1" <% nvram_match_x("","ss_mode_x", "1","selected"); %>>【2】gfwlist</option>
													<option value="2" <% nvram_match_x("","ss_mode_x", "2","selected"); %>>【3】全局代理</option>
													<option value="3" <% nvram_match_x("","ss_mode_x", "3","selected"); %>>【4】ss-local</option>
												</select>
											</td>
											<td id="ss_ip46" style="border-top: 0 none;">
												<select name="ss_ip46">
													<option value="0" <% nvram_match_x("","ss_ip46", "0","selected"); %>>启用 ipv4 透明代理</option>
													<option value="1" <% nvram_match_x("","ss_ip46", "1","selected"); %>>启用 ipv6 透明代理</option>
													<option value="2" <% nvram_match_x("","ss_ip46", "2","selected"); %>>启用 ipv4 + ipv6 透明代理</option>
												</select>
											</td>
										</tr>
										<tr id="local_address" style="display:none;">
											<th style="border-top: 0 none;">本地监听地址:</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="15" class="input" size="15" name="ss_s1_local_address" placeholder="0.0.0.0" value="<% nvram_get_x("","ss_s1_local_address"); %>" onKeyPress="return is_ipaddr(this,event);"/>
												
											</td>
										</tr>
										<tr id="local_port" style="display:none;">
											<th style="border-top: 0 none;">本地代理端口:</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" name="ss_s1_local_port" value="<% nvram_get_x("","ss_s1_local_port"); %>" onKeyPress="return is_number(this,event);"/>
												&nbsp;<span style="color:#888;">[100...65535]</span>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 25, 1);">服务器地址:</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="512" class="input" size="15" id="ss_server" name="ss_server" value="<% nvram_get_x("","ss_server"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">务器 IP 或 域名</span>
											</td>
											<td id="ss_matching_enable" style="border-top: 0 none;">
												<select name="ss_matching_enable">
													<option value="0" <% nvram_match_x("","ss_matching_enable", "0","selected"); %>>自动故障转移(透明代理时生效)</option>
													<option value="1" <% nvram_match_x("","ss_matching_enable", "1","selected"); %>>停用故障转移</option>
												</select>
												&nbsp;<span style="color:#888;">请到  <a href="./Advanced_Extensions_SS_list.asp" target="SS_list">[SS节点]</a> 页面添加服务节点</span>
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,2);">服务器端口:</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" name="ss_server_port" value="<% nvram_get_x("","ss_server_port"); %>" onKeyPress="return is_number(this,event);"/>
												&nbsp;<span style="color:#888;">[100...65535]</span>
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,4);">服务器密码:</a></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="ss_key" id="ss_key" style="width: 175px;" value="<% nvram_get_x("","ss_key"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('ss_key')"><i class="icon-eye-close"></i></button>
												&nbsp;<span style="color:#888;">注意！大小写敏感！</span>
											</div>
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,5);">加密方式:</a></th>
											<td id="ss_method_write1_tr" style="border-top: 0 none;">
												<select name="ss_method" id="ss_method" class="input" onChange="change_tmp_write();">
													<option value="" <% nvram_match_x("","ss_method", "","selected"); %>></option>
													<option value="chacha20-ietf-poly1305" <% nvram_match_x("","ss_method", "chacha20-ietf-poly1305","selected"); %>>chacha20-ietf-poly1305 [SS]</option>
													<option value="xchacha20-ietf-poly1305" <% nvram_match_x("","ss_method", "xchacha20-ietf-poly1305","selected"); %>>xchacha20-ietf-poly1305 [SS]</option>
													<option value="aes-128-gcm" <% nvram_match_x("","ss_method", "aes-128-gcm","selected"); %>>aes-128-gcm [SS]</option>
													<option value="aes-192-gcm" <% nvram_match_x("","ss_method", "aes-192-gcm","selected"); %>>aes-192-gcm [SS]</option>
													<option value="aes-256-gcm" <% nvram_match_x("","ss_method", "aes-256-gcm","selected"); %>>aes-256-gcm [SS]</option>
													<option value="aes-128-cfb" <% nvram_match_x("","ss_method", "aes-128-cfb","selected"); %>>aes-128-cfb [SS/SSR]</option>
													<option value="aes-192-cfb" <% nvram_match_x("","ss_method", "aes-192-cfb","selected"); %>>aes-192-cfb [SS/SSR]</option>
													<option value="aes-256-cfb" <% nvram_match_x("","ss_method", "aes-256-cfb","selected"); %>>aes-256-cfb [SS/SSR]</option>
													<option value="aes-128-ctr" <% nvram_match_x("","ss_method", "aes-128-ctr","selected"); %>>aes-128-ctr [SS/SSR]</option>
													<option value="aes-192-ctr" <% nvram_match_x("","ss_method", "aes-192-ctr","selected"); %>>aes-192-ctr [SS/SSR]</option>
													<option value="aes-256-ctr" <% nvram_match_x("","ss_method", "aes-256-ctr","selected"); %>>aes-256-ctr [SS/SSR]</option>
													<option value="rc4-md5" <% nvram_match_x("","ss_method", "rc4-md5","selected"); %>>rc4-md5 [SS/SSR]</option>
													<option value="chacha20" <% nvram_match_x("","ss_method", "chacha20","selected"); %>>chacha20 [SS/SSR]</option>
													<option value="chacha20-ietf" <% nvram_match_x("","ss_method", "chacha20-ietf","selected"); %>>chacha20-ietf [SS/SSR]</option>
													<option value="camellia-128-cfb" <% nvram_match_x("","ss_method", "camellia-128-cfb","selected"); %>>camellia-128-cfb [SS/SSR]</option>
													<option value="camellia-192-cfb" <% nvram_match_x("","ss_method", "camellia-192-cfb","selected"); %>>camellia-192-cfb [SS/SSR]</option>
													<option value="camellia-256-cfb" <% nvram_match_x("","ss_method", "camellia-256-cfb","selected"); %>>camellia-256-cfb [SS/SSR]</option>
													<option value="bf-cfb" <% nvram_match_x("","ss_method", "bf-cfb","selected"); %>>bf-cfb [SS/SSR]</option>
													<option value="cast5-cfb" <% nvram_match_x("","ss_method", "cast5-cfb","selected"); %>>cast5-cfb</option>
													<option value="des-cfb" <% nvram_match_x("","ss_method", "des-cfb","selected"); %>>des-cfb</option>
													<option value="idea-cfb" <% nvram_match_x("","ss_method", "idea-cfb","selected"); %>>idea-cfb</option>
													<option value="rc2-cfb" <% nvram_match_x("","ss_method", "rc2-cfb","selected"); %>>rc2-cfb</option>
													<option value="rc4" <% nvram_match_x("","ss_method", "rc4","selected"); %>>rc4</option>
													<option value="rc4-md5-6" <% nvram_match_x("","ss_method", "rc4-md5-6","selected"); %>>rc4-md5-6</option>
													<option value="salsa20" <% nvram_match_x("","ss_method", "salsa20","selected"); %>>salsa20</option>
													<option value="seed-cfb" <% nvram_match_x("","ss_method", "seed-cfb","selected"); %>>seed-cfb</option>
													<option value="table" <% nvram_match_x("","ss_method", "table","selected"); %>>table</option>
													<option value="none" <% nvram_match_x("","ss_method", "none","selected"); %>>none [SSR]</option>
												</select>
												&nbsp;<span style="color:#888;">选错无法连通</span>
											</td>
											<td id="ss_method_write3_tr" style="border-top: 0 none;">
												<input type="text" maxlength="8192" class="input" size="15" onchange="change_tmp_write();" name="ss_method_write" value="<% nvram_get_x("","ss_method_write"); %>" />
												<input type="text" maxlength="8192" class="input" size="15" style="display:none;" name="ss_method_tmp_write" value="<% nvram_get_x("","ss_method_tmp_write"); %>" />
												&nbsp;<span style="color:#888;">手动输入，写错无法连通</span>
											</td>
										</tr>
										<tr id="ssr_type_protocol_tr">
										<th>协议插件 [-O] (protocol):</th>
											<td id="ssr_type_protocol_write1_tr">
												<select name="ssr_type_protocol" id="ssr_type_protocol" onChange="change_tmp_write();">
												<option value="" <% nvram_match_x("","ssr_type_protocol", "","selected"); %>></option>
												<option value="origin" <% nvram_match_x("","ssr_type_protocol", "origin","selected"); %>>origin</option>
												<option value="verify_simple" <% nvram_match_x("","ssr_type_protocol", "verify_simple","selected"); %>>verify_simple</option>
												<option value="verify_sha1" <% nvram_match_x("","ssr_type_protocol", "verify_sha1","selected"); %>>verify_sha1</option>
												<option value="auth_simple" <% nvram_match_x("","ssr_type_protocol", "auth_simple","selected"); %>>auth_simple</option>
												<option value="auth_sha1" <% nvram_match_x("","ssr_type_protocol", "auth_sha1","selected"); %>>auth_sha1</option>
												<option value="auth_sha1_v2" <% nvram_match_x("","ssr_type_protocol", "auth_sha1_v2","selected"); %>>auth_sha1_v2</option>
												<option value="auth_sha1_v4" <% nvram_match_x("","ssr_type_protocol", "auth_sha1_v4","selected"); %>>auth_sha1_v4</option>
												<option value="auth_aes128_md5" <% nvram_match_x("","ssr_type_protocol", "auth_aes128_md5","selected"); %>>auth_aes128_md5</option>
												<option value="auth_aes128_sha1" <% nvram_match_x("","ssr_type_protocol", "auth_aes128_sha1","selected"); %>>auth_aes128_sha1</option>
												<option value="auth_chain_a" <% nvram_match_x("","ssr_type_protocol", "auth_chain_a","selected"); %>>auth_chain_a</option>
												<option value="auth_chain_b" <% nvram_match_x("","ssr_type_protocol", "auth_chain_b","selected"); %>>auth_chain_b</option>
												<option value="auth_chain_c" <% nvram_match_x("","ssr_type_protocol", "auth_chain_c","selected"); %>>auth_chain_c</option>
												<option value="auth_chain_d" <% nvram_match_x("","ssr_type_protocol", "auth_chain_d","selected"); %>>auth_chain_d</option>
												<option value="auth_chain_e" <% nvram_match_x("","ssr_type_protocol", "auth_chain_e","selected"); %>>auth_chain_e</option>
												<option value="auth_chain_f" <% nvram_match_x("","ssr_type_protocol", "auth_chain_f","selected"); %>>auth_chain_f</option>
												</select>
												&nbsp;<span style="color:#888;">SSR 设置参数</span>
											</td>
											<td id="ssr_type_protocol_write3_tr">
												<input type="text" maxlength="8192" class="input" size="15" onchange="change_tmp_write();" name="ssr_type_protocol_write" value="<% nvram_get_x("","ssr_type_protocol_write"); %>" />
												<input type="text" maxlength="8192" class="input" size="15" style="display:none;" name="ssr_type_protocol_tmp_write" value="<% nvram_get_x("","ssr_type_protocol_tmp_write"); %>" />
												&nbsp;<span style="color:#888;">手动输入，写错无法连通</span>
											</td>
										</tr>
										<tr id="ssr_type_protocol_custom_tr">
											<th style="border-top: 0 none;">协议参数 [-G]（<a href="https://www.google.com/search?q=ShadowsocksR%E5%8D%95%E7%AB%AF%E5%8F%A3%E5%A4%9A%E7%94%A8%E6%88%B7%E9%85%8D%E7%BD%AE%E6%96%B9%E6%B3%95" target="blank">说明</a>）:</th>
											<td style="border-top: 0 none;" colspan="2">
												<input type="text" style="width: 446px;" maxlength="8192" class="input" size="15" onchange="change_ss_usage_value();" name="ssr_type_protocol_custom" value="<% nvram_get_x("","ssr_type_protocol_custom"); %>" />
											</td>
										</tr>
										<tr id="ssr_type_obfs_tr">
										<th style="border-top: 0 none;">混淆插件 [-o] (obfs):</th>
											<td id="ssr_type_obfs_write1_tr" style="border-top: 0 none;">
												<select name="ssr_type_obfs" id="ssr_type_obfs" onChange="change_tmp_write();">
												<option value="" <% nvram_match_x("","ssr_type_obfs", "","selected"); %>></option>
												<option value="plain" <% nvram_match_x("","ssr_type_obfs", "plain","selected"); %>>plain</option>
												<option value="http_simple" <% nvram_match_x("","ssr_type_obfs", "http_simple","selected"); %>>http_simple</option>
												<option value="http_post" <% nvram_match_x("","ssr_type_obfs", "http_post","selected"); %>>http_post</option>
												<option value="tls1.2_ticket_auth" <% nvram_match_x("","ssr_type_obfs", "tls1.2_ticket_auth","selected"); %>>tls1.2_ticket_auth</option>
												</select>
												&nbsp;<span style="color:#888;">SSR 设置参数</span>
											</td>
											<td id="ssr_type_obfs_write3_tr" style="border-top: 0 none;">
												<input type="text" maxlength="8192" class="input" size="15" onchange="change_tmp_write();" name="ssr_type_obfs_write" value="<% nvram_get_x("","ssr_type_obfs_write"); %>" />
												<input type="text" maxlength="8192" class="input" size="15" style="display:none;" name="ssr_type_obfs_tmp_write" value="<% nvram_get_x("","ssr_type_obfs_tmp_write"); %>" />
												&nbsp;<span style="color:#888;">手动输入，写错无法连通</span>
											</td>
										</tr>
										<tr id="ssr_type_obfs_custom_tr">
											<th style="border-top: 0 none;">混淆参数 [-g]（<a href="https://github.com/shadowsocksr-rm/shadowsocks-rss/blob/master/ssr.md" target="blank">说明</a>）:</th>
											<td style="border-top: 0 none;" colspan="2">
												<input type="text" style="width: 446px;" maxlength="8192" class="input" size="15" onchange="change_ss_usage_value();" name="ssr_type_obfs_custom" value="<% nvram_get_x("","ssr_type_obfs_custom"); %>" />
											</td>
										</tr>
										<tr id="ss_plugin_name_tr">
											<th>插件名称（<a href="https://shadowsocks.org/en/spec/Plugin.html" target="blank">说明</a>）:</th>
											<td colspan="2">
												<input type="text" style="width: 446px;" maxlength="8192" class="input" size="15" onchange="change_tmp_write();" name="ss_plugin_name" value="<% nvram_get_x("","ss_plugin_name"); %>" />
												<span style="color:#888;">启动程序名：[ <a href="https://github.com/shadowsocks/simple-obfs" target="blank">obfs-local</a> ] , [ <a href="https://github.com/cbeuw/GoQuiet/wiki/GoQuiet" target="blank">gq-client</a> ] , [ <a href="https://github.com/cbeuw/Cloak" target="blank">ck-client</a> ] , [ <a href="https://github.com/shadowsocks/kcptun" target="blank">kcptun</a> ] , [ <a href="https://github.com/shadowsocks/v2ray-plugin" target="blank">v2ray-plugin</a> ]</span>
											</td>
										</tr>
										<tr id="ss_plugin_config_tr">
											<th style="border-top: 0 none;">插件参数（<a href="https://github.com/shadowsocks/shadowsocks-org/issues/28" target="blank">说明</a>）:</th>
											<td style="border-top: 0 none;" colspan="2">
												<input type="text" style="width: 446px;" maxlength="8192" class="input" size="15" onchange="change_tmp_write();" name="ss_plugin_config" value="<% nvram_get_x("","ss_plugin_config"); %>" />
												<span style="color:#888;">[obfs=http;obfs-host=www.163.com] , 启动插件命令参数</span>
											</td>
										</tr>
										<tr id="ss_usage_tr">
											<th><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,10);">高级启动参数选项</a></th>
											<td colspan="2">
												<input type="text" style="width: 446px;" maxlength="512" class="input" size="15" name="ss_usage" value="<% nvram_get_x("","ss_usage"); %>" onKeyPress="return is_string(this,event);"/>
											</td>
										</tr>
										<tr>
											<td colspan="3" style="border-top: 0 none;">
												<br />
												<center><input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" /></center>
											</td>
										</tr>
										<tr>
											<th colspan="3" style="background-color: #E3E3E3;">高级功能:</th>
										</tr>
										<tr id="ss_multiport_tr" style="display:none;">
											<th style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,8);">代理转发的TCP端口:</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="512" class="input" size="15" name="ss_multiport" value="<% nvram_get_x("","ss_multiport"); %>" onKeyPress="return is_string(this,event);"/>
												&nbsp;<span style="color:#888;">[22,80,443]或[1:65535]全部转发</span>
											</td>
										</tr>
										<tr id="ss_tochina_enable_tr" style="display:none;">
											<th style="border-top: 0 none;" width="30%"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,12);">回国模式</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_tochina_enable_on_of">
														<input type="checkbox" id="ss_tochina_enable_fake" <% nvram_match_x("", "ss_tochina_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ss_tochina_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_tochina_enable" id="ss_tochina_enable_1" class="input" value="1" <% nvram_match_x("", "ss_tochina_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_tochina_enable" id="ss_tochina_enable_0" class="input" value="0" <% nvram_match_x("", "ss_tochina_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="ss_udp_enable_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,9);">游戏模式（UDP转发）</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_udp_enable_on_of">
														<input type="checkbox" id="ss_udp_enable_fake" <% nvram_match_x("", "ss_udp_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ss_udp_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_udp_enable" id="ss_udp_enable_1" class="input" value="1" onclick="change_ss_udp_enable();" <% nvram_match_x("", "ss_udp_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_udp_enable" id="ss_udp_enable_0" class="input" value="0" onclick="change_ss_udp_enable();" <% nvram_match_x("", "ss_udp_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="ss_upd_rules_tr" style="display:none;">
											<th style="border-top: 0 none;"><a class="help_tooltip" href="javascript:void(0);" onmouseover="openTooltip(this,25,7);">UDP 转发参数:</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="512"  class="none" size="60" name="ss_upd_rules" value="<% nvram_get_x("","ss_upd_rules"); %>" onKeyPress="return is_string(this,event);" />&nbsp;<span style="color:#888;"></span>
												&nbsp;<span style="color:#888;">[留空]为全部转发</span>
											</td>
										</tr>
										<tr id="ss_DNS_Redirect_tr" >
											<th width="30%"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,15);">重定向 DNS(chromecast、建议gfwlist模式开启)</a></th>
											<td colspan="2">
													<div class="main_itoggle">
													<div id="ss_DNS_Redirect_on_of">
														<input type="checkbox" id="ss_DNS_Redirect_fake" <% nvram_match_x("", "ss_DNS_Redirect", "1", "value=1 checked"); %><% nvram_match_x("", "ss_DNS_Redirect", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_DNS_Redirect" id="ss_DNS_Redirect_1" class="input" value="1" onclick="change_ss_DNS_Redirect();" <% nvram_match_x("", "ss_DNS_Redirect", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_DNS_Redirect" id="ss_DNS_Redirect_0" class="input" value="0" onclick="change_ss_DNS_Redirect();" <% nvram_match_x("", "ss_DNS_Redirect", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="ss_DNS_Redirect_IP_tr" style="display:none;">
											<th style="border-top: 0 none;">DNS 重定向地址:</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="15"  class="none" size="60" name="ss_DNS_Redirect_IP" placeholder="<% nvram_get_x("", "lan_ipaddr"); %>" value="<% nvram_get_x("","ss_DNS_Redirect_IP"); %>" onKeyPress="return is_ipaddr(this,event);"/>
												&nbsp;<span style="color:#888;">[留空]为路由的IP</span>
											</td>
										</tr>
										<tr id="dns_start_dnsproxy_tr">
											<th width="30%" style="border-top: 0 none;">自动开启第三方 DNS 程序</th>
											<td style="border-top: 0 none;" colspan="2">
												<select style=" width: 390px; " name="app_112" class="input" onchange="change_dns_start_dnsproxy();">
													<option value="0" <% nvram_match_x("","app_112", "0","selected"); %>>自动开启第三方 DNS 程序</option>
													<option value="1" <% nvram_match_x("","app_112", "1","selected"); %>>跳过开启 DNS 程序，但是继续把DNS绑定到 8053 端口的程序</option>
												</select>
											</td>
										</tr>
										<tr id="ss_pdnsd_wo_redir_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript:void(0);" onmouseover="openTooltip(this,25,6);">DNS 代理服务模式选择</a></th>
											<td style="border-top: 0 none;" colspan="1">
												<select name="ss_dnsproxy_x" class="input" onchange="change_ss_dnsproxy_x();">
													<option value="0" <% nvram_match_x("","ss_dnsproxy_x", "0","selected"); %>>dnsproxy</option>
													<option value="1" <% nvram_match_x("","ss_dnsproxy_x", "1","selected"); %>>pdnsd</option>
													<option value="2" <% nvram_match_x("","ss_dnsproxy_x", "2","selected"); %>>dnsmasq</option>
												</select>
												<div><span style="color:#888;">DNS程序选择，推荐 dnsproxy</span></div>
											</td>
										</tr>
										<tr id="ss_pdnsd_all_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript:void(0);" onmouseover="openTooltip(this,25,14);">使用代理服务查询全部 DNS</a></th>
											<td colspan="2" style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_pdnsd_all_on_of">
														<input type="checkbox" id="ss_pdnsd_all_fake" <% nvram_match_x("", "ss_pdnsd_all", "1", "value=1 checked"); %><% nvram_match_x("", "ss_pdnsd_all", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_pdnsd_all" id="ss_pdnsd_all_1" class="input" value="1" onclick="change_ss_pdnsd_all();" <% nvram_match_x("", "ss_pdnsd_all", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_pdnsd_all" id="ss_pdnsd_all_0" class="input" value="0" onclick="change_ss_pdnsd_all();" <% nvram_match_x("", "ss_pdnsd_all", "0", "checked"); %> /><#checkbox_No#>
											   </div>
											   <div><span style="color:#888;">不启用时使用[本地DNS] + [GFW规则]查询DNS</span></div>
											</td>
										</tr>
										<tr id="ss_pdnsd_cn_all_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;">China 域名加速</th>
											<td style="border-top: 0 none;" colspan="2">
												<select style=" width: 390px; " name="app_113" class="input">
													<option value="0" <% nvram_match_x("","app_113", "0","selected"); %>>使用 8053 端口查询全部 DNS 时进行 China 域名加速</option>
													<option value="1" <% nvram_match_x("","app_113", "1","selected"); %>>不进行 China 域名加速</option>
												</select>
											</td>
										</tr>
										<tr id="ss_3p_enable_tr">
											<th width="30%">订阅 GFW 规则更新</th>
											<td colspan="2">
													<div class="main_itoggle">
													<div id="ss_3p_enable_on_of">
														<input type="checkbox" id="ss_3p_enable_fake" <% nvram_match_x("", "ss_3p_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ss_3p_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_3p_enable" id="ss_3p_enable_1" class="input" value="1" onclick="change_ss_3p_enable();" <% nvram_match_x("", "ss_3p_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_3p_enable" id="ss_3p_enable_0" class="input" value="0" onclick="change_ss_3p_enable();" <% nvram_match_x("", "ss_3p_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
												<div><span style="color:#888;">不订阅GFW规则更新则使用路由内置规则</span></div>
											</td>
										</tr>
										<tr id="ss_3p_gfwlist_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;">gfwlist 官方列表</th>
											<td colspan="2" style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_3p_gfwlist_on_of">
														<input type="checkbox" id="ss_3p_gfwlist_fake" <% nvram_match_x("", "ss_3p_gfwlist", "1", "value=1 checked"); %><% nvram_match_x("", "ss_3p_gfwlist", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_3p_gfwlist" id="ss_3p_gfwlist_1" class="input" value="1"  <% nvram_match_x("", "ss_3p_gfwlist", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_3p_gfwlist" id="ss_3p_gfwlist_0" class="input" value="0"  <% nvram_match_x("", "ss_3p_gfwlist", "0", "checked"); %> /><#checkbox_No#>
												</div>
												<div><span style="color:#888;">规则: https://raw.github.com/gfwlist/gfwlist/master/gfwlist.txt</span></div>
											</td>
										</tr>
										<tr id="ss_3p_kool_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;">Koolshare 列表</th>
											<td colspan="2" style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_3p_kool_on_of">
														<input type="checkbox" id="ss_3p_kool_fake" <% nvram_match_x("", "ss_3p_kool", "1", "value=1 checked"); %><% nvram_match_x("", "ss_3p_kool", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_3p_kool" id="ss_3p_kool_1" class="input" value="1" <% nvram_match_x("", "ss_3p_kool", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_3p_kool" id="ss_3p_kool_0" class="input" value="0" <% nvram_match_x("", "ss_3p_kool", "0", "checked"); %> /><#checkbox_No#>
												</div>
												<div><span style="color:#888;">规则: https://raw.github.com/hq450/fancyss/master/rules/gfwlist.conf</span></div>
											</td>
										</tr>
										<tr id="ss_gfwlist5_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;">海外加速<div>&nbsp;<span style="color:#FF0000;">用于直连速度慢的网站</span></div></th>
											<td colspan="2" style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_sub1_on_of">
														<input type="checkbox" id="ss_sub1_fake" <% nvram_match_x("", "ss_sub1", "1", "value=1 checked"); %><% nvram_match_x("", "ss_sub1", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_sub1" id="ss_sub1_1" class="input" value="1" <% nvram_match_x("", "ss_sub1", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_sub1" id="ss_sub1_0" class="input" value="0" <% nvram_match_x("", "ss_sub1", "0", "checked"); %> /><#checkbox_No#>
												</div>
												<div><span style="color:#888;">规则: https://coding.net/u/bigandy/p/DogcomBooster/git/raw/master/list.txt</span></div>
											</td>
										</tr>
										<tr id="ss_gfwlist4_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;">域名解释加速<div>&nbsp;<span style="color:#FF0000;">通常用于 XBOX Live 联网</span></div></th>
											<td colspan="2" style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_sub2_on_of">
														<input type="checkbox" id="ss_sub2_fake" <% nvram_match_x("", "ss_sub2", "1", "value=1 checked"); %><% nvram_match_x("", "ss_sub2", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_sub2" id="ss_sub2_1" class="input" value="1" <% nvram_match_x("", "ss_sub2", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_sub2" id="ss_sub2_0" class="input" value="0" <% nvram_match_x("", "ss_sub2", "0", "checked"); %> /><#checkbox_No#>
												</div>
												<div><span style="color:#888;">规则: https://coding.net/u/bigandy/p/DogcomBooster/git/raw/master/dnsonly.txt</span></div>
											</td>
										</tr>
										<tr id="ss_gfwlist3_tr" style="display:none;">
											<th style="border-top: 0 none;" width="30%">需要忽略的域名处理<div>&nbsp;<span style="color:#FF0000;">用于国内有CDN的节点</span></div></th>
											<td colspan="2" style="border-top: 0 none;" >
													<div class="main_itoggle">
													<div id="ss_sub3_on_of">
														<input type="checkbox" id="ss_sub3_fake" <% nvram_match_x("", "ss_sub3", "1", "value=1 checked"); %><% nvram_match_x("", "ss_sub3", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_sub3" id="ss_sub3_1" class="input" value="1" <% nvram_match_x("", "ss_sub3", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_sub3" id="ss_sub3_0" class="input" value="0" <% nvram_match_x("", "ss_sub3", "0", "checked"); %> /><#checkbox_No#>
												</div>
												<div><span style="color:#888;">规则: https://coding.net/u/bigandy/p/DogcomBooster/git/raw/master/passby.txt</span></div>
											</td>
										</tr>
										<tr id="ss_GFW_download_link_tr">
											<th style="border-top: 0 none;">GFW 下载地址: </th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="512"  class="none" size="60" name="ss_sub5" placeholder="http://api...." value="<% nvram_get_x("","ss_sub5"); %>"  onKeyPress="return is_string(this,event);"/>
												&nbsp;<span style="color:#888;">默认[空],GFW 自定义域名：[http://api....]</span>
											</td>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="512"  class="none" size="60" name="ss_sub6" placeholder="http://api...." value="<% nvram_get_x("","ss_sub6"); %>"  onKeyPress="return is_string(this,event);"/>
												&nbsp;<span style="color:#888;">默认[空],GFW黑名单 IPv4 下载地址: [http://api....]</span>
											</td>
										</tr>
										<tr id="ss_CHN_download_link_tr">
											<th style="border-top: 0 none;">大陆白名单 IPv4 下载地址: </th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="512"  class="none" size="60" name="ss_sub7" placeholder="http://api...." value="<% nvram_get_x("","ss_sub7"); %>"  onKeyPress="return is_string(this,event);"/>
												&nbsp;<span style="color:#888;">① 默认[空] , [http://api....]</span>
											</td>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="512"  class="none" size="60" name="ss_sub8" placeholder="http://api...." value="<% nvram_get_x("","ss_sub8"); %>"  onKeyPress="return is_string(this,event);"/>
												&nbsp;<span style="color:#888;">② 默认[空] , [http://api....]</span>
											</td>
										</tr>
										<tr>
											<th width="30%">检查 SS 服务器状态</th>
											<td colspan="2">
													<div class="main_itoggle">
													<div id="ss_keep_check_on_of">
														<input type="checkbox" id="ss_keep_check_fake" <% nvram_match_x("", "ss_keep_check", "1", "value=1 checked"); %><% nvram_match_x("", "ss_keep_check", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_keep_check" id="ss_keep_check_1" class="input" value="1" <% nvram_match_x("", "ss_keep_check", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_keep_check" id="ss_keep_check_0" class="input" value="0" <% nvram_match_x("", "ss_keep_check", "0", "checked"); %> /><#checkbox_No#>
												</div>
												&nbsp;<span style="color:#888;">运行时持续检测</span>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">多次检测断线后执行</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="512" class="input" size="15" name="ss_rebss_n" placeholder="0" value="<% nvram_get_x("","ss_rebss_n"); %>" onKeyPress="return is_number(this,event);"/>
												<div><span style="color:#888;">最大断线次数，[0]不执行</span></div>
											</td>
											<td style="border-top: 0 none;">
												<select name="ss_rebss_a" class="input">
													<option value="0" <% nvram_match_x("","ss_rebss_a", "0","selected"); %>>重启SS</option>
													<option value="1" <% nvram_match_x("","ss_rebss_a", "1","selected"); %>>停止SS</option>
													<option value="2" <% nvram_match_x("","ss_rebss_a", "2","selected"); %>>重启路由</option>
													<option value="3" <% nvram_match_x("","ss_rebss_a", "3","selected"); %>>更新订阅</option>
												</select>
												<div><span style="color:#888;">检测断线 [<% nvram_get_x("", "ss_rebss_b"); %>] 次，大于 [<% nvram_get_x("", "ss_rebss_n"); %>] 次后执行</span></div>
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;">连接检测的域名:</th>
											<td style="border-top: 0 none;" colspan="1">
												<input type="text" maxlength="512" class="input" size="15" name="ss_link_2" placeholder="www.google.com.hk" value="<% nvram_get_x("","ss_link_2"); %>" onKeyPress="return is_string(this,event);"/>
												&nbsp;<span style="color:#888;">谷歌网站，若是回国模式需要更换</span>
											</td>
											<td style="border-top: 0 none;" colspan="1">
												<input type="text" maxlength="512" class="input" size="15" name="ss_link_1" placeholder="88" value="<% nvram_get_x("","ss_link_1"); %>" onKeyPress="return is_number(this,event);"/>
												&nbsp;<span style="color:#888;">检测间隔时间：秒(s)</span>
											</td>
										</tr>
										<tr id="ss_updatess_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;">启动时更新 SS 规则文件<div>&nbsp;<span style="color:#FF0000;">会导致 SS 启动速度变慢</span></div></th>
											<td style="border-top: 0 none;" colspan="2">
												<select name="ss_updatess" class="input">
													<option value="0" <% nvram_match_x("","ss_updatess", "0","selected"); %>>是，启动时下载更新</option>
													<option value="1" <% nvram_match_x("","ss_updatess", "1","selected"); %>>否，只使用内置规则</option>
												</select>
												<div><span style="color:#888;">推荐“是”，否则需手动或等定时更新才下载最新规则</span></div>
											</td>
										</tr>
										<tr id="ss_update_tr" >
											<th style="border-top: 0 none;">规则自动更新:</th>
											<td style="border-top: 0 none;">
												<select name="ss_update" class="input" style="width: 60px;">
													<option value="0" <% nvram_match_x("","ss_update", "0","selected"); %>>每天</option>
													<option value="1" <% nvram_match_x("","ss_update", "1","selected"); %>>每隔</option>
													<option value="2" <% nvram_match_x("","ss_update", "2","selected"); %>>关闭</option>
												</select>
												<input style="width: 20px;" type="text" maxlength="2"  class="none" size="60" name="ss_update_hour" placeholder="23" value="<% nvram_get_x("","ss_update_hour"); %>" onKeyPress="return is_number(this,event);"/>时，<input style="width: 20px;" type="text" maxlength="2"  class="none" size="60" name="ss_update_min" placeholder="59" value="<% nvram_get_x("","ss_update_min"); %>" onKeyPress="return is_number(this,event);"/>分，更新
												&nbsp;<span style="color:#888;"></span>
												<div>&nbsp;<span style="color:#888;">注意：更新时可能会造成网游断线！</span></div>
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;">手动更新 SS 规则文件</th>
											<td colspan="2" style="border-top: 0 none;">
												<input class="btn btn-primary" style="width: 219px" type="button" value="手动更新 SS 规则文件" onclick="button_script4()" />
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,11);">重置 SS IP 规则文件</a></th>
											<td colspan="2" style="border-top: 0 none;">
												<input class="btn btn-success" style="width: 219px" type="button" value="重置 SS IP 规则文件" onclick="button_script3()" />
											</td>
										</tr>
										<tr id="ss_threads_tr">
											<th width="30%" style="border-top: 0 none;">启动多线程均衡负载<div>&nbsp;<span style="color:#FF0000;">只支持多核CPU</span></div></th>
											<td style="border-top: 0 none;" colspan="2">
												<select name="ss_threads" class="input">
													<option value="0" <% nvram_match_x("","ss_threads", "0","selected"); %>>关闭</option>
													<option value="1" <% nvram_match_x("","ss_threads", "1","selected"); %>>是，自动线程</option>
													<option value="2" <% nvram_match_x("","ss_threads", "2","selected"); %>>是，2 线程</option>
													<option value="3" <% nvram_match_x("","ss_threads", "3","selected"); %>>是，3 线程</option>
													<option value="4" <% nvram_match_x("","ss_threads", "4","selected"); %>>是，4 线程</option>
												</select>
											</td>
										</tr>
										<tr id="ss_gfwlist2">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script10')"><span>点这里自定义gfwlist的域名，强制代理转发【例：abc.com 每行一个，无需加入www，只要域名，后面也不用带任何符号或者网页内容】</span></a>
												<div id="script10" style="display:none;">
													<textarea rows="10" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.shadowsocks_mydomain_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.shadowsocks_mydomain_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr id="ss_config1">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script11')"><span>点这里自定义内网(LAN)IP访问代理转发控制功能【当开启广告过滤时此设置无效】</span></a>
												<div id="script11" style="display:none;">
													<div class="alert alert-info" style="margin-top: 10px;"><p>内网(LAN)IP访问控制的默认代理转发设置：
													<select name="LAN_AC_IP" class="input" >
														<option value="0" <% nvram_match_x("","LAN_AC_IP", "0","selected"); %>>【0】常规, 默认值</option>
														<option value="1" <% nvram_match_x("","LAN_AC_IP", "1","selected"); %>>【1】全局</option>
														<option value="2" <% nvram_match_x("","LAN_AC_IP", "2","selected"); %>>【2】绕过</option>
													</select></p>
													<p>0 默认值, 常规, 未在以下设定的 内网IP 根据 SS配置工作模式 走 SS</p>
													<p>1 全局, 未在以下设定的 内网IP 使用全局代理 走 SS</p>
													<p>2 绕过, 未在以下设定的 内网IP 不使用 SS</p></div>
													<div class="alert alert-info" style="margin-top: 10px;"><p>内网(LAN)IP设定行为设置, 格式如 b,192.168.1.23, 每一行一个配置：</p>
													<p>使用 b/g/n/1/2 前缀定义主机行为模式, 使用英文逗号与主机 IP、MAC 分隔</p>
													<p>b: 绕过, 此前缀的主机IP、MAC 不使用 SS</p>
													<p>g: 全局, 此前缀的主机IP、MAC 使用 全局代理 走 SS</p>
													<p>n: 常规, 此前缀的主机IP、MAC 使用 SS配置工作模式 走 SS</p>
													<p>1: 大陆白名单, 此前缀的主机IP、MAC 使用 大陆白名单模式 走 SS</p>
													<p>2: gfwlist, 此前缀的主机IP、MAC 使用 gfwlist模式 走 SS</p>
													<p>优先级: 绕过 > 全局 > 常规 > gfwlist > 大陆白名单 > MAC > IP</p>
													<p>IPv6地址：必须以 ~ 符号开头，如 ~b,2333:2333:2333::</p>
													<p>MAC 地址：必须以 @ 符号开头，如 @b,099B9A909FD9</p>
													<p>（不支持使用[-][:]符号多选,如多个设置则每一个ip一行,可选项：删除前面的#可生效）</p><textarea rows="10" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.shadowsocks_ss_spec_lan.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.shadowsocks_ss_spec_lan.sh",""); %></textarea></div>
												</div>
											</td>
										</tr>
										<tr id="ss_config2">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script12')"><span>点这里自定义强制WAN的IP转发或忽略代理中转设置控制功能</span></a>
												<div id="script12" style="display:none;">
													<div class="alert alert-info" style="margin-top: 10px;"><p>强制WAN的IP转发或忽略代理中转设置 ：</p>
													<p>使用 b/g 前缀定义访问目标行为模式, 使用英文逗号与目标 IP 分隔</p>
													<p>b: 绕过, 此前缀的目标IP 不使用 SS</p>
													<p>g: 全局, 此前缀的目标IP 使用 SS</p>
													<p>G: 全局所有端口, 此前缀的目标IP [1:65535] 使用 SS</p>
													<p>IPv6地址：必须以 ~ 符号开头，如 ~b,2333:2333:2333::</p>
													<p>网址域名：必须以 @ 符号开头，如 @b,abc.net，匹配 abc.net、*.abc.net</p>
													<p>优先级: 绕过 > 全局</p>
													<p>（不支持使用[-][:]符号多选,每一个域名、IP一行,可选项：删除前面的#可生效）</p><textarea rows="15" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.shadowsocks_ss_spec_wan.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.shadowsocks_ss_spec_wan.sh",""); %></textarea></div>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="3" style="border-top: 0 none;">
												<br />
												<center><input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" /></center>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</form>
	<div id="footer"></div>
</div>
</body>
</html>

