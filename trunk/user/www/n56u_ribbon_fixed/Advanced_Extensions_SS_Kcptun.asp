<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - ShadowSocks Kcptun</title>
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

	init_itoggle('kcptun_enable');

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "kcptun_L2"); %>,<% nvram_get_x("", "kcptun_L3"); %>);
	change_kcptun_enable();
	show_footer();
	if (!login_safe())
		textarea_scripts_enabled(0);

}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.kcptun_script.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_SS_Kcptun.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function done_validating(action){
	refreshpage();
}

function change_kcptun_enable(){
	var m = document.form.kcptun_enable.value;
	var is_kcptun_enable = (m == "1") ? "重启" : "更新";
	document.form.updatekcptun.value = is_kcptun_enable;
}
function button_updatekcptun(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' updatekcptun ',
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_SS_Kcptun.asp">
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
							<h2 class="box_head round_top">Kcptun</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">Kcptun 是一个简单和快速的，基于 KCP 协议的 UDP 隧道，它可以将 TCP 流转换为 KCP+UDP 流。 <div>建议开启IPv4 硬件加速:Offload TCP/UDP for LAN/WLAN  </div><div><a href="https://github.com/xtaci/kcptun/" target="blank">教程、项目地址: https://github.com/xtaci/kcptun/</a> </div> <div><a href="https://blog.kuoruan.com/110.html" target="blank">Kcptun Server一键安装脚本:https://blog.kuoruan.com/110.html</a> </div></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr>
											<th width="30%">Kcptun 开关</th>
											<td>
													<div class="main_itoggle">
													<div id="kcptun_enable_on_of">
														<input type="checkbox" id="kcptun_enable_fake" <% nvram_match_x("", "kcptun_enable", "1", "value=1 checked"); %><% nvram_match_x("", "kcptun_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="kcptun_enable" id="kcptun_enable_1" class="input" value="1" <% nvram_match_x("", "kcptun_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="kcptun_enable" id="kcptun_enable_0" class="input" value="0" <% nvram_match_x("", "kcptun_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td colspan="1" style="border-top: 0 none;">
												<input class="btn btn-success" style="width:60px" type="button" name="updatekcptun" value="重启、更新程序" onclick="button_updatekcptun()" />
											</td>
											<td colspan="1" style="border-top: 0 none;">
												<span style="color:#888;">版本：<% nvram_get_x("","kcptun_v"); %></span>
											</td>
										</tr>
										<tr style="" id="kcptun_setting_tr">
											<th colspan="4" style="background-color: #E3E3E3;" >Kcptun 信息</th>
										</tr>
										<tr id="kcptun_path_tr" >
											<th style="border: 0 none;">主程序路径:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="512"  class="input" size="60" name="kcptun_path" placeholder="/opt/bin/client_linux_mipsle" value="<% nvram_get_x("","kcptun_path"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="kcptun_server_tr" >
											<th style="border: 0 none;">服务器地址:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="128"  class="input" size="60" name="kcptun_server" value="<% nvram_get_x("","kcptun_server"); %>" onKeyPress="return is_string(this,event);" />
												
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[IP]或[域名]</span>
											</td>
										</tr>
										<tr id="kcptun_sport_tr" >
											<th style="border: 0 none;">服务器端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5"  class="input" size="60" name="kcptun_sport" placeholder="29900" value="<% nvram_get_x("","kcptun_sport"); %>" onKeyPress="return is_number(this,event);" />
												
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: 29900]</span>
											</td>
										</tr>
										<tr id="kcptun_key_tr" >
											<th style="border: 0 none;">服务器密码:</th>
											<td style="border: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="kcptun_key" id="kcptun_key" style="width: 175px;" value="<% nvram_get_x("","kcptun_key"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('kcptun_key')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="kcptun_crypt_tr">
											<th style="border: 0 none;" width="30%">加密方式:</th>
											<td style="border-top: 0 none;">
												<select name="kcptun_crypt" class="input">
													<option value="none" <% nvram_match_x("","kcptun_crypt", "none","selected"); %>>none</option>
													<option value="xor" <% nvram_match_x("","kcptun_crypt", "xor","selected"); %>>xor</option>
													<option value="xtea" <% nvram_match_x("","kcptun_crypt", "xtea","selected"); %>>xtea</option>
													<option value="tea" <% nvram_match_x("","kcptun_crypt", "tea","selected"); %>>tea</option>
													<option value="3des" <% nvram_match_x("","kcptun_crypt", "3des","selected"); %>>3des</option>
													<option value="cast5" <% nvram_match_x("","kcptun_crypt", "cast5","selected"); %>>cast5</option>
													<option value="twofish" <% nvram_match_x("","kcptun_crypt", "twofish","selected"); %>>twofish</option>
													<option value="blowfish" <% nvram_match_x("","kcptun_crypt", "blowfish","selected"); %>>blowfish</option>
													<option value="salsa20" <% nvram_match_x("","kcptun_crypt", "salsa20","selected"); %>>salsa20</option>
													<option value="aes-192" <% nvram_match_x("","kcptun_crypt", "aes-192","selected"); %>>aes-192</option>
													<option value="aes-128" <% nvram_match_x("","kcptun_crypt", "aes-128","selected"); %>>aes-128</option>
													<option value="aes" <% nvram_match_x("","kcptun_crypt", "aes","selected"); %>>aes</option>
												</select>
												
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: none]</span>
											</td>
										</tr>
										<tr id="kcptun_lport_tr" >
											<th style="border: 0 none;">监听端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5"  class="input" size="60" name="kcptun_lport" placeholder="8388" value="<% nvram_get_x("","kcptun_lport"); %>" onKeyPress="return is_number(this,event);" />
												
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: 8388]</span>
											</td>
										</tr>
										<tr style="" id="kcptun_setting_tr">
											<th colspan="4" style="background-color: #E3E3E3;" >高级设置</th>
										</tr>
										<tr id="kcptun_sndwnd_tr" >
											<th style="border: 0 none;">sndwnd:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="128"  class="input" size="60" name="kcptun_sndwnd" placeholder="1024" value="<% nvram_get_x("","kcptun_sndwnd"); %>" onKeyPress="return is_number(this,event);" />
											
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: 1024]</span>
											</td>
										</tr>
										<tr id="kcptun_rcvwnd_tr" >
											<th style="border: 0 none;">rcvwnd:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="128"  class="input" size="60" name="kcptun_rcvwnd" placeholder="1024" value="<% nvram_get_x("","kcptun_rcvwnd"); %>" onKeyPress="return is_number(this,event);" />
											
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: 1024]</span>
											</td>
										</tr>
										<tr id="kcptun_mode_tr">
											<th style="border: 0 none;" width="30%">mode:</th>
											<td style="border-top: 0 none;">
												<select name="kcptun_mode" class="input">
													<option value="fast" <% nvram_match_x("","kcptun_mode", "fast","selected"); %>>fast</option>
													<option value="fast2" <% nvram_match_x("","kcptun_mode", "fast2","selected"); %>>fast2</option>
													<option value="fast3" <% nvram_match_x("","kcptun_mode", "fast3","selected"); %>>fast3</option>
													<option value="normal" <% nvram_match_x("","kcptun_mode", "normal","selected"); %>>normal</option>
												</select>
												
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: fast]</span>
											</td>
										</tr>
										<tr id="kcptun_mtu_tr" >
											<th style="border: 0 none;">mtu:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="128"  class="input" size="60" name="kcptun_mtu" placeholder="1350" value="<% nvram_get_x("","kcptun_mtu"); %>" onKeyPress="return is_number(this,event);" />
											
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: 1350]</span>
											</td>
										</tr>
										<tr id="kcptun_dscp_tr" >
											<th style="border: 0 none;">dscp:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="128"  class="input" size="60" name="kcptun_dscp" placeholder="0" value="<% nvram_get_x("","kcptun_dscp"); %>" onKeyPress="return is_number(this,event);" />
											
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: 0]</span>
											</td>
										</tr>

										<tr id="kcptun_datashard_tr" >
											<th style="border: 0 none;">datashard:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="128"  class="input" size="60" name="kcptun_datashard" placeholder="10" value="<% nvram_get_x("","kcptun_datashard"); %>" onKeyPress="return is_number(this,event);" />
											
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: 10]</span>
											</td>
										</tr>
										<tr id="kcptun_parityshard_tr" >
											<th style="border: 0 none;">parityshard:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="128"  class="input" size="60" name="kcptun_parityshard" placeholder="3" value="<% nvram_get_x("","kcptun_parityshard"); %>" onKeyPress="return is_number(this,event);" />
											
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: 3]</span>
											</td>
										</tr>
										<tr id="kcptun_autoexpire_tr" >
											<th style="border: 0 none;">autoexpire:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="128"  class="input" size="60" name="kcptun_autoexpire" placeholder="0" value="<% nvram_get_x("","kcptun_autoexpire"); %>" onKeyPress="return is_number(this,event);" />
											
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">[defult: 0]</span>
											</td>
										</tr>
										<tr id="kcptun_user_tr" >
											<th style="border: 0 none;">高级启动参数：默认启用 -nocomp 参数,需在服务端使用此参数来禁止压缩传输</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="512"  class="input" size="60" name="kcptun_user" placeholder="默认[空]" value="<% nvram_get_x("","kcptun_user"); %>" onKeyPress="return is_string(this,event);" />
											
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">若多核CPU启用4线程[--conn 4]</span>
											</td>
										</tr>
										<tr id="kcptun_script" colspan="4">
											<td colspan="4" style="border-top: 0 none;">
												<i class="icon-hand-right"></i><a href="javascript:spoiler_toggle('script12')"><span>Kcptun_script</span><div>&nbsp;<span style="color:#888;">查看以下脚本教程部署服务器和获取 Kcptun 服务端启用参数。</span></div></a>
												<div id="script12" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.kcptun_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.kcptun_script.sh",""); %></textarea>
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
