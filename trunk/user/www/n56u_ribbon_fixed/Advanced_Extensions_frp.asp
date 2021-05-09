<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - frp 内网穿透</title>
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
	init_itoggle('frp_enable');
	init_itoggle('frpc_enable');
	init_itoggle('frps_enable');
});
</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "frp_L2"); %>,<% nvram_get_x("", "frp_L3"); %>);
	show_footer();
	
	change_frp_enable_bridge(1);
	if (!login_safe())
		textarea_scripts_enabled(0);

}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.frp_script.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_frp.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function change_frp_enable_bridge(){
	var m = document.form.frp_enable.value;
	var is_frp_enable = (m == "1") ? "重启" : "更新";
	document.form.updatefrp.value = is_frp_enable;
}
function button_updatefrp(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' updatefrp ',
	});
}


function done_validating(action){
	refreshpage();
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_frp.asp">
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
							<h2 class="box_head round_top">frp 内网穿透</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">frp 是一个高性能的反向代理应用，可以帮助您轻松地进行内网穿透，对外网提供服务，支持 tcp, http, https 等协议类型，并且 web 服务支持根据域名进行路由转发。
									<div>下载地址: <a href="https://github.com/fatedier/frp/releases" target="blank">https://github.com/fatedier/frp/releases</a></div>
									<div>教程地址: <a href="https://github.com/fatedier/frp/blob/master/README_zh.md" target="blank">中文文档</a> <a href="https://www.right.com.cn/FORUM/thread-484829-1-1.html" target="blank1">frp图文教程</a></div></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 frp 内网穿透</a></th>
											<td style="border-top: 0 none;">
												<div class="main_itoggle">
													<div id="frp_enable_on_of">
														<input type="checkbox" id="frp_enable_fake" <% nvram_match_x("", "frp_enable", "1", "value=1 checked"); %><% nvram_match_x("", "frp_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="frp_enable" id="frp_enable_1" class="input" value="1"  <% nvram_match_x("", "frp_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="frp_enable" id="frp_enable_0" class="input" value="0"  <% nvram_match_x("", "frp_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td colspan="1" style="border-top: 0 none;">
												<input class="btn btn-success" style="width:60px" type="button" name="updatefrp" value="重启、更新程序" onclick="button_updatefrp()" />
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 frpc 客户端</a></th>
											<td style="border-top: 0 none;">
												<div class="main_itoggle">
													<div id="frpc_enable_on_of">
														<input type="checkbox" id="frpc_enable_fake" <% nvram_match_x("", "frpc_enable", "1", "value=1 checked"); %><% nvram_match_x("", "frpc_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="frpc_enable" id="frpc_enable_1" class="input" value="1"  <% nvram_match_x("", "frpc_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="frpc_enable" id="frpc_enable_0" class="input" value="0"  <% nvram_match_x("", "frpc_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td colspan="1" style="border-top: 0 none;">
												<span style="color:#888;">版本：<% nvram_get_x("","frpc_v"); %></span>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 frps 服务端</a></th>
											<td style="border-top: 0 none;">
												<div class="main_itoggle">
													<div id="frps_enable_on_of">
														<input type="checkbox" id="frps_enable_fake" <% nvram_match_x("", "frps_enable", "1", "value=1 checked"); %><% nvram_match_x("", "frps_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="frps_enable" id="frps_enable_1" class="input" value="1"  <% nvram_match_x("", "frps_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="frps_enable" id="frps_enable_0" class="input" value="0"  <% nvram_match_x("", "frps_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td colspan="1" style="border-top: 0 none;">
												<span style="color:#888;">版本：<% nvram_get_x("","frps_v"); %></span>
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;">使用指定版本</th>
											<td style="border-top: 0 none;">
												<select name="frp_version" class="input">
													<option value="2" <% nvram_match_x("","frp_version", "2","selected"); %>><% nvram_get_x("", "frp_version_2"); %></option>
													<option value="0" <% nvram_match_x("","frp_version", "0","selected"); %>><% nvram_get_x("", "frp_version_0"); %></option>
													<option value="1" <% nvram_match_x("","frp_version", "1","selected"); %>><% nvram_get_x("", "frp_version_1"); %></option>
													<option value="3" <% nvram_match_x("","frp_version", "3","selected"); %>><% nvram_get_x("", "frp_version_3"); %></option>
													<option value="4" <% nvram_match_x("","frp_version", "4","selected"); %>><% nvram_get_x("", "frp_version_4"); %></option>
													<option value="5" <% nvram_match_x("","frp_version", "5","selected"); %>><% nvram_get_x("", "frp_version_5"); %></option>
													<option value="6" <% nvram_match_x("","frp_version", "6","selected"); %>><% nvram_get_x("", "frp_version_6"); %></option>
													<option value="7" <% nvram_match_x("","frp_version", "7","selected"); %>><% nvram_get_x("", "frp_version_7"); %></option>
													<option value="8" <% nvram_match_x("","frp_version", "8","selected"); %>><% nvram_get_x("", "frp_version_8"); %></option>
													<option value="9" <% nvram_match_x("","frp_version", "9","selected"); %>><% nvram_get_x("", "frp_version_9"); %></option>
													<option value="10" <% nvram_match_x("","frp_version", "10","selected"); %>><% nvram_get_x("", "frp_version_10"); %></option>
												</select>
												<div><span style="color:#888;">注意各版本兼容性。</span></div>
											</td>
										</tr>
										<tr id="frp_script" colspan="4">
											<td colspan="4" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script12')"><span>frp_script</span><div>&nbsp;<span style="color:#888;">以下脚本可以修改 frp 启动参数</span></div></a>
												<div id="script12">
													<textarea rows="20" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.frp_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.frp_script.sh",""); %></textarea>
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

