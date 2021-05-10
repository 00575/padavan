<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - 配置扩展环境</title>
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
	init_itoggle('upopt_enable');
	init_itoggle('upscript_enable');
	init_itoggle('opt_force_enable',opt_force_enable_bridge);
	init_itoggle('opt_download_enable',opt_download_enable_bridge);
	init_itoggle('size_media_enable');
	init_itoggle('pdcn_uuid_enable');
	init_itoggle('cmd_log_enable');
	init_itoggle('cmd_cpu_enable');
	init_itoggle('cmd_reboot_enable');
	init_itoggle('upan_storage_enable');
	init_itoggle('optinstall');
	init_itoggle('syncthing_enable',change_syncthing_enable_bridge);
	init_itoggle('syncthing_wan');
	init_itoggle('xunleis',change_xunleis_bridge);
	init_itoggle('FastDick_enable',change_FastDick_enable_bridge);
	//init_itoggle('phddns');
	//init_itoggle('dnspod_enable',change_dnspod_enable_bridge);
	init_itoggle('youku_enable',change_youku_enable_bridge);
	//init_itoggle('jbls_enable',change_jbls_enable_bridge);
	init_itoggle('kms_enable',change_kms_enable_bridge);
	//init_itoggle('ngrok_enable',change_ngrok_enable_bridge);
	init_itoggle('tinyproxy_enable',change_tinyproxy_enable_bridge);
	init_itoggle('mproxy_enable',change_mproxy_enable_bridge);
	init_itoggle('tinyproxy_port');
	init_itoggle('mproxy_port');
	init_itoggle('vpnproxy_enable',change_vpnproxy_enable_bridge);
});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "script_L2"); %>,<% nvram_get_x("", "script_L3"); %>);
	show_footer();
	opt_force_enable_bridge(1);
	opt_download_enable_bridge(1);
	change_syncthing_enable_bridge(1);
	change_xunleis_bridge(1);
	change_FastDick_enable_bridge(1);
	//change_dnspod_enable_bridge(1);
	change_youku_enable_bridge(1);
	change_kms_enable_bridge(1);
	//change_jbls_enable_bridge(1);
	//change_ngrok_enable_bridge(1);
	change_tinyproxy_enable_bridge(1);
	change_mproxy_enable_bridge(1);
	change_vpnproxy_enable_bridge(1);
	change_ss_opt_x();
	if (!login_safe())
		textarea_scripts_enabled(0);
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.cifs_script.sh'], v);
	inputCtrl(document.form['scripts.FastDick_script.sh'], v);
	//inputCtrl(document.form['scripts.jbls_script.sh'], v);
	inputCtrl(document.form['scripts.vlmcsdini_script.sh'], v);
	inputCtrl(document.form['scripts.tinyproxy_script.sh'], v);
	inputCtrl(document.form['scripts.mproxy_script.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_script.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}


function done_validating(action){
	refreshpage();
}

function change_ss_opt_x(){
	var m = document.form.ss_opt_x.value;
	var is_ss_opt_x = (m == "5") ? 1 : 0;
	showhide_div("opt_cifs_dir_td", is_ss_opt_x);
	var is_ss_opt_x_2 = (m == "6") ? 1 : 0;
	showhide_div("opt_cifs_block_td", is_ss_opt_x_2);
	showhide_div("opt_cifs_script_td", is_ss_opt_x_2);
}

function opt_force_enable_bridge(mflag){
	var m = document.form.opt_force_enable[0].checked;
	showhide_div("opt_force_tr", m);
}
function opt_download_enable_bridge(mflag){
	var m = document.form.opt_download_enable[0].checked;
	showhide_div("opt_download_tr_1", m);
	showhide_div("opt_download_tr_2", m);
}
function change_syncthing_enable_bridge(mflag){
	var m = document.form.syncthing_enable[0].checked;
	showhide_div("syncthing_desc0", m);
	showhide_div("syncthing_desc1", m);
	showhide_div("syncthing_desc2", m);
	showhide_div("syncthing_desc3", m);
}
function change_xunleis_bridge(mflag){
	var m = document.form.xunleis[0].checked;
	showhide_div("xunleis_dir_tr", m);
	showhide_div("xunleis_get_sn", m);
	showhide_div("xunleis_admin", m);
}
function change_FastDick_enable_bridge(mflag){
	var m = document.form.FastDick_enable[0].checked;
	showhide_div("FastDicks", m);
	showhide_div("FastDick_uid", m);
	showhide_div("FastDick_pwd_tr", m);
	showhide_div("row_post_FastDick_script", m);
}
function change_dnspod_enable_bridge(mflag){
	var m = document.form.dnspod_enable[0].checked;
	showhide_div("dnspod_username", m);
	showhide_div("dnspod_password_tr", m);
	showhide_div("dnspod_domian", m);
	showhide_div("dnspod_host", m);
	showhide_div("row_post_wan_script", m);
}
function change_youku_enable_bridge(mflag){
	//var m = document.form.youku_enable[0].checked;
	var m = 0;
	showhide_div("youku_hc_dir", m);
	showhide_div("youku_hc", m);
	showhide_div("youku_sn", m);
	showhide_div("youku_spd", m);
}
function change_kms_enable_bridge(mflag){
	var m = document.form.kms_enable[0].checked;
	showhide_div("kms_Start_script", m);
}
//function change_jbls_enable_bridge(mflag){
	//var m = document.form.jbls_enable[0].checked;
	//showhide_div("jbls_Start_script", m);
//}
function change_ngrok_enable_bridge(mflag){
	var m = document.form.ngrok_enable[0].checked;
	showhide_div("ngrok_script", m);
}
function change_tinyproxy_enable_bridge(mflag){
	var m = document.form.tinyproxy_enable[0].checked;
	showhide_div("tinyproxy_path", m);
	showhide_div("tinyproxy_script", m);
	showhide_div("tinyproxy_port", m);
}
function change_mproxy_enable_bridge(mflag){
	var m = document.form.mproxy_enable[0].checked;
	showhide_div("mproxy_script", m);
	showhide_div("mproxy_port", m);
}
function change_vpnproxy_enable_bridge(mflag){
	var m = document.form.vpnproxy_enable[0].checked;
	showhide_div("vpnproxy_wan_port", m);
	showhide_div("vpnproxy_vpn_port", m);
}

function button_syncthing_wan_port(){
		var port = document.form.syncthing_wan_port.value;
		if (port == '')
			var port = '8384';
		var porturl =window.location.protocol + '//' + window.location.hostname + ":" + port;
		//alert(porturl);
		window.open(porturl,'syncthing_wan_port');
}

function button_reopt(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' reopt ',
	});
}

function button_upscript(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' upscript ',
	});
}

function button_optbackup(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' optbackup ',
	});
}

function button_opt_download(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' opt_download ',
	});
}

function button_opt_download_script(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' opt_download_script ',
	});
}

function button_opt_download_file(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' opt_download_file ',
	});
}

function button_re_upan_storage(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' re_upan_storage ',
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_script.asp">
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
							<h2 class="box_head round_top">配置扩展环境</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">设置脚本功能启动参数。&nbsp;<span style="color:#FF0000;">更多的脚本功能设置，需要到自定义脚本0功能详细配置。<div><span style="color:#888;">当前 opt 文件:【<% nvram_get_x("", "opto"); %>】，最新 opt 文件:【<% nvram_get_x("", "optt"); %>】</span></div><div><span style="color:#888;">当前 script 文件:【<% nvram_get_x("", "scripto"); %>】，最新 script 文件:【<% nvram_get_x("", "scriptt"); %>】</span></div></span></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="3" style="background-color: #E3E3E3;">opt 环境</th>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">启用 opt 自动更新</th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="upopt_enable_on_of">
														<input type="checkbox" id="upopt_enable_fake" <% nvram_match_x("", "upopt_enable", "1", "value=1 checked"); %><% nvram_match_x("", "upopt_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="upopt_enable" id="upopt_enable_1" class="input" value="1" <% nvram_match_x("", "upopt_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="upopt_enable" id="upopt_enable_0" class="input" value="0" <% nvram_match_x("", "upopt_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td style="border-top: 0 none;"><input id="optbackup" class="btn btn-success" style="width:110px;" type="button" name="optbackup" value="备份 /opt/lib|bin" onclick="button_optbackup()" /></td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">启用 扩展脚本 自动更新</th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="upscript_enable_on_of">
														<input type="checkbox" id="upscript_enable_fake" <% nvram_match_x("", "upscript_enable", "1", "value=1 checked"); %><% nvram_match_x("", "upscript_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="upscript_enable" id="upscript_enable_1" class="input" value="1" <% nvram_match_x("", "upscript_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="upscript_enable" id="upscript_enable_0" class="input" value="0" <% nvram_match_x("", "upscript_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td style="border-top: 0 none;"><input id="upscript" class="btn btn-success" style="width:110px;" type="button" name="upscript" value="手动更新脚本" onclick="button_upscript()" /></td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 4);">opt 强制安装</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="optinstall_on_of">
														<input type="checkbox" id="optinstall_fake" <% nvram_match_x("", "optinstall", "1", "value=1 checked"); %><% nvram_match_x("", "optinstall", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="optinstall" id="optinstall_1" class="input" value="1" <% nvram_match_x("", "optinstall", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="optinstall" id="optinstall_0" class="input" value="0" <% nvram_match_x("", "optinstall", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td style="border-top: 0 none;"><input id="reopt" class="btn btn-success" style="width:110px;" type="button" name="reopt" value="重置opt文件" onclick="button_reopt()" /></td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">opt 安装模式</th>
											<td style="border-top: 0 none;" >
												<select name="ss_opt_x" class="input" style="width: 200px;"  onChange="change_ss_opt_x();">
													<option value="1" <% nvram_match_x("","ss_opt_x", "1","selected"); %>>自动选择:SD→U盘→内存</option>
													<option value="2" <% nvram_match_x("","ss_opt_x", "2","selected"); %>>安装到内存:需要空余内存(10M+)</option>
													<option value="3" <% nvram_match_x("","ss_opt_x", "3","selected"); %>>安装到 SD</option>
													<option value="4" <% nvram_match_x("","ss_opt_x", "4","selected"); %>>安装到 U盘</option>
													<option value="5" <% nvram_match_x("","ss_opt_x", "5","selected"); %>>安装到 指定目录</option>
													<option value="6" <% nvram_match_x("","ss_opt_x", "6","selected"); %>>安装到 远程共享【镜像模式】</option>
												</select>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">调整 /tmp 最大空间</th>
											<td style="border-top: 0 none;" >
												<select name="size_tmpfs" class="input" style="width: 200px;"  onChange="change_ss_opt_x();">
													<option value="0" <% nvram_match_x("","size_tmpfs", "0","selected"); %>>不调整</option>
													<option value="1" <% nvram_match_x("","size_tmpfs", "1","selected"); %>>占内存50%</option>
													<option value="2" <% nvram_match_x("","size_tmpfs", "2","selected"); %>>占内存60%</option>
													<option value="3" <% nvram_match_x("","size_tmpfs", "3","selected"); %>>占内存70%</option>
													<option value="4" <% nvram_match_x("","size_tmpfs", "4","selected"); %>>占内存80%</option>
													<option value="5" <% nvram_match_x("","size_tmpfs", "5","selected"); %>>占内存90%</option>
												</select>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">opt镜像大小(M)</th>
											<td style="border-top: 0 none;">
												<input name="opt_cifs_block" placeholder="1999" type="text" class="input" id="opt_cifs_block" onkeypress="return is_number(this,event);" value="<% nvram_get_x("","opt_cifs_block"); %>" size="32" maxlength="512" style="width: 100px;" />
											</td>
											<td style="border-top: 0 none;">
												<span style="color:#888;">不是ext4磁盘时</br>用镜像生成opt</span>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">opt镜像路径</th>
											<td colspan="2" style="border-top: 0 none;" id="opt_cifs_dir_td" style="display:none;">
												<input name="opt_cifs_dir" placeholder="/media/cifs" type="text" class="input" id="opt_cifs_dir" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","opt_cifs_dir"); %>" size="32" maxlength="512" />
											</td>
											<td colspan="2" style="border-top: 0 none;" id="opt_cifs_block_td" style="display:none;">
												<input name="opt_cifs_2_dir" placeholder="/media/cifs" type="text" class="input" id="opt_cifs_2_dir" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","opt_cifs_2_dir"); %>" size="32" maxlength="512" />
											</td>
										</tr>
										<tr id="opt_cifs_script_td" style="display:none;">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i><a href="javascript:spoiler_toggle('scriptcifs')"><span>cifs_script.sh</span><div>&nbsp;<span style="color:#888;">以下脚本可以修改 SMB资源挂载配置参数</span></div></a>
												<div id="scriptcifs" style="display:none;">
													<textarea rows="10" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.cifs_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.cifs_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%">自定义 opt 环境下载地址</th>
											<td colspan="1">
													<div class="main_itoggle">
													<div id="opt_force_enable_on_of">
														<input type="checkbox" id="opt_force_enable_fake" <% nvram_match_x("", "opt_force_enable", "1", "value=1 checked"); %><% nvram_match_x("", "opt_force_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="opt_force_enable" id="opt_force_enable_1" class="input" value="1" onClick="opt_force_enable_bridge(1);" <% nvram_match_x("", "opt_force_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="opt_force_enable" id="opt_force_enable_0" class="input" value="0" onClick="opt_force_enable_bridge(1);" <% nvram_match_x("", "opt_force_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td id="opt_download_tr_1" style="display:none;">
												<input id="opt_download_script" class="btn btn-success" style="width:110px;" type="button" name="opt_download_script" value="重置离线 script" onclick="button_opt_download_script()" />
											</td>
										</tr>
										<tr id="opt_force_tr" style="display:none;">
											<th style="border-top: 0 none;">自定义 opt 环境下载地址:</th>
											<td colspan="1" style="border-top: 0 none;">
											<div class="input-append">
												<input type="text" maxlength="300" class="input" size="15" name="opt_force_www" id="opt_force_www" placeholder="https://opt.cn2qq.com" value="<% nvram_get_x("","opt_force_www"); %>" onKeyPress="return is_string(this,event);"/>
											</div>
											</td>
											<td id="opt_download_tr_2" style="border-top: 0 none;display:none;">
												<input id="opt_download_file" class="btn btn-success" style="width:110px;" type="button" name="opt_download_file" value="重置离线 file" onclick="button_opt_download_file()" />
											</td>
										</tr>
										<tr>
											<th width="30%">部署离线 opt 环境下载地址</th>
											<td colspan="1">
													<div class="main_itoggle">
													<div id="opt_download_enable_on_of">
														<input type="checkbox" id="opt_download_enable_fake" <% nvram_match_x("", "opt_download_enable", "1", "value=1 checked"); %><% nvram_match_x("", "opt_download_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="opt_download_enable" id="opt_download_enable_1" class="input" value="1" onClick="opt_download_enable_bridge(1);" <% nvram_match_x("", "opt_download_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="opt_download_enable" id="opt_download_enable_0" class="input" value="0" onClick="opt_download_enable_bridge(1);" <% nvram_match_x("", "opt_download_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td>
												<input id="opt_download" class="btn btn-success" style="width:110px;padding-left: 5px;" type="button" name="opt_download" value="增量更新离线opt" onclick="button_opt_download()" />
											</td>
										</tr>
										<tr>
											<th width="30%">修复SMB共享根目录只有8KB</th>
											<td colspan="2">
													<div class="main_itoggle">
													<div id="size_media_enable_on_of">
														<input type="checkbox" id="size_media_enable_fake" <% nvram_match_x("", "size_media_enable", "1", "value=1 checked"); %><% nvram_match_x("", "size_media_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="size_media_enable" id="size_media_enable_1" class="input" value="1" <% nvram_match_x("", "size_media_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="size_media_enable" id="size_media_enable_0" class="input" value="0" <% nvram_match_x("", "size_media_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%">外部存储[脚本文件] (/etc/storage)</th>
											<td colspan="1">
													<div class="main_itoggle">
													<div id="upan_storage_enable_on_of">
														<input type="checkbox" id="upan_storage_enable_fake" <% nvram_match_x("", "upan_storage_enable", "1", "value=1 checked"); %><% nvram_match_x("", "upan_storage_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="upan_storage_enable" id="upan_storage_enable_1" class="input" value="1" <% nvram_match_x("", "upan_storage_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="upan_storage_enable" id="upan_storage_enable_0" class="input" value="0" <% nvram_match_x("", "upan_storage_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td>
												<input id="re_upan_storage" class="btn btn-success" style="width:110px;" type="button" name="re_upan_storage" value="重置外部存储" onclick="button_re_upan_storage()" />
											</td>
										</tr>
										<tr>
											<th width="30%">显示 程序日志</th>
											<td colspan="2">
													<div class="main_itoggle">
													<div id="cmd_log_enable_on_of">
														<input type="checkbox" id="cmd_log_enable_fake" <% nvram_match_x("", "cmd_log_enable", "1", "value=1 checked"); %><% nvram_match_x("", "cmd_log_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="cmd_log_enable" id="cmd_log_enable_1" class="input" value="1" <% nvram_match_x("", "cmd_log_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="cmd_log_enable" id="cmd_log_enable_0" class="input" value="0" <% nvram_match_x("", "cmd_log_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%">启用 进程卡CPU检测</th>
											<td colspan="1">
													<div class="main_itoggle">
													<div id="cmd_cpu_enable_on_of">
														<input type="checkbox" id="cmd_cpu_enable_fake" <% nvram_match_x("", "cmd_cpu_enable", "1", "value=1 checked"); %><% nvram_match_x("", "cmd_cpu_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="cmd_cpu_enable" id="cmd_cpu_enable_1" class="input" value="1" <% nvram_match_x("", "cmd_cpu_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="cmd_cpu_enable" id="cmd_cpu_enable_0" class="input" value="0" <% nvram_match_x("", "cmd_cpu_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td>
												<div><span style="color:#888;">卡CPU后33分钟</span></div>
												<div><span style="color:#888;">进程自动停止</span></div>
											</td>
										</tr>
										<tr>
											<th width="30%">更换 reboot 方式</th>
											<td>
												<select name="cmd_reboot_enable" class="input" style="width: 200px;">
													<option value="0" <% nvram_match_x("","cmd_reboot_enable", "0","selected"); %>>kill -15 1</option>
													<option value="1" <% nvram_match_x("","cmd_reboot_enable", "1","selected"); %>>mtd_write -r unlock mtd1</option>
												</select>
											</td>
											<td>
												<span style="color:#888;">当重启失效时更换</span>
											</td>
										</tr>
										<tr>
											<th colspan="3" style="background-color: #E3E3E3;">高级功能</th>
										</tr>
										<tr>
											<th><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 17);">启用 Syncthing 云存储 功能</a></th>
											<td colspan="2">
													<div class="main_itoggle">
													<div id="syncthing_enable_on_of">
														<input type="checkbox" id="syncthing_enable_fake" <% nvram_match_x("", "syncthing_enable", "1", "value=1 checked"); %><% nvram_match_x("", "syncthing_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="syncthing_enable" id="syncthing_enable_1" class="input" value="1" onClick="change_syncthing_enable_bridge(1);" <% nvram_match_x("", "syncthing_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="syncthing_enable" id="syncthing_enable_0" class="input" value="0" onClick="change_syncthing_enable_bridge(1);" <% nvram_match_x("", "syncthing_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="syncthing_desc0" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 18);">Syncthing 允许 WAN 接入</a></th>
											<td colspan="2" style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="syncthing_wan_on_of">
														<input type="checkbox" id="syncthing_wan_fake" <% nvram_match_x("", "syncthing_wan", "1", "value=1 checked"); %><% nvram_match_x("", "syncthing_wan", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="syncthing_wan" id="syncthing_wan_1" class="input" value="1" <% nvram_match_x("", "syncthing_wan", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="syncthing_wan" id="syncthing_wan_0" class="input" value="0" <% nvram_match_x("", "syncthing_wan", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="syncthing_desc1" style="display:none;">
											<th style="border-top: 0 none;">Syncthing 的 WebGUI 端口:</th>
											<td colspan="2" style="border-top: 0 none;">
											<div class="input-append">
												<input style="width: 100px;" maxlength="5" class="input" size="15" name="syncthing_wan_port" id="syncthing_wan_port" placeholder="8384" value="<% nvram_get_x("","syncthing_wan_port"); %>" onKeyPress="return is_number(this,event);"/>
												&nbsp;<span style="color:#888;">[8384]</span>&nbsp;<i class="icon-hand-right"></i> <input class="btn btn-success" style="" type="button" value="WebGUI 管理界面" onclick="button_syncthing_wan_port()" />
											</div>
											</td>
										</tr>
										<tr id="syncthing_desc2" style="display:none;">
										<th width="30%" style="border-top: 0 none;">Syncthing WebGUI 密码：</th>
										<td colspan="2" style="border-top: 0 none;">默认空，请进入 WebGUI 配置(首次启动需要5分钟)</td>
										</tr>
										<tr id="syncthing_desc3" style="display:none;">
										<th width="30%" style="border-top: 0 none;">Syncthing 项目主页、说明：</th>
										<td colspan="2" style="border-top: 0 none;">【<a href="https://syncthing.net/" target="_blank">https://syncthing.net/</a>】</td>
										</tr>

										<tr>
											<th width="30%" ><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 6);">启用 迅雷远程下载 功能</a></th>
											<td >
													<div class="main_itoggle">
													<div id="xunleis_on_of">
														<input type="checkbox" id="xunleis_fake" <% nvram_match_x("", "xunleis", "1", "value=1 checked"); %><% nvram_match_x("", "xunleis", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="xunleis" id="xunleis_1" class="input" value="1" onClick="change_xunleis_bridge(1);" <% nvram_match_x("", "xunleis", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="xunleis" id="xunleis_0" class="input" value="0" onClick="change_xunleis_bridge(1);" <% nvram_match_x("", "xunleis", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="xunleis_dir_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 11);">下载目录:</a></th>
											<td colspan="2" style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="xunleis_dir" name="xunleis_dir" value="<% nvram_get_x("","xunleis_dir"); %>" onKeyPress="return is_string(this,event);" />
												<div><span style="color:#888;">【留空自动匹配】</span>&nbsp;<span style="color:#FF0000;">需要U盘</span></div>
											</td>
										</tr>
										<tr id="xunleis_get_sn" style="display:none;">
											<th width="30%" style="border-top: 0 none;">激活码:</th>
											<td colspan="2" style="border-top: 0 none;">
											   <div size="15">【<% nvram_get_x("","xunleis_sn"); %>】刷新日志或者页面</div>
											</td>
										</tr>
										<tr id="xunleis_admin" style="display:none;">
										<th width="30%" style="border-top: 0 none;">管理页面：</th>
										<td colspan="2" style="border-top: 0 none;">【<a href="http://yuancheng.xunlei.com/" target="_blank">http://yuancheng.xunlei.com/</a>】</td>
										</tr>
										<tr>
											<th width="30%" ><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 7);">启用 迅雷快鸟 功能</a></th>
											<td colspan="2" >
													<div class="main_itoggle">
													<div id="FastDick_enable_on_of">
														<input type="checkbox" id="FastDick_enable_fake" <% nvram_match_x("", "FastDick_enable", "1", "value=1 checked"); %><% nvram_match_x("", "FastDick_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="FastDick_enable" id="FastDick_enable_1" class="input" value="1" onClick="change_FastDick_enable_bridge(1);" <% nvram_match_x("", "FastDick_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="FastDick_enable" id="FastDick_enable_0" class="input" value="0" onClick="change_FastDick_enable_bridge(1);" <% nvram_match_x("", "FastDick_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="FastDicks" style="display:none;">
											<th width="30%" style="border-top: 0 none;">启动方案</th>
											<td colspan="2" style="border-top: 0 none;">
												<select name="FastDicks" class="input">
													<option value="1" <% nvram_match_x("","FastDicks", "1","selected"); %>>插U盘启动</option>
													<option value="2" <% nvram_match_x("","FastDicks", "2","selected"); %>>免U盘启动</option>
												</select>
												<div>&nbsp;<span style="color:#888;">迅雷快鸟【<a href="http://k.xunlei.com/" target="_blank">http://k.xunlei.com/</a>】</span></div>
											</td>
										</tr>
										<tr id="FastDick_uid" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 7);">迅雷账号:</a></th>
											<td colspan="2" style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="FastDick_uid" name="FastDick_uid" value="<% nvram_get_x("","FastDick_uid"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="FastDick_pwd_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 7);">迅雷密码:</a></th>
											<td colspan="2" style="border-top: 0 none;">
											<div class="input-append">
												<input type="password" maxlength="512" class="input" size="15" name="FastDick_pwd" id="FastDick_pwd" style="width: 175px;" value="<% nvram_get_x("","FastDick_pwd"); %>" onKeyPress="return is_string(this,event);"/>
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('FastDick_pwd')"><i class="icon-eye-close"></i></button>
											</div>
											</td>
										</tr>
										<tr id="row_post_FastDick_script">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script9')"><span><#RunFastDick#></span><div>&nbsp;<span style="color:#888;">以下脚本可以修改 swjsq_wget.sh 文件内容</span></div></a>
												<div id="script9" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.FastDick_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.FastDick_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>

										<tr style="display:none;">
											<th width="30%" ><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 10);">启用 优酷路由宝 功能</a></th>
											<td colspan="2" >
													<div class="main_itoggle">
													<div id="youku_enable_on_of">
														<input type="checkbox" id="youku_enable_fake" <% nvram_match_x("", "youku_enable", "1", "value=1 checked"); %><% nvram_match_x("", "youku_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="youku_enable" id="youku_enable_1" class="input" value="1" onClick="change_youku_enable_bridge(1);" <% nvram_match_x("", "youku_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="youku_enable" id="youku_enable_0" class="input" value="0" onClick="change_youku_enable_bridge(1);" <% nvram_match_x("", "youku_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="youku_hc_dir" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 11);">自定义缓存目录:</a></th>
											<td colspan="2" style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="youku_hc_dir" name="youku_hc_dir" value="<% nvram_get_x("","youku_hc_dir"); %>" onKeyPress="return is_string(this,event);" />
												<div><span style="color:#888;">【/media/AiDisk_a1】</span></div>
											</td>
										</tr>
										<tr id="youku_hc" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 13);">缓存大小 (MB):</a></th>
											<td colspan="2" style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="youku_hc" name="youku_hc" value="<% nvram_get_x("","youku_hc"); %>" onKeyPress="return is_number(this,event);" />
											</td>
										</tr>
										<tr id="youku_sn" style="display:none;">
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 12);">自定义16位 SN:</a></th>
											<td colspan="2" style="border-top: 0 none;">
												<input type="text" maxlength="128" class="input" size="15" id="youku_sn" name="youku_sn" value="<% nvram_get_x("","youku_sn"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="youku_spd" style="display:none;">
											<th width="30%" style="border-top: 0 none;">挖矿速度模式</th>
											<td colspan="2" style="border-top: 0 none;">
												<select name="youku_spd" class="input">
													<option value="0" <% nvram_match_x("","youku_spd", "0","selected"); %>>激进模式：赚取收益优先</option>
													<option value="2" <% nvram_match_x("","youku_spd", "2","selected"); %>>平衡模式：赚钱上网兼顾+</option>
													<option value="3" <% nvram_match_x("","youku_spd", "3","selected"); %>>保守模式：上网体验优先+</option>
												</select>
												<div>
												&nbsp;<a href="<% nvram_get_x("","youku_bdlink"); %>" target="blank">绑定地址</a>
												</div>
											</td>
										</tr>
										<tr style="display:none;">
											<th width="30%" ><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 JBLS 功能</a></th>
											<td colspan="2" >
													<div class="main_itoggle">
													<div id="jbls_enable_on_of">
														<input type="checkbox" id="jbls_enable_fake" <% nvram_match_x("", "jbls_enable", "1", "value=1 checked"); %><% nvram_match_x("", "jbls_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="jbls_enable" id="jbls_enable_1" class="input" value="1" onClick="change_jbls_enable_bridge(1);" <% nvram_match_x("", "jbls_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="jbls_enable" id="jbls_enable_0" class="input" value="0" onClick="change_jbls_enable_bridge(1);" <% nvram_match_x("", "jbls_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="jbls_Start_script" style="display:none;">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i><a href="javascript:spoiler_toggle('scriptjbls')"><span>jbls_script</span><div>&nbsp;<span style="color:#888;">以下脚本可以修改 JBLS 配置参数</span></div></a>
												<div id="scriptjbls" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.jbls_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.jbls_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%" ><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 KMS 功能</a></th>
											<td  colspan="2">
													<div class="main_itoggle">
													<div id="kms_enable_on_of">
														<input type="checkbox" id="kms_enable_fake" <% nvram_match_x("", "kms_enable", "1", "value=1 checked"); %><% nvram_match_x("", "kms_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="kms_enable" id="kms_enable_1" class="input" value="1" onClick="change_kms_enable_bridge(1);" <% nvram_match_x("", "kms_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="kms_enable" id="kms_enable_0" class="input" value="0" onClick="change_kms_enable_bridge(1);" <% nvram_match_x("", "kms_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="kms_Start_script">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i><a href="javascript:spoiler_toggle('script1')"><span>vlmcsdini</span><div>&nbsp;<span style="color:#888;">以下脚本可以修改 kms 配置参数</span></div></a>
												<div id="script1" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.vlmcsdini_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.vlmcsdini_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th colspan="3" style="background-color: #E3E3E3;">代理服务</th>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 TinyProxy 服务</a></th>
											<td colspan="2" style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="tinyproxy_enable_on_of">
														<input type="checkbox" id="tinyproxy_enable_fake" <% nvram_match_x("", "tinyproxy_enable", "1", "value=1 checked"); %><% nvram_match_x("", "tinyproxy_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="tinyproxy_enable" id="tinyproxy_enable_1" class="input" value="1" onClick="change_tinyproxy_enable_bridge(1);" <% nvram_match_x("", "tinyproxy_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="tinyproxy_enable" id="tinyproxy_enable_0" class="input" value="0" onClick="change_tinyproxy_enable_bridge(1);" <% nvram_match_x("", "tinyproxy_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="tinyproxy_path">
											<th style="border-top: 0 none;">TinyProxy 程序路径:</th>
											<td colspan="2" style="border-top: 0 none;"><input name="tinyproxy_path" placeholder="/usr/sbin/tinyproxy" type="text" class="input" id="tinyproxy_path" onkeypress="return is_string(this,event);" value="<% nvram_get_x("","tinyproxy_path"); %>" size="32" maxlength="128" />
											<br /><span style="color:#888;">默认/usr/sbin/tinyproxy,可自定义</span></td>
										</tr>
										<tr id="tinyproxy_port">
											<th style="border-top: 0 none;" width="30%">TinyProxy 允许 WAN 接入</th>
											<td colspan="2" style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="tinyproxy_port_on_of">
														<input type="checkbox" id="tinyproxy_port_fake" <% nvram_match_x("", "tinyproxy_port", "1", "value=1 checked"); %><% nvram_match_x("", "tinyproxy_port", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="tinyproxy_port" id="tinyproxy_port_1" class="input" value="1" <% nvram_match_x("", "tinyproxy_port", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="tinyproxy_port" id="tinyproxy_port_0" class="input" value="0" <% nvram_match_x("", "tinyproxy_port", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="tinyproxy_script">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i><a href="javascript:spoiler_toggle('script13')"><span>tinyproxy_script</span><div>&nbsp;<span style="color:#888;">以下脚本可以修改 tinyproxy 启动参数</span></div></a>
												<div id="script13" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.tinyproxy_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.tinyproxy_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%" ><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 MProxy 服务</a></th>
											<td colspan="2" >
													<div class="main_itoggle">
													<div id="mproxy_enable_on_of">
														<input type="checkbox" id="mproxy_enable_fake" <% nvram_match_x("", "mproxy_enable", "1", "value=1 checked"); %><% nvram_match_x("", "mproxy_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="mproxy_enable" id="mproxy_enable_1" class="input" value="1" onClick="change_mproxy_enable_bridge(1);" <% nvram_match_x("", "mproxy_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="mproxy_enable" id="mproxy_enable_0" class="input" value="0" onClick="change_mproxy_enable_bridge(1);" <% nvram_match_x("", "mproxy_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="mproxy_port">
											<th width="30%" style="border-top: 0 none;">MProxy 允许 WAN 接入</th>
											<td colspan="2" style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="mproxy_port_on_of">
														<input type="checkbox" id="mproxy_port_fake" <% nvram_match_x("", "mproxy_port", "1", "value=1 checked"); %><% nvram_match_x("", "mproxy_port", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="mproxy_port" id="mproxy_port_1" class="input" value="1" <% nvram_match_x("", "mproxy_port", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="mproxy_port" id="mproxy_port_0" class="input" value="0" <% nvram_match_x("", "mproxy_port", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="mproxy_script">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i><a href="javascript:spoiler_toggle('script14')"><span>mproxy_script</span><div>&nbsp;<span style="color:#888;">以下脚本可以修改 mproxy 启动参数</span></div></a>
												<div id="script14" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.mproxy_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.mproxy_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%" ><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 16);">启用 VPNProxy 服务</a></th>
											<td colspan="2">
													<div class="main_itoggle">
													<div id="vpnproxy_enable_on_of">
														<input type="checkbox" id="vpnproxy_enable_fake" <% nvram_match_x("", "vpnproxy_enable", "1", "value=1 checked"); %><% nvram_match_x("", "vpnproxy_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="vpnproxy_enable" id="vpnproxy_enable_1" class="input" value="1" onClick="change_vpnproxy_enable_bridge(1);" <% nvram_match_x("", "vpnproxy_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="vpnproxy_enable" id="vpnproxy_enable_0" class="input" value="0" onClick="change_vpnproxy_enable_bridge(1);" <% nvram_match_x("", "vpnproxy_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="vpnproxy_wan_port">
											<th style="border-top: 0 none;">VPNProxy 端口:</th>
											<td colspan="2" style="border-top: 0 none;"><input name="vpnproxy_wan_port" placeholder="8888" type="text" class="input" id="vpnproxy_wan_port" onkeypress="return is_number(this,event);" value="<% nvram_get_x("","vpnproxy_wan_port"); %>" size="32" maxlength="5" />
											<br /><span style="color:#888;">默认[8888]，可自定义，默认允许 WAN 接入</span></td>
										</tr>
										<tr id="vpnproxy_vpn_port">
											<th style="border-top: 0 none;">OpenVPN 端口:</th>
											<td colspan="2" style="border-top: 0 none;"><input name="vpnproxy_vpn_port" placeholder="1194" type="text" class="input" id="vpnproxy_vpn_port" onkeypress="return is_number(this,event);" value="<% nvram_get_x("","vpnproxy_vpn_port"); %>" size="32" maxlength="5" />
											<br /><span style="color:#888;">默认[1194]，可自定义，<a href="http://koolshare.cn/thread-48041-1-1.html" target="blank">免流原理</a></span></td>
										</tr>

										<tr>
											<td colspan="3" style="border-top: 0 none;">
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

