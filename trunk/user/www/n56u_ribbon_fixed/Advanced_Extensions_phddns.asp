<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - 花生壳内网版</title>
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
	init_itoggle('phddns');
});
</script>
<script>
function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "phddns_L2"); %>,<% nvram_get_x("", "phddns_L3"); %>);
	show_footer();


}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_phddns.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function done_validating(action){
	refreshpage();
}

function button_reszUID(){
	var str = "你确定要执行 重置花生壳绑定 按钮功能吗？";
	if(confirm(str)){
	showLoading();
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' button_reszUID ',
	});
	document.form.submit();
	}
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_phddns.asp">
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
							<h2 class="box_head round_top">花生壳内网版</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">花生壳内网版是无需获取到公网ip，不需要在路由器上进行设置端口转发，直接在新花生壳上进行映射，通过服务器实现外网的访问。 http://b.oray.com</div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 8);">启用 花生壳内网版</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="phddns_on_of">
														<input type="checkbox" id="phddns_fake" <% nvram_match_x("", "phddns", "1", "value=1 checked"); %><% nvram_match_x("", "phddns", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="phddns" id="phddns_1" class="input" value="1" <% nvram_match_x("", "phddns", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="phddns" id="phddns_0" class="input" value="0" <% nvram_match_x("", "phddns", "0", "checked"); %> /><#checkbox_No#>
												</div>
												
											</td>
											
										</tr>
										<tr>
										<th style="border-top: 0 none;">状态：</th>
										<td style="border-top: 0 none;">【<% nvram_get_x("", "phddns_st"); %>】</td>
										</tr>
										<tr>
										<th style="border-top: 0 none;">SN：</th>
										<td style="border-top: 0 none;">【<% nvram_get_x("", "phddns_sn"); %>】</td>
										</tr>
										<tr>
										<th style="border-top: 0 none;">已绑定账号：</th>
										<td style="border-top: 0 none;">【<% nvram_get_x("", "phddns_szUID"); %>】</td>
										</tr>
										<tr>
										<th style="border-top: 0 none;"></th>
										<td style="border-top: 0 none;"><input class="btn btn-success" type="button" value="打开管理页面" onclick="window.open('http://b.oray.com')">
										<input class="btn btn-success" type="button" value="重置账号绑定" onclick="button_reszUID();"></td>
										</tr>
										<tr >
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

