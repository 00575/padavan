<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - Ngrok 内网穿透</title>
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
	init_itoggle('ngrok_enable',change_ngrok_enable_bridge);
	init_itoggle('ngrok_domain',change_ngrok_domain_bridge);
	init_itoggle('ngrok_tcp',change_ngrok_tcp_bridge);
	init_itoggle('ngrok_custom',change_ngrok_custom_bridge);
});
</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "ngrok_L2"); %>,<% nvram_get_x("", "ngrok_L3"); %>);
	show_footer();
	
	change_ngrok_enable_bridge(1);
	change_ngrok_domain_bridge(1);
	change_ngrok_tcp_bridge(1);
	change_ngrok_custom_bridge(1);
	if (!login_safe())
		textarea_scripts_enabled(0);
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.ngrok_script.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_ngrok.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function change_ngrok_enable_bridge(mflag){
	var m = document.form.ngrok_enable[0].checked;
//	showhide_div("ngrok_script", m);
}

function done_validating(action){
	refreshpage();
}

function change_ngrok_domain_bridge(mflag){
	var m = document.form.ngrok_domain[0].checked;
	showhide_div("ngrok_domain_lhost", m);
	showhide_div("ngrok_domain_lport", m);
	showhide_div("ngrok_domain_type", m);
	showhide_div("ngrok_domain_sdname", m);
}

function change_ngrok_tcp_bridge(mflag){
	var m = document.form.ngrok_tcp[0].checked;
	
	showhide_div("ngrok_tcp_lhost", m);
	showhide_div("ngrok_tcp_lport", m);
	showhide_div("ngrok_tcp_type", m);
	showhide_div("ngrok_tcp_rport", m);
}

function change_ngrok_custom_bridge(mflag){
	var m = document.form.ngrok_custom[0].checked;
	
	showhide_div("ngrok_custom_lhost", m);
	showhide_div("ngrok_custom_lport", m);
	showhide_div("ngrok_custom_type", m);
	showhide_div("ngrok_custom_hostname", m);
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_ngrok.asp">
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
							<h2 class="box_head round_top">Ngrok 内网穿透</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">Ngrok 是一个反向代理，通过在公共的端点和本地运行的 Web 服务器之间建立一个安全的通道。</div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 Ngrok 内网穿透</a></th>
											<td style="border-top: 0 none;">
												<div class="main_itoggle">
													<div id="ngrok_enable_on_of">
														<input type="checkbox" id="ngrok_enable_fake" <% nvram_match_x("", "ngrok_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ngrok_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ngrok_enable" id="ngrok_enable_1" class="input" value="1" onClick="change_ngrok_enable_bridge(1);" <% nvram_match_x("", "ngrok_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ngrok_enable" id="ngrok_enable_0" class="input" value="0" onClick="change_ngrok_enable_bridge(1);" <% nvram_match_x("", "ngrok_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">服务器地址：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="ngrok_server" name="ngrok_server" value="<% nvram_get_x("","ngrok_server"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">[server.ngrok.cc]</span>
												</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">服务器端口：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="ngrok_port" name="ngrok_port" value="<% nvram_get_x("","ngrok_port"); %>" onKeyPress="return is_number(this,event);" />
												&nbsp;<span style="color:#888;">[4443]</span>
												</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">服务器 Token：</th>
											<td style="border-top: 0 none;">
												<input type="password" maxlength="128" class="input" size="15" id="ngrok_token" name="ngrok_token" style="width: 175px;" value="<% nvram_get_x("","ngrok_token"); %>" onKeyPress="return is_string(this,event);" />
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('ngrok_token')"><i class="icon-eye-close"></i></button>
											</td>
										</tr>
										
										<tr>
											<th width="30%" style="border-top: 0 none;">系统分配域名映射</th>
											<td style="border-top: 0 none;">
												<div class="main_itoggle">
													<div id="ngrok_domain_on_of">
														<input type="checkbox" id="ngrok_domain_fake" <% nvram_match_x("", "ngrok_domain", "1", "value=1 checked"); %><% nvram_match_x("", "ngrok_domain", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ngrok_domain" id="ngrok_domain_1" class="input" value="1" onClick="change_ngrok_domain_bridge(1);" <% nvram_match_x("", "ngrok_domain", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ngrok_domain" id="ngrok_domain_0" class="input" value="0" onClick="change_ngrok_domain_bridge(1);" <% nvram_match_x("", "ngrok_domain", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="ngrok_domain_type" style="display:none;">
											<th width="30%" style="border-top: 0 none;">协议类型：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="ngrok_domain_type" name="ngrok_domain_type" value="<% nvram_get_x("","ngrok_domain_type"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">[http] [https] [tcp]</span>
											</td>
										</tr>
										<tr id="ngrok_domain_lhost" style="display:none;">
											<th width="30%" style="border-top: 0 none;">本地地址：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="ngrok_domain_lhost" name="ngrok_domain_lhost" value="<% nvram_get_x("","ngrok_domain_lhost"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">[ <% nvram_get_x("","lan_ipaddr"); %> ]</span>
											</td>
										</tr>
										<tr id="ngrok_domain_lport" style="display:none;">
											<th width="30%" style="border-top: 0 none;">本地端口：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="ngrok_domain_lport" name="ngrok_domain_lport" value="<% nvram_get_x("","ngrok_domain_lport"); %>" onKeyPress="return is_number(this,event);" />
												&nbsp;<span style="color:#888;">[80]</span>
											</td>
										</tr>
										<tr id="ngrok_domain_sdname" style="display:none;">
											<th width="30%" style="border-top: 0 none;">分配域名：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="ngrok_domain_sdname" name="ngrok_domain_sdname" value="<% nvram_get_x("","ngrok_domain_sdname"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">服务器分配的域名</span>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">TCP 端口转发映射</th>
											<td style="border-top: 0 none;">
												<div class="main_itoggle">
													<div id="ngrok_tcp_on_of">
														<input type="checkbox" id="ngrok_tcp_fake" <% nvram_match_x("", "ngrok_tcp", "1", "value=1 checked"); %><% nvram_match_x("", "ngrok_tcp", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ngrok_tcp" id="ngrok_tcp_1" class="input" value="1" onClick="change_ngrok_tcp_bridge(1);" <% nvram_match_x("", "ngrok_tcp", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ngrok_tcp" id="ngrok_tcp_0" class="input" value="0" onClick="change_ngrok_tcp_bridge(1);" <% nvram_match_x("", "ngrok_tcp", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="ngrok_tcp_type" style="display:none;">
											<th width="30%" style="border-top: 0 none;">协议类型：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="ngrok_tcp_type" name="ngrok_tcp_type" value="<% nvram_get_x("","ngrok_tcp_type"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">[http] [https] [tcp]</span>
											</td>
										</tr>
										<tr id="ngrok_tcp_lhost" style="display:none;">
											<th width="30%" style="border-top: 0 none;">本地地址：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="ngrok_tcp_lhost" name="ngrok_tcp_lhost" value="<% nvram_get_x("","ngrok_tcp_lhost"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">[ <% nvram_get_x("","lan_ipaddr"); %> ]</span>
											</td>
										</tr>
										<tr id="ngrok_tcp_lport" style="display:none;">
											<th width="30%" style="border-top: 0 none;">本地端口：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="ngrok_tcp_lport" name="ngrok_tcp_lport" value="<% nvram_get_x("","ngrok_tcp_lport"); %>" onKeyPress="return is_number(this,event);" />
												&nbsp;<span style="color:#888;">[22]</span>
											</td>
										</tr>
										<tr id="ngrok_tcp_rport" style="display:none;">
											<th width="30%" style="border-top: 0 none;">远程端口：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="ngrok_tcp_rport" name="ngrok_tcp_rport" value="<% nvram_get_x("","ngrok_tcp_rport"); %>" onKeyPress="return is_number(this,event);" />
												&nbsp;<span style="color:#888;">[50000]</span>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">自定义域名映射</th>
											<td style="border-top: 0 none;">
												<div class="main_itoggle">
													<div id="ngrok_custom_on_of">
														<input type="checkbox" id="ngrok_custom_fake" <% nvram_match_x("", "ngrok_custom", "1", "value=1 checked"); %><% nvram_match_x("", "ngrok_custom", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ngrok_custom" id="ngrok_custom_1" class="input" value="1" onClick="change_ngrok_custom_bridge(1);" <% nvram_match_x("", "ngrok_custom", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ngrok_custom" id="ngrok_custom_0" class="input" value="0" onClick="change_ngrok_custom_bridge(1);" <% nvram_match_x("", "ngrok_custom", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="ngrok_custom_type" style="display:none;">
											<th width="30%" style="border-top: 0 none;">协议类型：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="ngrok_custom_type" name="ngrok_custom_type" value="<% nvram_get_x("","ngrok_custom_type"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">[http] [https] [tcp]</span>
											</td>
										</tr>
										<tr id="ngrok_custom_lhost" style="display:none;">
											<th width="30%" style="border-top: 0 none;">本地地址：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="ngrok_custom_lhost" name="ngrok_custom_lhost" value="<% nvram_get_x("","ngrok_custom_lhost"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">[ <% nvram_get_x("","lan_ipaddr"); %> ]</span>
											</td>
										</tr>
										<tr id="ngrok_custom_lport" style="display:none;">
											<th width="30%" style="border-top: 0 none;">本地端口：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="ngrok_custom_lport" name="ngrok_custom_lport" value="<% nvram_get_x("","ngrok_custom_lport"); %>" onKeyPress="return is_number(this,event);" />
												&nbsp;<span style="color:#888;">[80]</span>
											</td>
										</tr>
										<tr id="ngrok_custom_hostname" style="display:none;">
											<th width="30%" style="border-top: 0 none;">自定义域名：</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="ngrok_custom_hostname" name="ngrok_custom_hostname" value="<% nvram_get_x("","ngrok_custom_hostname"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">[ xx.xxx.com ] 备注:需解析到服务器地址</span>
											</td>
										</tr>
										<tr id="ngrok_script" colspan="3">
											<td colspan="2" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script12')"><span>ngrok_script</span><div>&nbsp;<span style="color:#888;">以下脚本可以修改 ngrok 启动参数</span></div></a>
												<div id="script12" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.ngrok_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.ngrok_script.sh",""); %></textarea>
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

