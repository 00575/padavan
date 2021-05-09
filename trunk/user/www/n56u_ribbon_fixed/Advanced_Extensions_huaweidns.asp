<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - huaweidns 域名解析</title>
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

	init_itoggle('huaweidns_enable',change_huaweidns_enable_bridge);

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "huaweidns_L2"); %>,<% nvram_get_x("", "huaweidns_L3"); %>);
	show_footer();

	change_huaweidns_enable_bridge(1);

	if (!login_safe())
		textarea_scripts_enabled(0);

}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.ddns_script.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_huaweidns.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}


function done_validating(action){
	refreshpage();
}

function change_huaweidns_enable_bridge(mflag){
	var m = document.form.huaweidns_enable[0].checked;
	showhide_div("huaweidns_interval_tr", m);
	showhide_div("huaweidns_username_tr", m);
	showhide_div("huaweidns_password_tr", m);
	//showhide_div("huaweidns_Token_tr", m);
	showhide_div("huaweidns_domian_tr", m);
	showhide_div("huaweidns_domian2_tr", m);
	showhide_div("huaweidns_domian6_tr", m);
	showhide_div("row_post_wan_script", m);
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_huaweidns.asp">
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
							<h2 class="box_head round_top">huaweidns 域名解析</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">使用 huaweidns 云解析服务（Domain Name Service，DNS）提供高可用、高扩展的DNS服务。 <a href="https://console.huaweicloud.com/dns" target="blank"><i><u>huaweidns 云解析服务 控制台</u></i></a>
												<ul style="padding-top:5px;margin-top:10px;float: left;">
												<li>什么是云解析服务？把人们常用的域名（如 www.example.com）转换成用于计算机连接的IP地址（如 192.1.2.3）。云解析服务可以让您直接在浏览器中输入域名，访问网站或Web应用程序。</li>
												<li>使用前需到华为云DNS控制台手动增加公网域名</li>
												<li>点 <a href="https://support.huaweicloud.com/usermanual-dns/zh-cn_topic_0035467702.html" target="blank"><i><u>《管理公网域名指南》</u></i></a> 查看官方说明以及如何增加公网域名。</li>
												</ul></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 huaweidns 域名解析</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="huaweidns_enable_on_of">
														<input type="checkbox" id="huaweidns_enable_fake" <% nvram_match_x("", "huaweidns_enable", "1", "value=1 checked"); %><% nvram_match_x("", "huaweidns_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="huaweidns_enable" id="huaweidns_enable_1" class="input" value="1" onClick="change_huaweidns_enable_bridge(1);" <% nvram_match_x("", "huaweidns_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="huaweidns_enable" id="huaweidns_enable_0" class="input" value="0" onClick="change_huaweidns_enable_bridge(1);" <% nvram_match_x("", "huaweidns_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="huaweidns_interval_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">检查周期(秒) :</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="huaweidns_interval" name="huaweidns_interval" placeholder="300" value="<% nvram_get_x("","huaweidns_interval"); %>"  onkeypress="return is_number(this,event);" />
											</td>
										</tr>
										<tr id="huaweidns_username_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">用户名 :</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="255" class="input" size="15" id="huaweidns_username" name="huaweidns_username" value="<% nvram_get_x("","huaweidns_username"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="huaweidns_password_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">登录密码 :</a></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="huaweidns_password" id="huaweidns_password" style="width: 175px;" value="<% nvram_get_x("","huaweidns_password"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('huaweidns_password')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="huaweidns_Token_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">Token:</a></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="huaweidns_Token" id="huaweidns_Token" style="width: 175px;" value="<% nvram_get_x("","huaweidns_Token"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('huaweidns_Token')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="huaweidns_domian_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名1</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="huaweidns_host" name="huaweidns_host" placeholder="www" value="<% nvram_get_x("","huaweidns_host"); %>" onKeyPress="return is_string(this,event);" /> . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="huaweidns_domian" name="huaweidns_domian" placeholder="google.com" value="<% nvram_get_x("","huaweidns_domian"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="huaweidns_domian2_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名2</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="huaweidns_host2" name="huaweidns_host2" placeholder="www" value="<% nvram_get_x("","huaweidns_host2"); %>" onKeyPress="return is_string(this,event);" /> . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="huaweidns_domian2" name="huaweidns_domian2" placeholder="google.com" value="<% nvram_get_x("","huaweidns_domian2"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="huaweidns_domian6_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名3[IPv6]</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="huaweidns_host6" name="huaweidns_host6" placeholder="www" value="<% nvram_get_x("","huaweidns_host6"); %>" onKeyPress="return is_string(this,event);" /> . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="huaweidns_domian6" name="huaweidns_domian6" placeholder="google.com" value="<% nvram_get_x("","huaweidns_domian6"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="row_post_wan_script" style="display:none;">
											<td colspan="2" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script2')"><span>huaweidns脚本-基于huaweidns用户API实现的纯Shell动态域名客户端</span></a>
												<div id="script2" style="display:none;">
													<textarea rows="18" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.ddns_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.ddns_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										

										<tr>
											<td colspan="2" style="border-top: 0 none;">
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

