<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - 锐捷认证</title>
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
	init_itoggle('mentohust_enable');
});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "mentohust_L2"); %>,<% nvram_get_x("", "mentohust_L3"); %>);
	show_footer();

}

function applyRule(){
	if(validForm()){
		showLoading();

		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_mentohust.asp";
		document.form.next_page.value = "";	   
		document.form.submit();
	}
}

function validForm(){


	return true;
}

function done_validating(action){
	refreshpage();
}

</script>
<style>
	.table th, .table td{vertical-align: middle;}
	.table input, .table select {margin-bottom: 0px;}
</style>
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
	<input type="hidden" name="current_page" value="Advanced_Extensions_mentohust.asp">
	<input type="hidden" name="next_page" value="">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="LANHostConfig;">
	<input type="hidden" name="group_id" value="">
	<input type="hidden" name="action_mode" value="">
	<input type="hidden" name="action_script" value="">


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
							<h2 class="box_head round_top">锐捷认证</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
								  <div class="alert alert-info" style="margin: 10px;">MentoHUST 是一个支持锐捷认证的程序（附带支持赛尔认证）。MentoHUST 参数丰富，以最大程度适应不同学校的不同锐捷认证环境。本程序使用配置文件（/etc/storage/mentohust.conf）保存参数。</div>
									<table width="100%" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="2" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr>
											<th width="30%">启用 MentoHUST</th>
											<td style="border: 0 none;">
												<div class="main_itoggle">
													<div id="mentohust_enable_on_of">
														<input type="checkbox" id="mentohust_enable_fake" <% nvram_match_x("", "mentohust_enable", "1", "value=1 checked"); %><% nvram_match_x("", "mentohust_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="mentohust_enable" id="mentohust_enable_1" class="input" value="1" <% nvram_match_x("", "mentohust_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="mentohust_enable" id="mentohust_enable_0" class="input" value="0" <% nvram_match_x("", "mentohust_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;">MentoHUST 程序路径:</th>
											<td style="border: 0 none;"><input name="mentohust_path" placeholder="/usr/bin/mentohust" type="text" class="input" id="mentohust_path" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","mentohust_path"); %>" size="32" maxlength="128" />
											<br /><span style="color:#888;">默认/usr/bin/mentohust,可自定义</span></td>
										</tr>
										<tr>
											<th colspan="2" style="background-color: #E3E3E3;">基本信息</th>
										</tr>
										<tr>
											<th style="border: 0 none;">用户名:</th>
											<td style="border: 0 none;"><input name="mentohust_u" type="text" class="input" id="mentohust_u" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","mentohust_u"); %>" size="32" maxlength="128" /></td>
										</tr>
										<tr>
											<th style="border: 0 none;">密码:</th>
											<td style="border: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="mentohust_p" id="mentohust_p" style="width: 175px;" value="<% nvram_get_x("","mentohust_p"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('mentohust_p')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;">网卡名:</th>
											<td style="border: 0 none;"><input name="mentohust_n" placeholder="<% nvram_get_x("","wan0_ifname_t"); %>" type="text" class="input" id="mentohust_n" onKeyPress="return is_string(this,event);" value="<% nvram_get_x("","mentohust_n"); %>" size="12" maxlength="12"/>
											<br /><span style="color:#888;">留空则自动选 WAN 网卡</span></td>
										</tr>
										<tr>
											<th style="border: 0 none;">IP:</th>
											<td style="border: 0 none;"><input name="mentohust_i" placeholder="0.0.0.0" type="text" class="input" id="mentohust_i" onkeypress="return is_ipaddr(this,event);" value="<% nvram_get_x("","mentohust_i"); %>" size="32" maxlength="15"/>
											<br /><span style="color:#888;">默认本机 IP</span></td>
										</tr>
										<tr>
											<th style="border: 0 none;">子网掩码:</th>
											<td style="border: 0 none;">
											<input name="mentohust_m" type="text" class="input" id="mentohust_m" placeholder="<% nvram_get_x("","lan_netmask"); %>" onkeypress="return is_ipaddr(this,event);" value="<% nvram_get_x("","mentohust_m"); %>" size="32" maxlength="15"/>
											<br /><span style="color:#888;">默认本机掩码</span>
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;">网关:</th>
											<td style="border: 0 none;"><input name="mentohust_g" placeholder="0.0.0.0" type="text" class="input" id="mentohust_g" onkeypress="return is_ipaddr(this,event);" value="<% nvram_get_x("","mentohust_g"); %>" size="32" maxlength="15"/>
											<br /><span style="color:#888;">默认0.0.0.0</span></td>
										</tr>
										 <tr>
											<th style="border: 0 none;">DNS:</th>
											<td style="border: 0 none;"><input name="mentohust_s" placeholder="0.0.0.0" type="text" class="input" id="mentohust_s" onkeypress="return is_ipaddr(this,event);" value="<% nvram_get_x("","mentohust_s"); %>" size="32" maxlength="15"/>
											<br /><span style="color:#888;">默认0.0.0.0</span></td>
										</tr>
										 <tr>
											<th colspan="2" style="background-color: #E3E3E3;">高级设置</th>
										</tr>
										<tr>
											<th style="border: 0 none;">Ping 主机:</th>
											<td style="border: 0 none;"><input name="mentohust_o" placeholder="0.0.0.0" type="text" class="input" id="mentohust_o" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","mentohust_o"); %>" size="32" maxlength="128"/>
											<br /><span style="color:#888;">默认0.0.0.0,表示关闭该功能</span></td>
										</tr>
										<tr>
											<th style="border: 0 none;">认证超时(秒):</th>
											<td style="border: 0 none;"><input name="mentohust_t" placeholder="8" type="text" class="input" id="mentohust_t" onkeypress="return is_number(this,event);" value="<% nvram_get_x("","mentohust_t"); %>" size="32" maxlength="128"/>
											<br /><span style="color:#888;">默认8</span></td>
										</tr>
																				<tr>
											<th style="border: 0 none;">心跳间隔(秒):</th>
											<td style="border: 0 none;"><input name="mentohust_e" placeholder="30" type="text" class="input" id="mentohust_e" onkeypress="return is_number(this,event);" value="<% nvram_get_x("","mentohust_e"); %>" size="32" maxlength="128"/>
											<br /><span style="color:#888;">默认30</span></td>
										</tr>
																				<tr>
											<th style="border: 0 none;">失败等待(秒):</th>
											<td style="border: 0 none;"><input name="mentohust_r" placeholder="15" type="text" class="input" id="mentohust_r" onkeypress="return is_number(this,event);" value="<% nvram_get_x("","mentohust_r"); %>" size="32" maxlength="128"/>
											<br /><span style="color:#888;">默认15</span></td>
										</tr>
																				<tr>
											<th style="border: 0 none;">允许失败次数:</th>
											<td style="border: 0 none;"><input name="mentohust_l" placeholder="8" type="text" class="input" id="mentohust_l" onkeypress="return is_number(this,event);" value="<% nvram_get_x("","mentohust_l"); %>" size="32" maxlength="128"/>
											<br /><span style="color:#888;">0表示无限制,默认值8</span></td>
										</tr>
										
										<tr>
										  <th style="border: 0 none;">组播地址:</th>
										   <td style="border: 0 none;"><select name="mentohust_a" class="input" id="mentohust_a" onchange="return change_common(this, '', 'mentohust_a')">
											<option value='0' <% nvram_match_x("","mentohust_a", "0","selected"); %> >0(标准)</option>
											<option value='1' <% nvram_match_x("","mentohust_a", "1","selected"); %> >1(锐捷)</option>
											<option value='2' <% nvram_match_x("","mentohust_a", "2","selected"); %> >2(赛尔)</option>
										  </select>
										  <br /><span style="color:#888;">默认0</span></td>
										</tr>
										 <tr>
										  <th style="border: 0 none;">DHCP 方式:</th>
										   <td style="border: 0 none;"><select name="mentohust_d" class="input" id="mentohust_d" onchange="return change_common(this, '', 'mentohust_d')">
											<option value='0' <% nvram_match_x("","mentohust_d", "0","selected"); %> >0(不使用)</option>
											<option value='1' <% nvram_match_x("","mentohust_d", "1","selected"); %> >1(二次认证)</option>
											<option value='2' <% nvram_match_x("","mentohust_d", "2","selected"); %> >2(认证后)</option>
											<option value='3' <% nvram_match_x("","mentohust_d", "3","selected"); %> >3(认证前)</option>
										  </select>
										  <br /><span style="color:#888;">默认0</span></td>
										</tr>
																				 <tr>
										  <th style="border: 0 none;">是否后台运行:</th>
										   <td style="border: 0 none;"><select name="mentohust_b" class="input" id="mentohust_b" onchange="return change_common(this, '', 'mentohust_b')">
											<option value='0' <% nvram_match_x("","mentohust_b", "0","selected"); %> >0(否)</option>
											<option value='1' <% nvram_match_x("","mentohust_b", "1","selected"); %> >1(是,关闭输出)</option>
											<option value='2' <% nvram_match_x("","mentohust_b", "2","selected"); %> >2(是,保留输出)</option>
											<option value='3' <% nvram_match_x("","mentohust_b", "3","selected"); %> >3(是,输出到文件)</option>
										  </select>
										  <br /><span style="color:#888;">默认0</span></td>
										</tr>
									   <tr>
											<th style="border: 0 none;">客户端版本号:</th>
											<td style="border: 0 none;"><input name="mentohust_v" placeholder="0.00" type="text" class="input" id="mentohust_v" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","mentohust_v"); %>" size="32" maxlength="128"/>
											<br /><span style="color:#888;">默认0.00,表示兼容 xrgsu</span></td>
										</tr>
										<tr>
											<th style="border: 0 none;">自定义数据文件路径:</th>
											<td style="border: 0 none;"><input name="mentohust_f" type="text" class="input" id="mentohust_f" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","mentohust_f"); %>" size="32" maxlength="128"/>
											<br /><span style="color:#888;">默认不使用</span></td>
										</tr>
											<tr>
											<th style="border: 0 none;">DHCP 脚本:</th>
											<td style="border: 0 none;"><input name="mentohust_c" placeholder="dhclinet" type="text" class="input" id="mentohust_c" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","mentohust_c"); %>" size="32" maxlength="128"/>
											<br /><span style="color:#888;">默认 dhclinet</span></td>
										</tr>
								  </table>
									<table class="table">
										<tr>
											<td style="border: 0 none;">
												<center><input class="btn btn-primary" style="width: 219px" onclick="applyRule();" type="button" value="<#CTL_apply#>" /></center>
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
