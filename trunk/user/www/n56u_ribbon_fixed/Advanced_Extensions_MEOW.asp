<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - meow proxy</title>
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

	init_itoggle('meow_enable');

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "meow_L2"); %>,<% nvram_get_x("", "meow_L3"); %>);
	show_footer();
	//change_meow_enable();
	if (!login_safe())
		textarea_scripts_enabled(0);

}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.meow_script.sh'], v);
	inputCtrl(document.form['scripts.meow_config_script.sh'], v);
	inputCtrl(document.form['scripts.meow_direct_script.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_MEOW.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_MEOW.asp">
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
							<h2 class="box_head round_top">MEOW proxy</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/\
									<div>&nbsp;&nbsp;&nbsp;)&nbsp;&nbsp;&nbsp;(&nbsp;&nbsp;')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MEOW 是 [COW](https://github.com/cyfdecyf/cow) 的一个派生版本</div>
									<div>&nbsp;&nbsp;(&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MEOW 与 COW 最大的不同之处在于，COW 采用黑名单模式， 而 MEOW 采用白名单模式</div>
									<div>&nbsp;&nbsp;&nbsp;\(___)|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;国内网站直接连接，其他的网站使用代理连接</div>
									<div>提供 “高可用”、“负载均衡” 的方案!!!(不支持UDP转发)</div><div>可以配合 Proxifier、chrome(switchysharp、SwitchyOmega) 代理插件使用</div><div>启用 ss-local 时自动生成二级代理配置</div><div><a href="https://github.com/renzhn/MEOW/" target="blank">项目地址: https://github.com/renzhn/MEOW/</a> </div> <div><a href="https://github.com/renzhn/MEOW/blob/master/doc/sample-config/rc-full" target="blank">配置文件各项说明:https://github.com/renzhn/MEOW/blob/master/doc/sample-config/rc-full</a> </div><span style="color:#FF0000;" class=""></span></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="2" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr>
											<th width="30%">MEOW proxy 开关</th>
											<td>
													<div class="main_itoggle">
													<div id="meow_enable_on_of">
														<input type="checkbox" id="meow_enable_fake" <% nvram_match_x("", "meow_enable", "1", "value=1 checked"); %><% nvram_match_x("", "meow_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="meow_enable" id="meow_enable_1" class="input" value="1" <% nvram_match_x("", "meow_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="meow_enable" id="meow_enable_0" class="input" value="0" <% nvram_match_x("", "meow_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="meow_path_tr" >
											<th style="border: 0 none;">主程序路径:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="512"  class="input" size="60" name="meow_path" placeholder="/opt/bin/meow" value="<% nvram_get_x("","meow_path"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr>
											<th colspan="2" style="background-color: #E3E3E3;" >启动前运行的脚本</th>
										</tr>
										<tr id="meow_script" colspan="3">
											<td colspan="2" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script12')"><span>meow_script</span><div>&nbsp;<span style="color:#888;">查看以下文件修改 MEOW 启动前运行的脚本。</span></div></a>
												<div id="script12" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.meow_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.meow_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th colspan="2" style="background-color: #E3E3E3;" >MEOW 配置文件</th>
										</tr>
										<tr id="meow_config_script" colspan="3">
											<td colspan="2" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script13')"><span>meow_config_script</span><div>&nbsp;<span style="color:#888;">查看以下文件修改 MEOW 配置参数。</span></div></a>
												<div id="script13" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.meow_config_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.meow_config_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th colspan="2" style="background-color: #E3E3E3;" >MEOW 直连列表</th>
										</tr>
										<tr id="meow_direct_script" colspan="3">
											<td colspan="2" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script14')"><span>meow_direct_script</span><div>&nbsp;<span style="color:#888;">查看以下文件修改 MEOW 配置参数。</span></div></a>
												<div id="script14" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.meow_direct_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.meow_direct_script.sh",""); %></textarea>
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

