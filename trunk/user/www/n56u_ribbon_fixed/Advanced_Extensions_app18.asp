<!DOCTYPE html>
<!--app18_ver=2021-02-21=-->
<html>
<head>
<title><#Web_Title#> - clash</title>
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

	init_itoggle('app_88',change_clash_enable);
	init_itoggle('app_89');
	init_itoggle('app_90');
	init_itoggle('app_92',change_clash_follow_bridge);
	init_itoggle('app_115',change_app_default_config_bridge);
	init_itoggle('ss_udp_enable');

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	show_menu(8,<% nvram_get_x("", "clash_L2"); %>,<% nvram_get_x("", "clash_L3"); %>);
	show_footer();
	change_clash_enable(1);
	change_clash_follow_bridge(1);
	change_app_default_config_bridge(1);
	if (!login_safe())
		textarea_scripts_enabled(0);

}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.app_20.sh'], v);
	inputCtrl(document.form['scripts.app_21.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_app18.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function done_validating(action){
	refreshpage();
}
function change_clash_follow_bridge(mflag){
	var m = document.form.app_92[0].checked;
	showhide_div("ss_udp_enable_tr", m);
	showhide_div("app_114_tr", m);
}
function change_app_default_config_bridge(mflag){
	var m = document.form.app_115[0].checked;
	var v = (m == "0") ? "1" : "0";
	showhide_div("app_101_tr", v);
	showhide_div("app_21_script_tr", v);
}
function change_clash_enable(mflag){
	var m = document.form.app_88.value;
	var is_clash_enable = (m == "1") ? "重启" : "更新";
	document.form.updateclash.value = is_clash_enable;
}
function button_updateclash(){
	change_clash_enable(1);
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' updateapp18 ',
	});
}

function button_clash_wan_port(){
		var port = '9090';
		var porturl =window.location.protocol + '//' + window.location.hostname + ":" + port + "/ui";
		//alert(porturl);
		window.open(porturl,'clash_wan_port');
}

function button_clash_wget_yml(){
	document.form.app_86.value = 'wget_yml';
	applyRule();
}

function button_clash_save_yml(){
	document.form.app_86.value = 'clash_save_yml';
	applyRule();
}

function button_clash_wget_geoip(){
	document.form.app_86.value = 'clash_wget_geoip';
	applyRule();
}
function heredoc(fn) {
	return fn.toString().split('\n').slice(1,-1).join('\n') + '\n'
}
function button_append_app_20_script_code(){
	//var $j = jQuery.noConflict();
	var scripts_code = heredoc(function(){/*
<% nvram_dump("scripts.app_20.sh",""); %>
*/});
	var code = '';
	code += '<td colspan="4" style="border-top: 0 none;" id="app_20_script_code">';
	var codeId = document.getElementById("scripts.app_20.sh");
	if (codeId == '' || codeId == undefined || codeId == null) {
	document.form.button_append_script_code.value = "点击按钮隐藏 clash 主配置文件（当前显示时保存设置时间随配置大小延长）";
	code +='<a><span>若文件太大建议直接修改 /etc/storage/app_20.sh</span></a>';
	code +='<div id="app_20_script">';
	code +='<textarea rows="18" wrap="off" spellcheck="false" maxlength="2097152" class="span12" id="scripts.app_20.sh" name="scripts.app_20.sh" style="font-family:\'Courier New\'; font-size:12px;">' + scripts_code + '</textarea>';
	code +='</div>';
	code +='</td>';
	}else{
	code +='</td>';
	document.form.button_append_script_code.value = "点击按钮显示 clash 主配置文件（当前隐藏时忽略 clash 主配置文件，能迅速保存设置）";
	}
	$j('#app_20_script_code').replaceWith(code);
	if (!login_safe())
		textarea_scripts_enabled(0);
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_app18.asp">
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
	<input type="hidden" name="app_86" value="<% nvram_get_x("", "app_86"); %>">

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
							<h2 class="box_head round_top">clash</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">欢迎使用 clash ，这是一款用Go开发的代理工具，支持ss/v2ray/ssr等协议，支持规则分流（类似于 Surge 的配置）。clash 主页：<a href="https://github.com/Dreamacro/clash" target="blank">https://github.com/Dreamacro/clash</a>
									<div>项目地址：<a href="https://koolclash.js.org" target="blank">https://koolclash.js.org</a> 配置模板：<a href="https://github.com/Dreamacro/clash/wiki/configuration" target="blank">config.yaml</a></div>
									<div>第三方 web 管理页面：<a href="http://clash.razord.top/" target="blank">http://clash.razord.top/</a> 、<a href="http://yacd.haishan.me/" target="blank">http://yacd.haishan.me/</a></div>
									<div>在线规则订阅转换：<a href="https://acl4ssr.netlify.com/" target="blank">https://acl4ssr.netlify.com/</a> 备注：建议修改配置的 secret: 来加密 web 管理页面</div>
									<div>当前 app 文件:【<% nvram_get_x("", "app18_ver"); %>】，最新 app 文件:【<% nvram_get_x("", "app18_ver_n"); %>】 </div>
									<span style="color:#FF0000;" class=""></span></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr id="clash_enable_tr" >
											<th width="35%">clash 开关</th>
											<td>
													<div class="main_itoggle">
													<div id="app_88_on_of">
														<input type="checkbox" id="app_88_fake" <% nvram_match_x("", "app_88", "1", "value=1 checked"); %><% nvram_match_x("", "app_88", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="app_88" id="app_88_1" class="input" value="1" onClick="change_clash_enable(1);" <% nvram_match_x("", "app_88", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="app_88" id="app_88_0" class="input" value="0" onClick="change_clash_enable(1);" <% nvram_match_x("", "app_88", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td colspan="1">
												<input class="btn btn-success" type="button" name="updateclash" value="更新" onclick="button_updateclash()" />
											</td>
											<td colspan="1">
												<span style="color:#888;">版本：<% nvram_get_x("","clash_v"); %></span>
											</td>
										</tr>
										<tr id="clash_http_enable_tr" >
											<th style="border-top: 0 none;">开启 HTTP 代理？(端口：7890)</th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="app_89_on_of">
														<input type="checkbox" id="app_89_fake" <% nvram_match_x("", "app_89", "1", "value=1 checked"); %><% nvram_match_x("", "app_89", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="app_89" id="app_89_1" class="input" value="1" <% nvram_match_x("", "app_89", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="app_89" id="app_89_0" class="input" value="0" <% nvram_match_x("", "app_89", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="clash_socks_enable_tr" >
											<th style="border-top: 0 none;">开启 SOCKS5 代理？(端口：7891)</th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="app_90_on_of">
														<input type="checkbox" id="app_90_fake" <% nvram_match_x("", "app_90", "1", "value=1 checked"); %><% nvram_match_x("", "app_90", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="app_90" id="app_90_1" class="input" value="1" <% nvram_match_x("", "app_90", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="app_90" id="app_90_0" class="input" value="0" <% nvram_match_x("", "app_90", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="clash_follow_tr" >
											<th style="border-top: 0 none;">开启透明代理(TCP)？</th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="app_92_on_of">
														<input type="checkbox" id="app_92_fake" <% nvram_match_x("", "app_92", "1", "value=1 checked"); %><% nvram_match_x("", "app_92", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="app_92" id="app_92_1" class="input" value="1" onClick="change_clash_follow_bridge(1);" <% nvram_match_x("", "app_92", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="app_92" id="app_92_0" class="input" value="0" onClick="change_clash_follow_bridge(1);" <% nvram_match_x("", "app_92", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<input class="btn btn-success" style="" type="button" value="更新geoip" onclick="button_clash_wget_geoip()" tabindex="24">
											</td>
										</tr>
										<tr id="ss_udp_enable_tr" style="display:none;">
											<th style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,9);">游戏模式（UDP转发）</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_udp_enable_on_of">
														<input type="checkbox" id="ss_udp_enable_fake" <% nvram_match_x("", "ss_udp_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ss_udp_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_udp_enable" id="ss_udp_enable_1" class="input" value="1" <% nvram_match_x("", "ss_udp_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_udp_enable" id="ss_udp_enable_0" class="input" value="0" <% nvram_match_x("", "ss_udp_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="app_114_tr" style="display:none;">
											<th style="border-top: 0 none;">路由自身流量透明代理选择</th>
											<td style="border-top: 0 none;">
												<select name="app_114" class="input" style="width: 185px;">
													<option value="0" <% nvram_match_x("","app_114", "0","selected"); %>>代理路由自身流量</option>
													<option value="1" <% nvram_match_x("","app_114", "1","selected"); %>>跳过代理路由自身流量</option>
												</select>
											</td>
										</tr>
										<tr id="app_122_tr">
											<th width="30%" style="border-top: 0 none;">ss_tproxy 分流工作模式</th>
											<td style="border-top: 0 none;">
												<select name="app_122" class="input" style="width: 185px;">
													<option value="0" <% nvram_match_x("","app_122", "0","selected"); %>>clash 内部分流路由规则</option>
													<option value="1" <% nvram_match_x("","app_122", "1","selected"); %>>gfwlist + clash 内部分流</option>
													<option value="2" <% nvram_match_x("","app_122", "2","selected"); %>>大陆白名单 + clash 内部分流</option>
													<option value="3" <% nvram_match_x("","app_122", "3","selected"); %>>回国模式 + clash 内部分流</option>
												</select>
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;">Web管理地址 :</th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input maxlength="512" class="input" size="15" name="app_94" id="app_94" style="width: 175px;" placeholder="0.0.0.0:9090"  value="<% nvram_get_x("","app_94"); %>" onKeyPress="return is_string(this,event);"/>
											</div>
											</td>
											<td style="border-top: 0 none;">
												<input class="btn btn-primary" style="" type="button" value="Web管理界面" onclick="button_clash_wan_port()" tabindex="24">
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;">Web管理密码 :</th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input maxlength="512" class="input" size="15" name="app_119" id="app_119" style="width: 175px;" placeholder="默认空"  value="<% nvram_get_x("","app_119"); %>" onKeyPress="return is_string(this,event);"/>
											</div>
											</td>
											<td style="border-top: 0 none;">
												<input class="btn btn-warning" style="" type="button" value="保存web节点选择" onclick="button_clash_save_yml()" tabindex="24">
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;">clash 订阅链接:<div></div></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input maxlength="512" class="input" size="15" name="app_91" id="app_91" style="width: 175px;" placeholder=" https://www.123.com/clash.txt"  value="<% nvram_get_x("","app_91"); %>" onKeyPress="return is_string(this,event);"/>
											</div>
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<input class="btn btn-success" style="" type="button" value="更新订阅" onclick="button_clash_wget_yml()" tabindex="24">
												<select name="app_120" class="input" style="width: 140px;">
													<option value="0" <% nvram_match_x("","app_120", "0","selected"); %>>停定时更新</option>
													<option value="1" <% nvram_match_x("","app_120", "1","selected"); %>>开定时更新</option>
													<option value="2" <% nvram_match_x("","app_120", "2","selected"); %>>停热重载、停更新</option>
												</select>
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;">日志输出:<div></div></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input maxlength="512" class="input" size="15" name="app_121" id="app_121" style="width: 175px;" placeholder="error"  value="<% nvram_get_x("","app_121"); %>" onKeyPress="return is_string(this,event);"/>
											</div>
											</td>
											<td colspan="2" style="border-top: 0 none;">
												<span style="color:#888;"> 默认[error]，可选[silent] [info] [warning] [debug]</a></span>
											</td>
										</tr>
										<tr id="app_101_tr" style="display:none;">
											<th style="border-top: 0 none;">关键词匹配服务器[域名]转换[IP]:<div></div></th>
											<td style="border-top: 0 none;">
											<div class="input-append">
												<input maxlength="512" class="input" size="15" name="app_101" id="app_101" style="width: 175px;" placeholder="留空则域名全部不转换IP"  value="<% nvram_get_x("","app_101"); %>" onKeyPress="return is_string(this,event);"/>
											</div>
											</td>
											<td  colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">填[*]则域名全部转换IP,对server:值有效,支持<a href="https://www.runoob.com/regexp/regexp-syntax.html" target="blank_regexp">正则表达式</a></span>
											</td>
										</tr>
										<tr id="app_default_config_tr" >
											<th style="border-top: 0 none;">不改写配置直接启动？</th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="app_115_on_of">
														<input type="checkbox" id="app_115_fake" <% nvram_match_x("", "app_115", "1", "value=1 checked"); %><% nvram_match_x("", "app_115", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="app_115" id="app_115_1" class="input" value="1" onClick="change_app_default_config_bridge(1);" <% nvram_match_x("", "app_115", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="app_115" id="app_115_0" class="input" value="0" onClick="change_app_default_config_bridge(1);" <% nvram_match_x("", "app_115", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td  colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">有可能端口不匹配导致功能失效</span>
											</td>
										</tr>
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;" >配置（由于系统保存时限制单行1024字，若单行超长请格式化 yml 配置后再粘贴，或直接用订阅更新配置）</th>
										</tr>
											<td style="border-top: 0 none;" colspan="4">
												<i class="icon-hand-right"></i><input class="btn btn-primary" style="" type="button" name="button_append_script_code"  value="点击按钮显示 clash 主配置文件（当前隐藏时忽略 clash 主配置文件，能迅速保存设置）" onclick="button_append_app_20_script_code()" tabindex="24">
											</td>
										<tr>
											<td colspan="4" style="border-top: 0 none;" id="app_20_script_code">
											</td>
										</tr>
										<tr id="app_21_script_tr" style="display:none;">
											<td colspan="4" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('app_21_script')"><span>点这里自定义 clash dns 配置</span></a>
												<div id="app_21_script">
													<textarea rows="9" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.app_21.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.app_21.sh",""); %></textarea>
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

