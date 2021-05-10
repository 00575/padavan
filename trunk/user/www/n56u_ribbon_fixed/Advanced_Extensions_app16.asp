<!DOCTYPE html>
<!--app16_ver=2019-6-26=-->
<html>
<head>
<title><#Web_Title#> - ddnsto</title>
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

	init_itoggle('app_64',change_ddnsto_enable);

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	show_menu(8,<% nvram_get_x("", "ddnsto_L2"); %>,<% nvram_get_x("", "ddnsto_L3"); %>);
	show_footer();
	change_ddnsto_enable(1);

}


function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_app16.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function done_validating(action){
	refreshpage();
}
function change_ddnsto_enable(mflag){
	var m = document.form.app_64.value;
	var is_ddnsto_enable = (m == "1") ? "重启" : "更新";
	document.form.updateddnsto.value = is_ddnsto_enable;
}
function button_updateddnsto(){
	change_ddnsto_enable(1);
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' updateapp16 ',
	});
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_app16.asp">
	<input type="hidden" name="next_page" value="">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="APP;LANHostConfig;General;">
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
							<h2 class="box_head round_top">ddnsto</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">欢迎使用 ddnsto ，这是一款由 koolshare 小宝开发的，支持 http2 的远程控制工具。仅支持远程管理路由器 nas 、windows 远程桌面！
									<div>【注意】：请保护好你的 ddnsto、EasyExplorer 的 Token，如果被其他人获知，那么下一个摄影大师可能就是你！！！</div>
									<div>ddnsto 仅提供维护路由器使用，请勿用于反动、不健康等用途！！！</div>
									<div>首次使用需要您登录控管理控制台获取 Token 并设置。 管理控制台 <a href="https://www.ddnsto.com/" target="blank">https://www.ddnsto.com/</a></div>
									<div>教程地址: <a href="http://koolshare.cn/thread-116500-1-1.html" target="blank">http://koolshare.cn/thread-116500-1-1.html</a></div>
									<div>路由器ID：【<% nvram_get_x("", "ddnsto_route_id"); %>】 ddnsto 版本：【<% nvram_get_x("", "ddnsto_version"); %>】</div>
									<div>当前 app 文件:【<% nvram_get_x("", "app16_ver"); %>】，最新 app 文件:【<% nvram_get_x("", "app16_ver_n"); %>】 </div></div>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr id="ddnsto_enable_tr" >
											<th width="30%">ddnsto 开关</th>
											<td>
													<div class="main_itoggle">
													<div id="app_64_on_of">
														<input type="checkbox" id="app_64_fake" <% nvram_match_x("", "app_64", "1", "value=1 checked"); %><% nvram_match_x("", "app_64", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="app_64" id="app_64_1" class="input" value="1" onClick="change_ddnsto_enable(1);" <% nvram_match_x("", "app_64", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="app_64" id="app_64_0" class="input" value="0" onClick="change_ddnsto_enable(1);" <% nvram_match_x("", "app_64", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td colspan="1">
												<input class="btn btn-success" style="width:60px" type="button" name="updateddnsto" value="更新" onclick="button_updateddnsto()" />
											</td>
											<td colspan="1">
												<span style="color:#888;">版本：<% nvram_get_x("","ddnsto_version"); %></span>
											</td>
										</tr>
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;" >配置 ddnsto</th>
										</tr>
										<tr>
											<th style="border-top: 0 none;">ddnsto Token:</th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="app_65" id="app_65" style="width: 175px;" value="<% nvram_get_x("","app_65"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('app_65')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
											<td style="border-top: 0 none;">
												<span style="color:#888;"><a href="https://www.ddnsto.com/" target="_blank">获取token</a></span>
											</td>
											<td colspan="1">
												<span style="color:#888;">路由器ID：<% nvram_get_x("","ddnsto_route_id"); %></span>
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

