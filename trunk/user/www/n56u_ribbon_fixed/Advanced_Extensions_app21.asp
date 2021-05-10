<!DOCTYPE html>
<!--app21_ver=2021-02-21=-->
<html>
<head>
<title><#Web_Title#> - ss_tproxy</title>
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

	init_itoggle('app_109',change_ss_tproxy_enable);
	init_itoggle('ss_DNS_Redirect',change_ss_DNS_Redirect);
	init_itoggle('ss_pdnsd_all',change_ss_pdnsd_all);
	init_itoggle('ss_3p_enable',change_ss_3p_enable);
	init_itoggle('ss_3p_gfwlist');
	init_itoggle('ss_3p_kool');
	init_itoggle('ss_sub1');
	init_itoggle('ss_sub2');
	init_itoggle('ss_sub3');
	init_itoggle('ss_udp_enable');

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	show_menu(8,<% nvram_get_x("", "ss_tproxy_L2"); %>,<% nvram_get_x("", "ss_tproxy_L3"); %>);
	show_footer();
	change_ss_DNS_Redirect();
	change_dns_start_dnsproxy();
	change_ss_pdnsd_all();
	change_ss_3p_enable();
	change_ss_tproxy_enable(1);
	if (!login_safe())
		textarea_scripts_enabled(0);

}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.app_26.sh'], v);
	inputCtrl(document.form['scripts.app_27.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_app21.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function done_validating(action){
	refreshpage();
}

function change_ss_tproxy_enable(mflag){
	var m = document.form.app_109.value;
	var is_ss_tproxy_enable = (m == "1") ? "重启" : "更新";
	document.form.updatess_tproxy.value = is_ss_tproxy_enable;
}
function button_updatess_tproxy(){
	change_ss_tproxy_enable(1);
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' updateapp21 ',
	});
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_app21.asp">
	<input type="hidden" name="next_page" value="">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="APP;LANHostConfig;General;">
	<input type="hidden" name="group_id" value="">
	<input type="hidden" name="action_mode" value="">
	<input type="hidden" name="action_script" value="">
	<input type="hidden" name="wan_ipaddr" value="<% nvram_get_x("", "wan0_ipaddr"); %>" readonly="1">
	<input type="hidden" name="wan_netmask" value="<% nvram_get_x("", "wan0_netmask"); %>" readonly="1">
	<input type="hidden" name="dhcp_start" value="<% nvram_get_x("", "dhcp_start"); %>">
	<input type="hidden" name="ss_enable_o" value="<% nvram_get_x("", "ss_enable"); %>">
	<input type="hidden" name="dhcp_end" value="<% nvram_get_x("", "dhcp_end"); %>">
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
							<h2 class="box_head round_top">ss_tproxy</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">欢迎使用 ss_tproxy ，这一个配合 iptables(REDIRECT/TPROXY) 实现透明代理的实用工具。
									<div>项目地址：<a href="https://github.com/zfl9/ss-tproxy" target="blank">https://github.com/zfl9/ss-tproxy</a></div>
									<div>当前 app 文件:【<% nvram_get_x("", "app21_ver"); %>】，最新 app 文件:【<% nvram_get_x("", "app21_ver_n"); %>】 </div>
									<div>【使用者: <% nvram_get_x("", "ss_tproxy_auser"); %>】 【<% nvram_get_x("", "gfwlist_list"); %>】</div>
									<div>【<% nvram_get_x("", "chnroute_list"); %>】 【<% nvram_get_x("", "chnroute6_list"); %>】</div>
									<span style="color:#FF0000;" class=""></span></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr id="ss_tproxy_enable_tr" >
											<th width="30%">ss_tproxy 开关</th>
											<td>
													<div class="main_itoggle">
													<div id="app_109_on_of">
														<input type="checkbox" id="app_109_fake" <% nvram_match_x("", "app_109", "1", "value=1 checked"); %><% nvram_match_x("", "app_109", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="app_109" id="app_109_1" class="input" value="1" onClick="change_ss_tproxy_enable(1);" <% nvram_match_x("", "app_109", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="app_109" id="app_109_0" class="input" value="0" onClick="change_ss_tproxy_enable(1);" <% nvram_match_x("", "app_109", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td colspan="1">
												<input class="btn btn-success" style="width:60px" type="button" name="updatess_tproxy" value="更新" onclick="button_updatess_tproxy()" />
												<span style="color:#888;">版本：<% nvram_get_x("","ss_tproxy_v"); %></span>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">ss_tproxy 工作模式</th>
											<td style="border-top: 0 none;">
												<select name="app_110" class="input">
													<option value="0" <% nvram_match_x("","app_110", "0","selected"); %>>【自动】设置配置文件</option>
													<option value="1" <% nvram_match_x("","app_110", "1","selected"); %>>【手动】设置配置文件</option>
												</select>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">ss_tproxy 脚本</th>
											<td style="border-top: 0 none;">
												<select name="app_111" class="input">
													<option value="0" <% nvram_match_x("","app_111", "0","selected"); %>>启动以下 ss_tproxy 内置命令</option>
													<option value="1" <% nvram_match_x("","app_111", "1","selected"); %>>更新 gfwlist + chnroute 规则</option>
													<option value="2" <% nvram_match_x("","app_111", "2","selected"); %>>更新 chnroute [白名单IP]规则</option>
													<option value="3" <% nvram_match_x("","app_111", "3","selected"); %>>更新 gfwlist [黑名单域名]规则</option>
													<option value="4" <% nvram_match_x("","app_111", "4","selected"); %>>更新 chnlist [白名单域名]规则</option>
													<option value="5" <% nvram_match_x("","app_111", "5","selected"); %>>更新 [全部] 规则</option>
													<option value="6" <% nvram_match_x("","app_111", "6","selected"); %>>手动更新脚本</option>
													<option value="7" <% nvram_match_x("","app_111", "7","selected"); %>>重置 ss_tproxy 数据(出错了？重置试试)</option>
												</select>
											</td>
										</tr>
										<tr id="ss_DNS_Redirect_tr" >
											<th width="30%"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,15);">重定向 DNS(chromecast、建议gfwlist模式开启)</a></th>
											<td>
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
										<tr id="ss_pdnsd_all_tr">
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
										<tr>
											<th style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,9);">游戏模式（UDP转发）</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_udp_enable_on_of">
														<input type="checkbox" id="ss_udp_enable_fake" <% nvram_match_x("", "ss_udp_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ss_udp_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_udp_enable" id="ss_udp_enable_1" class="input" value="1" <% nvram_match_x("", "ss_udp_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_udp_enable" id="ss_udp_enable_0" class="input" value="0" <% nvram_match_x("", "ss_udp_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">路由自身流量透明代理选择</th>
											<td style="border-top: 0 none;" colspan="2">
												<select style=" width: 390px; " name="app_114" class="input">
													<option value="0" <% nvram_match_x("","app_114", "0","selected"); %>>代理路由自身流量</option>
													<option value="1" <% nvram_match_x("","app_114", "1","selected"); %>>跳过代理路由自身流量</option>
												</select>
											</td>
										</tr>
										<tr>
											<td colspan="4" style="border-top: 0 none;">
												<br />
												<center><input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" /></center>
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
										<tr id="app_26_script" colspan="4">
											<td colspan="4">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('app_26')"><span>ss_tproxy启动前运行脚本</span><div>&nbsp;<span style="color:#888;">查看以下文件修改 运行脚本。文件路径 /etc/storage/app_26.sh</span></div></a>
												<div id="app_26" >
													<textarea rows="8" wrap="off" spellcheck="false" maxlength="18192" class="span12" name="scripts.app_26.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.app_26.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr id="app_27_script" colspan="4">
											<td colspan="4" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('app_27')"><span>ss_tproxy配置文件</span><div>&nbsp;<span style="color:#888;">查看以下文件修改 配置参数(手动模式才需要DIY修改)。文件路径 /etc/storage/app_27.sh</span></div></a>
												<div id="app_27" >
													<textarea rows="18" wrap="off" spellcheck="false" maxlength="18192" class="span12" name="scripts.app_27.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.app_27.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr id="ss_gfwlist2">
											<td colspan="4" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script10')"><span>点这里自定义gfwlist的域名，强制代理转发【例：abc.com 每行一个，无需加入www，只要域名，后面也不用带任何符号或者网页内容】</span></a>
												<div id="script10" style="display:none;">
													<textarea rows="10" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.shadowsocks_mydomain_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.shadowsocks_mydomain_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr id="ss_config1">
											<td colspan="4" style="border-top: 0 none;">
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
											<td colspan="4" style="border-top: 0 none;">
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
											<td colspan="4" style="border-top: 0 none;">
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

