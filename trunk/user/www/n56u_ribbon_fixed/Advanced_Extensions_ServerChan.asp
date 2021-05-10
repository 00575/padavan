<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - 微信推送</title>
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

	init_itoggle('serverchan_enable');

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "serverchan_L2"); %>,<% nvram_get_x("", "serverchan_L3"); %>);
	show_footer();
	button_script6();
	if (!login_safe())
		textarea_scripts_enabled(0);
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.serverchan_script.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_ServerChan.asp";
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_ServerChan.asp">
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
							<h2 class="box_head round_top">微信推送</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;"><a href="http://sc.ftqq.com/" target="_blank">Server 酱</a>, 英文名「ServerChan」, 是一款「程序员」和「服务器」之间的通信软件。<div>说人话？就是从服务器推送报警和日志到手机的工具。</div><div><a href="http://sc.ftqq.com/" target="blank">教程、项目地址: http://sc.ftqq.com/</a></div><div>可到“ 自定义 Crontab 定时任务脚本 ”配置晚间免打扰推送时间</div></div>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr>
											<th width="30%">ServerChan 开关</th>
											<td>
													<div class="main_itoggle">
													<div id="serverchan_enable_on_of">
														<input type="checkbox" id="serverchan_enable_fake" <% nvram_match_x("", "serverchan_enable", "1", "value=1 checked"); %><% nvram_match_x("", "serverchan_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="serverchan_enable" id="serverchan_enable_1" class="input" value="1" <% nvram_match_x("", "serverchan_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="serverchan_enable" id="serverchan_enable_0" class="input" value="0" <% nvram_match_x("", "serverchan_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr style="" id="serverchan_post_tr">
											<th colspan="4" style="background-color: #E3E3E3;" >在线发送</th>
										</tr>
										<tr>
											<th style="border-top: 0 none;">SCKEY:</th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="serverchan_sckey" id="serverchan_sckey" style="width: 175px;" value="<% nvram_get_x("","serverchan_sckey"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('serverchan_sckey')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
											<td>
											&nbsp;<span style="color:#888;"><a href="http://sc.ftqq.com/" target="_blank">绑定并获取SCKEY</a></span>
											</td>
										</tr>
										<tr id="serverchan_text_tr" >
											<th style="border: 0 none;">消息标题:</th>
											<td style="border: 0 none;" colspan="3">
												<input type="text" class="input" size="60" style="width: 453px" maxlength="256" name="serverchan_text" placeholder="必填, 最长 265 字节" value="<% nvram_get_x("","serverchan_text"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;"></span>
											</td>
										</tr>
										<tr id="serverchan_desp_tr" >
											<th style="border: 0 none;">消息内容:</th>
											<td style="border: 0 none;" colspan="3">
											<textarea rows="3" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="serverchan_desp" placeholder="消息内容, 最长 64 K, 选填, 支持 MarkDown" value="<% nvram_get_x("","serverchan_desp"); %>" onKeyPress="return is_string(this,event);"></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="4" style="border-top: 0 none;">
												<center><input class="btn btn-success" style="width: 219px" type="button" value="发送消息" onclick="applyRule()" /></center>
											</td>
										</tr>
										<tr style="" id="serverchan_notify_tr">
											<th colspan="4" style="background-color: #E3E3E3;" >通知提醒</th>
										</tr>
										<tr id="serverchan_notify_1_tr" >
											<th style="border: 0 none;" width="30%">互联网 IP 变动:</th>
											<td style="border-top: 0 none;">
												<select name="serverchan_notify_1" class="input">
													<option value="0" <% nvram_match_x("","serverchan_notify_1", "0","selected"); %>>关闭</option>
													<option value="1" <% nvram_match_x("","serverchan_notify_1", "1","selected"); %>>开启</option>
												  </select>
											</td>
										</tr>
										<tr id="serverchan_notify_2_tr" >
											<th style="border: 0 none;" width="30%">设备接入提醒:</th>
											<td style="border-top: 0 none;">
												<select name="serverchan_notify_2" class="input">
													<option value="0" <% nvram_match_x("","serverchan_notify_2", "0","selected"); %>>关闭</option>
													<option value="1" <% nvram_match_x("","serverchan_notify_2", "1","selected"); %>>开启</option>
												  </select>
											</td>
											<td colspan="1" style="border-top: 0 none;">
												<input class="btn btn-success"  type="button" value="清空以往接入设备名称" onclick="button_script5()" />
											</td>
										</tr>
										<tr id="serverchan_notify_4_tr" >
											<th style="border: 0 none;" width="30%">设备上、下线提醒:</th>
											<td style="border-top: 0 none;">
												<select name="serverchan_notify_4" class="input">
													<option value="0" <% nvram_match_x("","serverchan_notify_4", "0","selected"); %>>关闭</option>
													<option value="1" <% nvram_match_x("","serverchan_notify_4", "1","selected"); %>>开启</option>
												  </select>
											</td>
										</tr>
										<tr id="serverchan_notify_3_tr" >
											<th style="border: 0 none;" width="30%">固件更新提醒:</th>
											<td style="border-top: 0 none;">
												<select name="serverchan_notify_3" class="input">
													<option value="0" <% nvram_match_x("","serverchan_notify_3", "0","selected"); %>>关闭</option>
													<option value="1" <% nvram_match_x("","serverchan_notify_3", "1","selected"); %>>开启</option>
												  </select>
											</td>
										</tr>
										<tr id="serverchan_config">
											<td colspan="4" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script11')"><span>点这里自定义 serverchan_script 脚本</span></a>
												<div id="script11" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.serverchan_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.serverchan_script.sh",""); %></textarea>
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

