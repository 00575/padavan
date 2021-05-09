<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - 搭建 Web 环境</title>
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
	init_itoggle('lnmp_enable',change_lnmp_enable_bridge);
});
</script>
<script>
function initial(){
	show_banner(1);
	 show_menu(8,<% nvram_get_x("", "lnmp_L2"); %>,<% nvram_get_x("", "lnmp_L3"); %>);
	show_footer();
	
	change_lnmp_enable_bridge(1);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_lnmp.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function change_lnmp_enable_bridge(mflag){
	var m = document.form.lnmp_enable[0].checked;
}

function done_validating(action){
	refreshpage();
}
function button_relnmp(){
	var str = "你确定要执行 【重启 LNMP 服务】 按钮功能吗？";
	if(confirm(str)){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' button_relnmp ',
	});
	}
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_lnmp.asp">
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
							<h2 class="box_head round_top">搭建 Web 环境</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">在 U 盘搭建 nginx+php+mysql 环境，运行 KodExplorer 芒果云 、owncloud 私有云 等 Web 服务器。<div>备注：不能使用80端口，U 盘格式不支持 FAT32 ，要用 EXT4 或 NTFS。</div>
									<div>这是一个用ONMP脚本安装配置搭建 Web 环境的工具。<a href="https://github.com/xzhih/ONMP" target="blank">项目地址: https://github.com/xzhih/ONMP</a></div>
									<div><span style="color:#888;">当前 opt-lnmp 文件:【<% nvram_get_x("", "lnmpo"); %>】，最新 opt-lnmp 文件:【<% nvram_get_x("", "lnmpt"); %>】</span></div></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr>
											<th width="30%"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 9);">启用 nginx+mysql+php 环境</a></th>
											<td style="border: 0 none;">
												<div class="main_itoggle">
													<div id="lnmp_enable_on_of">
														<input type="checkbox" id="lnmp_enable_fake" <% nvram_match_x("", "lnmp_enable", "1", "value=1 checked"); %><% nvram_match_x("", "lnmp_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="lnmp_enable" id="lnmp_enable_1" class="input" value="1" onClick="change_lnmp_enable_bridge(1);" <% nvram_match_x("", "lnmp_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="lnmp_enable" id="lnmp_enable_0" class="input" value="0" onClick="change_lnmp_enable_bridge(1);" <% nvram_match_x("", "lnmp_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<th>
											<input class="btn btn-success" style="" type="button" value="重启 LNMP 服务" onclick="button_relnmp()" />
											</th>
										</tr>
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">自定义启动服务</th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 ONMP 脚本</th>
											<td colspan="2" style="border: 0 none;">
												<select name="onmp_enable" class="input">
													<option value="0" <% nvram_match_x("","onmp_enable", "0","selected"); %>>启动以下ONMP内置命令</option>
													<option value="1" <% nvram_match_x("","onmp_enable", "1","selected"); %>><% nvram_get_x("", "onmp_1"); %></option>
													<option value="2" <% nvram_match_x("","onmp_enable", "2","selected"); %>><% nvram_get_x("", "onmp_2"); %></option>
													<option value="3" <% nvram_match_x("","onmp_enable", "3","selected"); %>><% nvram_get_x("", "onmp_3"); %></option>
													<option value="4" <% nvram_match_x("","onmp_enable", "4","selected"); %>><% nvram_get_x("", "onmp_4"); %></option>
													<option value="5" <% nvram_match_x("","onmp_enable", "5","selected"); %>><% nvram_get_x("", "onmp_5"); %></option>
													<option value="6" <% nvram_match_x("","onmp_enable", "6","selected"); %>><% nvram_get_x("", "onmp_6"); %></option>
													<option value="7" <% nvram_match_x("","onmp_enable", "7","selected"); %>><% nvram_get_x("", "onmp_7"); %></option>
													<option value="8" <% nvram_match_x("","onmp_enable", "8","selected"); %>><% nvram_get_x("", "onmp_8"); %></option>
													<option value="9" <% nvram_match_x("","onmp_enable", "9","selected"); %>><% nvram_get_x("", "onmp_9"); %></option>
													<option value="10" <% nvram_match_x("","onmp_enable", "10","selected"); %>><% nvram_get_x("", "onmp_10"); %></option>
													<option value="11" <% nvram_match_x("","onmp_enable", "11","selected"); %>><% nvram_get_x("", "onmp_11"); %></option>
													<option value="12" <% nvram_match_x("","onmp_enable", "12","selected"); %>><% nvram_get_x("", "onmp_12"); %></option>
												</select>
												<div colspan="2"><span style="color:#888;">需要先在 web 界面配置NC 和 OC 完成后，才能使用这个选项开启 Redis</span></div>
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 MySQL 程序</th>
											<td style="border: 0 none;">
												<select name="mysql_enable" class="input">
													<option value="0" <% nvram_match_x("","mysql_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","mysql_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","mysql_enable", "2","selected"); %>>是:只接受 localhost</option>
													<option value="4" <% nvram_match_x("","mysql_enable", "4","selected"); %>>重置 MySQL 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">数据库路径：/opt/mysql</span></div>
											</td>
												<th style="border: 0 none;"><span style="color:#FF0000;">帐号：admin或root<div> 初始密码：123456</div></span></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 默认主页 服务</th>
											<td style="border: 0 none;">
												<select name="default_enable" class="input">
													<option value="0" <% nvram_match_x("","default_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","default_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","default_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","default_enable", "4","selected"); %>>重置 默认主页数据（玩坏了？重新再来）</option>
													<option value="5" <% nvram_match_x("","default_enable", "5","selected"); %>>重置 所有网站+mysql（初始化lnmp，请注意备份）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/default</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "default_port"); %>/tz.php" target="_blank">PHP 探针</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 phpMyAdmin 服务</th>
											<td style="border: 0 none;">
												<select name="phpmyadmin_enable" class="input">
													<option value="0" <% nvram_match_x("","phpmyadmin_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","phpmyadmin_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","phpmyadmin_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","phpmyadmin_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/phpMyAdmin</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="https://www.phpmyadmin.net/" target="blank">phpMyAdmin 官网</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 WordPress 服务</th>
											<td style="border: 0 none;">
												<select name="wordpress_enable" class="input">
													<option value="0" <% nvram_match_x("","wordpress_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","wordpress_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","wordpress_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","wordpress_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/WordPress</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="https://cn.wordpress.org/" target="blank">WordPress 官网</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 Wifidog 服务</th>
											<td style="border: 0 none;">
												<select name="wifidog_server_enable" class="input">
													<option value="0" <% nvram_match_x("","wifidog_server_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","wifidog_server_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","wifidog_server_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","wifidog_server_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/wifidog_server</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="./Advanced_Extensions_wifidog.asp" target="blank">Wifidog 设置</a>&nbsp;<a style="color:#00AA00;" href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "wifidog_Port"); %>/wifidog/status/" target="_blank">状态查询</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 h5ai 服务</th>
											<td style="border: 0 none;">
												<select name="h5ai_enable" class="input">
													<option value="0" <% nvram_match_x("","h5ai_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","h5ai_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","h5ai_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","h5ai_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/h5ai</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="https://larsjung.de/h5ai/" target="blank">h5ai 官网</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 Lychee 服务</th>
											<td style="border: 0 none;">
												<select name="lychee_enable" class="input">
													<option value="0" <% nvram_match_x("","lychee_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","lychee_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","lychee_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","lychee_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/Lychee</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="https://github.com/electerious/Lychee/" target="blank">Lychee 官网</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 KodExplorer 服务</th>
											<td style="border: 0 none;">
												<select name="kodexplorer_enable" class="input">
													<option value="0" <% nvram_match_x("","kodexplorer_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","kodexplorer_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","kodexplorer_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","kodexplorer_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/Kodexplorer</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="http://www.kalcaddle.com/" target="blank">KodExplorer 官网</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 Typecho 服务</th>
											<td style="border: 0 none;">
												<select name="typecho_enable" class="input">
													<option value="0" <% nvram_match_x("","typecho_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","typecho_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","typecho_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","typecho_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/Typecho</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="http://typecho.org/" target="blank">Typecho 官网</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 Z-blog 服务</th>
											<td style="border: 0 none;">
												<select name="zblog_enable" class="input">
													<option value="0" <% nvram_match_x("","zblog_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","zblog_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","zblog_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","zblog_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/Zblog</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="https://www.zblogcn.com/" target="blank">Z-blog 官网</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 DzzOffice 服务</th>
											<td style="border: 0 none;">
												<select name="dzzoffice_enable" class="input">
													<option value="0" <% nvram_match_x("","dzzoffice_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","dzzoffice_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","dzzoffice_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","dzzoffice_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/DzzOffice</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="http://www.dzzoffice.com/" target="blank">DzzOffice 官网</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 OwnCloud 服务</th>
											<td style="border: 0 none;">
												<select name="owncloud_enable" class="input">
													<option value="0" <% nvram_match_x("","owncloud_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","owncloud_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","owncloud_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","owncloud_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/Owncloud</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="http://owncloud.org/" target="blank">OwnCloud 官网</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">启用 Nextcloud 服务</th>
											<td style="border: 0 none;">
												<select name="nextcloud_enable" class="input">
													<option value="0" <% nvram_match_x("","nextcloud_enable", "0","selected"); %>>否</option>
													<option value="1" <% nvram_match_x("","nextcloud_enable", "1","selected"); %>>是:允许远程访问</option>
													<option value="2" <% nvram_match_x("","nextcloud_enable", "2","selected"); %>>是:只接受内网访问</option>
													<option value="4" <% nvram_match_x("","nextcloud_enable", "4","selected"); %>>重置 数据（玩坏了？重新再来）</option>
												</select>
												<div colspan="2"><span style="color:#888;">文件路径：/opt/wwwroot/Nextcloud</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="https://nextcloud.com" target="blank">Nextcloud 官网</a></th>
										</tr>
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">设置服务访问端口</th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">默认主页 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="default_port" name="default_port" value="<% nvram_get_x("","default_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[81]，可自定义，注意不可冲突</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "default_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "default_port"); %></a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">phpMyAdmin 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="phpmyadmin_port" name="phpmyadmin_port" value="<% nvram_get_x("","phpmyadmin_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[82]，数据库管理工</span></div>
												</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "phpmyadmin_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "phpmyadmin_port"); %></a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">WordPress 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="wordpress_port" name="wordpress_port" value="<% nvram_get_x("","wordpress_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[83]，博客型内容管理系统程序</span></div>
												</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "wordpress_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "wordpress_port"); %></a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">Wifidog 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="wifidog_server_port" name="wifidog_server_port" value="<% nvram_get_x("","wifidog_server_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[84]，提供验证服务</span></div>
												</td>
												<th style="border: 0 none;">&nbsp;<a href="./Advanced_Extensions_wifidog.asp" target="blank">Wifidog 设置</a>&nbsp;<a style="color:#00AA00;" href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "wifidog_Port"); %>/wifidog/status/" target="_blank">状态查询</a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">h5ai 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="h5ai_port" name="h5ai_port" value="<% nvram_get_x("","h5ai_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[85]，目录列表程序</span></div>
												</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "h5ai_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "h5ai_port"); %></a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">Lychee 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="lychee_port" name="lychee_port" value="<% nvram_get_x("","lychee_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[86]，照片管理工具</span></div>
												</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "lychee_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "lychee_port"); %></a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">KodExplorer 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="kodexplorer_port" name="kodexplorer_port" value="<% nvram_get_x("","kodexplorer_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[88]，私有云盘和在线文件管理器</span></div>
											</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "kodexplorer_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "kodexplorer_port"); %></a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">Typecho 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="typecho_port" name="typecho_port" value="<% nvram_get_x("","typecho_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[90]，轻量级博客系统</span></div>
												</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "typecho_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "typecho_port"); %></a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">Z-blog 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="zblog_port" name="zblog_port" value="<% nvram_get_x("","zblog_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[91]，博客型内容管理系统程序</span></div>
												</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "zblog_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "zblog_port"); %></a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">DzzOffice 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="dzzoffice_port" name="dzzoffice_port" value="<% nvram_get_x("","dzzoffice_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[92]，多功能在线办公私有云平台</span></div>
												</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "dzzoffice_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "dzzoffice_port"); %></a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">OwnCloud 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="owncloud_port" name="owncloud_port" value="<% nvram_get_x("","owncloud_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[98]，私有云储存网盘</span></div>
												</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "owncloud_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "owncloud_port"); %></a></th>
										</tr>
										<tr>
											<th style="border: 0 none;" width="30%">Nextcloud 服务端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5" class="input" size="15" id="nextcloud_port" name="nextcloud_port" value="<% nvram_get_x("","nextcloud_port"); %>" onKeyPress="return is_number(this,event);" />
												<div colspan="2"><span style="color:#888;">默认[99]，私有云储存网盘</span></div>
												</td>
												<th style="border: 0 none;">&nbsp;<a href="http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "nextcloud_port"); %>" target="_blank">http://<% nvram_get_x("", "lan_ipaddr"); %>:<% nvram_get_x("", "nextcloud_port"); %></a></th>
										</tr>
										<tr>
											<td style="border: 0 none;" colspan="2">
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

