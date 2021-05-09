<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - DNSPod 域名解析</title>
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

	init_itoggle('dnspod_enable',change_dnspod_enable_bridge);
	init_itoggle('dns_com_pod_enable',change_dns_com_pod_enable_bridge);

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "dnspod_L2"); %>,<% nvram_get_x("", "dnspod_L3"); %>);
	show_footer();

	change_dnspod_enable_bridge(1);
	change_dns_com_pod_enable_bridge(1);
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
		document.form.current_page.value = "/Advanced_Extensions_DNSPod.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}


function done_validating(action){
	refreshpage();
}

function change_dnspod_enable_bridge(mflag){
	var m = document.form.dnspod_enable[0].checked;
	showhide_div("dnspod_interval_tr", m);
	showhide_div("dnspod_username_tr", m);
	showhide_div("dnspod_password_tr", m);
	showhide_div("dnspod_Token_tr", m);
	showhide_div("dnspod_domian_tr", m);
	showhide_div("dnspod_domian2_tr", m);
	showhide_div("dnspod_domian6_tr", m);
}

function change_dns_com_pod_enable_bridge(mflag){
	var m = document.form.dns_com_pod_enable[0].checked;
	showhide_div("dns_com_pod_interval_tr", m);
	showhide_div("dns_com_pod_username", m);
	showhide_div("dns_com_pod_password_tr", m);
	showhide_div("dns_com_pod_user_token_tr", m);
	showhide_div("dns_com_pod_domian_tr", m);
	showhide_div("dns_com_pod_domian2_tr", m);
	showhide_div("dns_com_pod_domian6_tr", m);
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_DNSPod.asp">
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
							<h2 class="box_head round_top">DNSPod 域名解析</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">使用 DNSPod 实现顶级个人域名的 ddns 服务。 <a href="https://www.dnspod.cn/" target="blank"><i><u>DNSPod 中国版主页</u></i></a> <a href="https://www.dnspod.com/" target="blank"><i><u>DNSPod 国际版主页</u></i></a>
												<ul style="padding-top:5px;margin-top:10px;float: left;">
												<li><a href="https://github.com/anrip/ArDNSPod" target="blank"><i><u>ArDNSPod 项目地址：https://github.com/anrip/ArDNSPod</u></i></a></li>
												<li>使用前需要将域名添加到 DNSPod 中，并添加一条A记录，使用之后将自动更新ip</li>
												<li>dnspod账户·密码 和 DNSPod Token 选填一组，推荐使用DNSPod Token，可以保护账户安全</li>
												<li>【dnspod.cn 】 中国版 点 <a href="https://support.dnspod.cn/Kb/showarticle/tsid/227" target="blank"><i><u>这里</u></i></a> 查看官方说明以及如何获取DNSPod Token</li>
												<li>【dnspod.com】国际版 点 <a href="https://www.dnspod.com/docs/info.html#get-the-user-token" target="blank"><i><u>这里</u></i></a> 查看官方说明以及如何获取DNSPod Token</li>
												<li>【注意】不要开启D-Token，会影响API使用。</li>
												</ul></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th style="background-color: #E3E3E3;">DNSPod 中国版</th>
											<td style="border-top: 0 none;"></td>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 DNSPod 中国版 域名解析</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="dnspod_enable_on_of">
														<input type="checkbox" id="dnspod_enable_fake" <% nvram_match_x("", "dnspod_enable", "1", "value=1 checked"); %><% nvram_match_x("", "dnspod_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="dnspod_enable" id="dnspod_enable_1" class="input" value="1" onClick="change_dnspod_enable_bridge(1);" <% nvram_match_x("", "dnspod_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="dnspod_enable" id="dnspod_enable_0" class="input" value="0" onClick="change_dnspod_enable_bridge(1);" <% nvram_match_x("", "dnspod_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="dnspod_interval_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">检查周期(秒) :</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="dnspod_interval" name="dnspod_interval" placeholder="600" value="<% nvram_get_x("","dnspod_interval"); %>"  onkeypress="return is_number(this,event);" />
											</td>
										</tr>
										<tr id="dnspod_username_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">用户名称:</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="dnspod_username" name="dnspod_username" value="<% nvram_get_x("","dnspod_username"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="dnspod_password_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">用户密码:</a></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="dnspod_password" id="dnspod_password" style="width: 175px;" value="<% nvram_get_x("","dnspod_password"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('dnspod_password')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="dnspod_Token_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">ID,Token:</a></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="dnspod_Token" placeholder="12345,7676f344eaeaea9074c123451234512d" id="dnspod_Token" style="width: 175px;" value="<% nvram_get_x("","dnspod_Token"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('dnspod_Token')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="dnspod_domian_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名1</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="dnspod_host" name="dnspod_host" placeholder="www" value="<% nvram_get_x("","dnspod_host"); %>" onKeyPress="return is_string(this,event);" > . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="dnspod_domian" name="dnspod_domian" placeholder="google.com" value="<% nvram_get_x("","dnspod_domian"); %>" onKeyPress="return is_string(this,event);" >
											</td>
										</tr>
										<tr id="dnspod_domian2_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名2</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="dnspod_host2" name="dnspod_host2" placeholder="www" value="<% nvram_get_x("","dnspod_host2"); %>" onKeyPress="return is_string(this,event);" > . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="dnspod_domian2" name="dnspod_domian2" placeholder="google.com" value="<% nvram_get_x("","dnspod_domian2"); %>" onKeyPress="return is_string(this,event);" >
											</td>
										</tr>
										<tr id="dnspod_domian6_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名3[IPv6]</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="dnspod_host6" name="dnspod_host6" placeholder="www" value="<% nvram_get_x("","dnspod_host6"); %>" onKeyPress="return is_string(this,event);" > . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="dnspod_domian6" name="dnspod_domian6" placeholder="google.com" value="<% nvram_get_x("","dnspod_domian6"); %>" onKeyPress="return is_string(this,event);" >
											</td>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th style="background-color: #E3E3E3;">DNSPod 国际版</th>
											<td style="border-top: 0 none;"></td>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 DNSPod 国际版 域名解析</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="dns_com_pod_enable_on_of">
														<input type="checkbox" id="dns_com_pod_enable_fake" <% nvram_match_x("", "dns_com_pod_enable", "1", "value=1 checked"); %><% nvram_match_x("", "dns_com_pod_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="dns_com_pod_enable" id="dns_com_pod_enable_1" class="input" value="1" onClick="change_dns_com_pod_enable_bridge(1);" <% nvram_match_x("", "dns_com_pod_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="dns_com_pod_enable" id="dns_com_pod_enable_0" class="input" value="0" onClick="change_dns_com_pod_enable_bridge(1);" <% nvram_match_x("", "dns_com_pod_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="dns_com_pod_interval_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">检查周期(秒) :</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="dns_com_pod_interval" name="dns_com_pod_interval" placeholder="600" value="<% nvram_get_x("","dns_com_pod_interval"); %>"  onkeypress="return is_number(this,event);" />
											</td>
										</tr>
										<tr id="dns_com_pod_username" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">用户名称:</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="255" class="input" size="15" id="dns_com_pod_username" name="dns_com_pod_username" value="<% nvram_get_x("","dns_com_pod_username"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="dns_com_pod_password_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">用户密码:</a></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="dns_com_pod_password" id="dns_com_pod_password" style="width: 175px;" value="<% nvram_get_x("","dns_com_pod_password"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('dns_com_pod_password')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="dns_com_pod_user_token_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">ID,Token:</a></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="dns_com_pod_user_token" placeholder="730060,e1a8a$f14dc5dcbafd83680b3d2a553c4d553d" id="dns_com_pod_user_token" style="width: 175px;" value="<% nvram_get_x("","dns_com_pod_user_token"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('dns_com_pod_user_token')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="dns_com_pod_domian_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名1</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="dns_com_pod_host" name="dns_com_pod_host" placeholder="www" value="<% nvram_get_x("","dns_com_pod_host"); %>" onKeyPress="return is_string(this,event);" > . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="dns_com_pod_domian" name="dns_com_pod_domian" placeholder="google.com" value="<% nvram_get_x("","dns_com_pod_domian"); %>" onKeyPress="return is_string(this,event);" >
											</td>
										</tr>
										<tr id="dns_com_pod_domian2_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名2</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="dns_com_pod_host2" name="dns_com_pod_host2" placeholder="www" value="<% nvram_get_x("","dns_com_pod_host2"); %>" onKeyPress="return is_string(this,event);" > . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="dns_com_pod_domian2" name="dns_com_pod_domian2" placeholder="google.com" value="<% nvram_get_x("","dns_com_pod_domian2"); %>" onKeyPress="return is_string(this,event);" >
											</td>
										</tr>
										<tr id="dns_com_pod_domian6_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名3[IPv6]</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="dns_com_pod_host6" name="dns_com_pod_host6" placeholder="www" value="<% nvram_get_x("","dns_com_pod_host6"); %>" onKeyPress="return is_string(this,event);" > . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="dns_com_pod_domian6" name="dns_com_pod_domian6" placeholder="google.com" value="<% nvram_get_x("","dns_com_pod_domian6"); %>" onKeyPress="return is_string(this,event);" >
											</td>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr id="row_post_wan_script">
											<td style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script2')"><span>DNSPod脚本-基于DNSPod用户API实现的纯Shell动态域名客户端</span></a>
												<div id="script2" style="display:none;">
													<textarea rows="18" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.ddns_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.ddns_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<td style="border-top: 0 none;">
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

