<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - ShadowSocks SS Server</title>
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

	init_itoggle('ssserver_enable');

});

</script>
<script>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "ssserver_L2"); %>,<% nvram_get_x("", "ssserver_L3"); %>);
	show_footer();
	//change_ssserver_enable();
	document.getElementById("ssserver_method").options[0].text = '<% nvram_get_x("", "ssserver_method"); %>';
	document.getElementById("ssserver_method").options[0].value = '<% nvram_get_x("", "ssserver_method"); %>';
	click_change_ss_method2();
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_SS_Server.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function done_validating(action){
	refreshpage();
}

function change_ssserver_enable(){
	var m = document.form.ssserver_enable.value;
	var is_ssserver_enable = (m == "1") ? 1 : 0;
	showhide_div("ssserver_setting_tr", is_ssserver_enable);
	showhide_div("ssserver_method_tr", is_ssserver_enable);
	showhide_div("ssserver_password_tr", is_ssserver_enable);
	showhide_div("ssserver_port_tr", is_ssserver_enable);
	showhide_div("ssserver_time_tr", is_ssserver_enable);
	showhide_div("ssserver_udp_tr", is_ssserver_enable);
	showhide_div("ssserver_ota_tr", is_ssserver_enable);
	showhide_div("ssserver_usage_tr", is_ssserver_enable);
	
}


function clear_tmp_write(){
	var mmm = document.form.ss_change_3_ss_method.value;
	if(mmm == "1"){
		if(document.form.ssserver_method_write.value != ""){
			document.getElementById("ssserver_method").options[0].text = document.form.ssserver_method_write.value;
			document.getElementById("ssserver_method").options[0].value = document.form.ssserver_method_write.value;
		}
		document.getElementById("ssserver_method").options[0].selected = true;
	}
}

function click_change_ss_method(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.ss_change_3_ss_method.value = v;
	click_change_ss_method2();
}
function click_change_ss_method2() {
	var m = document.form.ss_change_3_ss_method.value;
	var m_x = (m == "1") ? 0 : 1;
	showhide_div("ss_method_write1_tr", m_x);
	showhide_div("ss_method_write3_tr", m);
	if(m == "1"){
		if(document.form.ssserver_method_write.value != document.form.ssserver_method.value){
			document.form.ssserver_method_write.value = document.form.ssserver_method.value;
		}
	}
	clear_tmp_write();
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_SS_Server.asp">
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
	<input type="hidden" name="ss_change_3_ss_method" value="<% nvram_get_x("", "ss_change_3_ss_method"); %>" />

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
							<h2 class="box_head round_top">ShadowSocks Server</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">利用路由器搭建 SS 服务端，将你的网络共享到公网，让你的小伙伴远程连接。</div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="2" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr>
											<th width="30%">ss-server 开关</th>
											<td>
													<div class="main_itoggle">
													<div id="ssserver_enable_on_of">
														<input type="checkbox" id="ssserver_enable_fake" <% nvram_match_x("", "ssserver_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ssserver_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ssserver_enable" id="ssserver_enable_1" class="input" value="1" <% nvram_match_x("", "ssserver_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ssserver_enable" id="ssserver_enable_0" class="input" value="0" <% nvram_match_x("", "ssserver_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr style="" id="ssserver_setting_tr">
											<th colspan="2" style="background-color: #E3E3E3;" >ss-server 设置</th>
										</tr>
										<tr id="ssserver_method_tr">
											<th style="border: 0 none;" width="30%">加密方式:&nbsp;&nbsp;&nbsp;&nbsp;<label id="change_ss_method_tr" class="checkbox inline"><input type="checkbox" name="change_ss_method_fake" value="" style="margin-left:10;" onclick="click_change_ss_method(this);" <% nvram_match_x("", "ss_change_3_ss_method", "1", "checked"); %>/>手动填写</label></th>
											<td id="ss_method_write1_tr" style="border-top: 0 none;">
												<select name="ssserver_method" id="ssserver_method" class="input">
													<option value="" <% nvram_match_x("","ssserver_method", "","selected"); %>></option>
													<option value="aes-128-cfb" <% nvram_match_x("","ssserver_method", "aes-128-cfb","selected"); %>>aes-128-cfb</option>
													<option value="aes-128-ctr" <% nvram_match_x("","ssserver_method", "aes-128-ctr","selected"); %>>aes-128-ctr</option>
													<option value="aes-128-gcm" <% nvram_match_x("","ssserver_method", "aes-128-gcm","selected"); %>>aes-128-gcm</option>
													<option value="aes-192-cfb" <% nvram_match_x("","ssserver_method", "aes-192-cfb","selected"); %>>aes-192-cfb</option>
													<option value="aes-192-ctr" <% nvram_match_x("","ssserver_method", "aes-192-ctr","selected"); %>>aes-192-ctr</option>
													<option value="aes-192-gcm" <% nvram_match_x("","ssserver_method", "aes-192-gcm","selected"); %>>aes-192-gcm</option>
													<option value="aes-256-cfb" <% nvram_match_x("","ssserver_method", "aes-256-cfb","selected"); %>>aes-256-cfb</option>
													<option value="aes-256-ctr" <% nvram_match_x("","ssserver_method", "aes-256-ctr","selected"); %>>aes-256-ctr</option>
													<option value="aes-256-gcm" <% nvram_match_x("","ssserver_method", "aes-256-gcm","selected"); %>>aes-256-gcm</option>
													<option value="bf-cfb" <% nvram_match_x("","ssserver_method", "bf-cfb","selected"); %>>bf-cfb</option>
													<option value="camellia-128-cfb" <% nvram_match_x("","ssserver_method", "camellia-128-cfb","selected"); %>>camellia-128-cfb</option>
													<option value="camellia-192-cfb" <% nvram_match_x("","ssserver_method", "camellia-192-cfb","selected"); %>>camellia-192-cfb</option>
													<option value="camellia-256-cfb" <% nvram_match_x("","ssserver_method", "camellia-256-cfb","selected"); %>>camellia-256-cfb</option>
													<option value="chacha20" <% nvram_match_x("","ssserver_method", "chacha20","selected"); %>>chacha20</option>
													<option value="chacha20-ietf" <% nvram_match_x("","ssserver_method", "chacha20-ietf","selected"); %>>chacha20-ietf</option>
													<option value="chacha20-ietf-poly1305" <% nvram_match_x("","ssserver_method", "chacha20-ietf-poly1305","selected"); %>>chacha20-ietf-poly1305</option>
													<option value="xchacha20-ietf-poly1305" <% nvram_match_x("","ssserver_method", "xchacha20-ietf-poly1305","selected"); %>>xchacha20-ietf-poly1305</option>
													<option value="rc4-md5" <% nvram_match_x("","ssserver_method", "rc4-md5","selected"); %>>rc4-md5</option>
													<option value="salsa20" <% nvram_match_x("","ssserver_method", "salsa20","selected"); %>>salsa20</option>
												</select>
											</td>
											<td id="ss_method_write3_tr" style="display:none;">
												<input type="text" maxlength="8192" class="input" size="15" style="width: 210px;" onchange="clear_tmp_write();" name="ssserver_method_write" value="<% nvram_get_x("","ssserver_method_write"); %>" />
											</td>
										</tr>
										<tr id="ssserver_password_tr" >
											<th style="border: 0 none;">密码:</th>
											<td style="border: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="ssserver_password" placeholder="m" id="ssserver_password" style="width: 175px;" value="<% nvram_get_x("","ssserver_password"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('ssserver_password')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="ssserver_port_tr" >
											<th style="border: 0 none;">端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5"  class="input" size="60" name="ssserver_port" placeholder="8388" value="<% nvram_get_x("","ssserver_port"); %>"  onkeypress="return is_number(this,event);" />
												&nbsp;<span style="color:#888;">[100...65535]</span>
											</td>
										</tr>
										<tr id="ssserver_time_tr" >
											<th style="border: 0 none;">超时时间(s):</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="128"  class="input" size="60" name="ssserver_time" placeholder="120" value="<% nvram_get_x("","ssserver_time"); %>"  onkeypress="return is_number(this,event);" />
											&nbsp;<span style="color:#888;">[120]</span>
											</td>
										</tr>
										<tr id="ssserver_udp_tr" >
											<th style="border: 0 none;" width="30%">UDP转发:</th>
											<td style="border-top: 0 none;">
												<select name="ssserver_udp" class="input">
													<option value="0" <% nvram_match_x("","ssserver_udp", "0","selected"); %>>关闭</option>
													<option value="1" <% nvram_match_x("","ssserver_udp", "1","selected"); %>>开启</option>
												  </select>
											</td>
										</tr>
										<tr id="ssserver_ota_tr" style="display:none;">
											<th style="border: 0 none;" width="30%">一次性验证 (OTA):</th>
											<td style="border-top: 0 none;">
												<select name="ssserver_ota" class="input">
													<option value="0" <% nvram_match_x("","ssserver_ota", "0","selected"); %>>关闭</option>
													<option value="1" <% nvram_match_x("","ssserver_ota", "1","selected"); %>>开启</option>
												  </select>
											</td>
										</tr>
										<tr id="ssserver_usage_tr" >
											<th style="border: 0 none;">自定义启动参数:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="128"  class="input" size="60" name="ssserver_usage" value="<% nvram_get_x("","ssserver_usage"); %>" onKeyPress="return is_string(this,event);" />
												&nbsp;<span style="color:#888;">默认[空]</span>
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

