<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - 相框设置</title>
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
	init_itoggle('display_enable');
});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "display_L2"); %>,<% nvram_get_x("", "display_L3"); %>);
	show_footer();
	if (!login_safe())
		textarea_scripts_enabled(0);
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.display_lcd4linux_script.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_display.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}


function done_validating(action){
	refreshpage();
}

function button_redisplay(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' redisplay ',
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_display.asp">
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
							<h2 class="box_head round_top"><#menu5_13#> - 相框设置</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">2.4英寸AX206相框显示。&nbsp;<span style="color:#FF0000;">需要U盘安装opt，需要USB外接相框，USB接口不够可用USB-HUB。 
									<div>相框购买链接:<a href="https://item.taobao.com/item.htm?&id=528645541681" target="blank">》》相框购买链接《《</a></div>
									<div><span style="color:#888;">数码相框的教程和相关整资料请到恩山搜索</span></div>
									<div><span style="color:#888;">手动修改系统时间：SSH 控制台输入：date -s "2016-4-8 11:11:11"</span></div>
									</span></div>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th width="30%" style="border-top: 0 none;">启用 相框显示 功能</th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="display_enable_on_of">
														<input type="checkbox" id="display_enable_fake" <% nvram_match_x("", "display_enable", "1", "value=1 checked"); %><% nvram_match_x("", "display_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="display_enable" id="display_enable_1" class="input" value="1" <% nvram_match_x("", "display_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="display_enable" id="display_enable_0" class="input" value="0" <% nvram_match_x("", "display_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td style="border-top: 0 none;"><input id="redisplay" class="btn btn-success" style="width:110px;" type="button" name="redisplay" value="重启" onclick="button_redisplay()" /></td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 14);">显示天气的城市数字代码：</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="display_weather" name="display_weather" placeholder="2151330" value="<% nvram_get_x("","display_weather"); %>" onKeyPress="return is_string(this,event);" /><div>
												&nbsp;<span style="color:#888;">[2151330]需要进入 <a href="http://woeid.rosselliot.co.nz" target="blank">》城市代码查询网《</a> 输入城市拼音查询.</span></div><div><a href="https://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20weather.forecast%20WHERE%20woeid%3D%22<% nvram_get_x("", "display_weather"); %>%22%20and%20u%3D%22c%22%20%7C%20truncate(count%3D1)&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys" target="blank">》验证城市天气测试《</a></div>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 15);">空气质量指数的城市拼音：</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="display_aqidata" name="display_aqidata" placeholder="beijing" value="<% nvram_get_x("","display_aqidata"); %>" onKeyPress="return is_string(this,event);" /><div>
												&nbsp;<span style="color:#888;">[beijing]需要进入 <a href="http://aqicn.org/city/beijing/cn/" target="blank">》空气质量指数(AQI)网《</a> 查询城市拼音并验证数据.</span></div><div><a href="http://aqicn.org/city/<% nvram_get_x("","display_aqidata"); %>/cn/" target="blank">》验证(AQI)网测试《</a></div>
											</td>
										</tr>
										<tr>
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i><a href="javascript:spoiler_toggle('script10')"><span>lcd4linux.conf(相框显示配置，清空重置配置内容则和重置图像文件)</span></a>
												<div id="script10" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.display_lcd4linux_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.display_lcd4linux_script.sh",""); %></textarea>
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
