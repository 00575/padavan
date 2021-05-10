<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - 网页终端模拟器</title>
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

	//init_itoggle('shellinabox_enable');

});

</script>
<script>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "shellinabox_L2"); %>,<% nvram_get_x("", "shellinabox_L3"); %>);
	show_footer();
	button_script6();
	shellinabox_enable_bridge();
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_shellinabox.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
		button_script6();
//	}
}

function done_validating(action){
	refreshpage();
}

function button_script6(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' button_script6 ',
	});
}

function button_script5(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' button_script5 ',
	});
}

function button_shellinabox(){
		var port = document.form.shellinabox_port.value;
		if (port == '')
			var port = '4200';
		var porturl =window.location.protocol + '//' + window.location.hostname + ":" + port;
		//alert(porturl);
		window.open(porturl,'shellinabox');
}

function shellinabox_enable_bridge(){
	var m = document.form.shellinabox_enable.value;
	var is_shellinabox_css_tr = (m == "2") ? 0 : 1;
	var is_shellinabox_options_tr = (m != "2") ? 1 : 0;
	var is_shellinabox_options_ttyd_tr = (m != "1") ? 1 : 0;
	showhide_div("shellinabox_css_tr", is_shellinabox_css_tr);
	showhide_div("shellinabox_options_tr", is_shellinabox_options_tr);
	showhide_div("shellinabox_options_ttyd_tr", is_shellinabox_options_ttyd_tr);
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_shellinabox.asp">
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
							<h2 class="box_head round_top">网页终端模拟器</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;"><a href="https://github.com/shellinabox/shellinabox" target="_blank">shellinabox</a>, 一款使用 AJAX 的基于 Web 的终端模拟器。备注：需要安装 opt 环境。<div>它使用 AJAX 技术，通过Web浏览器提供了类似原生的 Shell 的外观和感受。</div>&nbsp;<div></div>
									<div><a href="https://github.com/tsl0922/ttyd" target="_blank">ttyd</a>, 是一个网页版的远程终端。备注：16M固件内置。</div>
									</div>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr>
											<th width="30%">工作程序选择</th>
											<td style="border-top: 0 none;">
												<select name="shellinabox_enable" class="input" onChange="shellinabox_enable_bridge();">
													<option value="0" <% nvram_match_x("","shellinabox_enable", "0","selected"); %>>【关闭】</option>
													<option value="1" <% nvram_match_x("","shellinabox_enable", "1","selected"); %>>【开启】shellinabox (opt安装)</option>
													<option value="2" <% nvram_match_x("","shellinabox_enable", "2","selected"); %>>【开启】ttyd (16M固件内置)</option>
												</select>
											</td>
										</tr>
										<tr style="" id="serverchan_post_tr">
											<th colspan="4" style="background-color: #E3E3E3;" >配置</th>
										</tr>
										<tr>
											<th style="border-top: 0 none;">监听端口:</th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input maxlength="5" class="input" size="15" name="shellinabox_port" id="shellinabox_port" placeholder="4200" value="<% nvram_get_x("","shellinabox_port"); %>" onKeyPress="return is_number(this,event);"/>
												&nbsp;<span style="color:#888;">[4200]</span>
											</div>
											</td>
											<td>
											&nbsp;<input class="btn btn-success" style="" type="button" value="打开网页终端" onclick="button_shellinabox()" />
											</td>
										</tr>
										<tr >
											<th style="border: 0 none;" width="30%">访问控制:</th>
											<td style="border-top: 0 none;">
												<select name="shellinabox_wan" class="input">
													<option value="0" <% nvram_match_x("","shellinabox_wan", "0","selected"); %>>只接受内网访问</option>
													<option value="1" <% nvram_match_x("","shellinabox_wan", "1","selected"); %>>允许远程访问</option>
												  </select>
											</td>
										</tr>
										<tr id="shellinabox_css_tr">
											<th style="border: 0 none;" width="30%">网页模板:</th>
											<td style="border-top: 0 none;">
												<select name="shellinabox_css" class="input">
													<option value="white-on-black" <% nvram_match_x("","shellinabox_css", "white-on-black","selected"); %>>黑底白字</option>
													<option value="black-on-white" <% nvram_match_x("","shellinabox_css", "black-on-white","selected"); %>>白底黑字</option>
												  </select>
											</td>
										</tr>
										<tr id="shellinabox_options_tr">
											<th style="border: 0 none;">自定义选项:</th>
											<td style="border: 0 none;" colspan="3">
												<input type="text" class="input" size="60" maxlength="512" name="shellinabox_options" placeholder="默认为[空]" value="<% nvram_get_x("","shellinabox_options"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">终端输入 [shellinaboxd -h] 查看帮助</span>
											</td>
										</tr>
										<tr id="shellinabox_options_ttyd_tr">
											<th style="border: 0 none;">自定义选项:</th>
											<td style="border: 0 none;" colspan="3">
												<input type="text" class="input" size="60" maxlength="512" name="shellinabox_options_ttyd" placeholder="默认为[login]" value="<% nvram_get_x("","shellinabox_options_ttyd"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">终端输入 [ttyd -h] 查看帮助</span>
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

