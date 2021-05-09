<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - qcloud 域名解析</title>
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

	init_itoggle('qcloud_enable',change_qcloud_enable_bridge);

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "qcloud_L2"); %>,<% nvram_get_x("", "qcloud_L3"); %>);
	show_footer();

	change_qcloud_enable_bridge(1);
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
		document.form.current_page.value = "/Advanced_Extensions_qcloud.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}


function done_validating(action){
	refreshpage();
}

function change_qcloud_enable_bridge(mflag){
	var m = document.form.qcloud_enable[0].checked;
	showhide_div("qcloud_ak_tr", m);
	showhide_div("qcloud_sk_tr", m);
	showhide_div("qcloud_interval_tr", m);
	showhide_div("qcloud_ttl_tr", m);
	showhide_div("qcloud_domain_tr", m);
	showhide_div("qcloud_domain2_tr", m);
	showhide_div("qcloud_domain6_tr", m);
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_qcloud.asp">
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
							<h2 class="box_head round_top">qcloud 域名解析</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">使用 腾讯云(qcloud) 云解析 API 实现顶级个人域名的 ddns 服务。 <a href="https://cloud.tencent.com/" target="blank"><i><u>腾讯云 qcloud 主页</u></i></a>
												<ul style="padding-top:5px;margin-top:10px;float: left;">
												<li><a href="https://cloud.tencent.com/document/api/302/4032" target="blank"><i><u>qcloud 项目地址：https://cloud.tencent.com/document/api/302/4032</u></i></a></li>
												<li>需要 curl 程序，opt 环境内置或手动安装 opt 后输入[opkg update; opkg install curl]</li>
												<li>使用前需要将域名添加到 腾讯云 中，并添加一条A记录，使用之后将自动更新ip</li>
												<li>点 <a href="https://console.cloud.tencent.com/domain" target="blank"><i><u>这里</u></i></a> 查看腾讯云 qcloud 云解析管理页面。</li>
												<li>点 <a href="https://console.cloud.tencent.com/cam/capi" target="blank"><i><u>这里</u></i></a> 查看如何获取腾讯云 qcloud 的 SecretId 和 SecretKey。</li>
												</ul>
									</div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr >
											<th width="30%" style="border-top: 0 none;">上次运行:</th>
											<td  colspan="3"style="border-top: 0 none;">
											   <div >【<% nvram_get_x("","qcloud_last_act"); %>】</div>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 qcloud 域名解析</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="qcloud_enable_on_of">
														<input type="checkbox" id="qcloud_enable_fake" <% nvram_match_x("", "qcloud_enable", "1", "value=1 checked"); %><% nvram_match_x("", "qcloud_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="qcloud_enable" id="qcloud_enable_1" class="input" value="1" onClick="change_qcloud_enable_bridge(1);" <% nvram_match_x("", "qcloud_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="qcloud_enable" id="qcloud_enable_0" class="input" value="0" onClick="change_qcloud_enable_bridge(1);" <% nvram_match_x("", "qcloud_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="qcloud_interval_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">检查周期(秒) :</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="qcloud_interval" name="qcloud_interval" placeholder="600" value="<% nvram_get_x("","qcloud_interval"); %>"  onkeypress="return is_number(this,event);" />
											</td>
										</tr>
										<tr id="qcloud_ttl_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">解析TTL(秒) :</a></th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="qcloud_ttl" name="qcloud_ttl" placeholder="600" value="<% nvram_get_x("","qcloud_ttl"); %>"  onkeypress="return is_number(this,event);" />
												<div>&nbsp;<span style="color:#888;">[1-86400]默认10分钟，免费版的范围是600-86400</span></div>
											</td>
										</tr>
										<tr id="qcloud_ak_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">Access Key ID :</a></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="qcloud_ak" id="qcloud_ak" style="width: 175px;" value="<% nvram_get_x("","qcloud_ak"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('qcloud_ak')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="qcloud_sk_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">Access Key Secret :</a></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="qcloud_sk" id="qcloud_sk" style="width: 175px;" value="<% nvram_get_x("","qcloud_sk"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('qcloud_sk')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="qcloud_domain_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名1</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="qcloud_name" name="qcloud_name" placeholder="www" value="<% nvram_get_x("","qcloud_name"); %>" onKeyPress="return is_string(this,event);" /> . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="qcloud_domain" name="qcloud_domain" placeholder="google.com" value="<% nvram_get_x("","qcloud_domain"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="qcloud_domain2_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名2</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="qcloud_name2" name="qcloud_name2" placeholder="www" value="<% nvram_get_x("","qcloud_name2"); %>" onKeyPress="return is_string(this,event);" /> . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="qcloud_domain2" name="qcloud_domain2" placeholder="google.com" value="<% nvram_get_x("","qcloud_domain2"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="qcloud_domain6_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">顶级域名3[IPv6]</a></th>
											<td style="border-top: 0 none;">
												<input style="width: 80px;" type="text" maxlength="255" class="input" size="15" id="qcloud_name6" name="qcloud_name6" placeholder="www" value="<% nvram_get_x("","qcloud_name6"); %>" onKeyPress="return is_string(this,event);" /> . <input style="width: 110px;" type="text" maxlength="255" class="input" size="15" id="qcloud_domain6" name="qcloud_domain6" placeholder="google.com" value="<% nvram_get_x("","qcloud_domain6"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="row_post_wan_script" style="display:none;">
											<td colspan="2" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script2')"><span>qcloud 脚本-基于 qcloud 用户 API 实现的纯 Shell 动态域名客户端</span></a>
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

