var sw_mode = '<% nvram_get_x("", "sw_mode"); %>';
var wan_route_x = '<% nvram_get_x("", "wan_route_x"); %>';
var wan_proto = '<% nvram_get_x("", "wan_proto"); %>';
var lan_proto = '<% nvram_get_x("", "lan_proto_x"); %>';
var log_float = '<% nvram_get_x("", "log_float_ui"); %>';
var log_stamp = 0;
var sysinfo = <% json_system_status(); %>;
var uptimeStr = "<% uptime(); %>";
var timezone = uptimeStr.substring(26,31);
var newformat_systime = uptimeStr.substring(8,11) + " " + uptimeStr.substring(5,7) + " " + uptimeStr.substring(17,25) + " " + uptimeStr.substring(12,16);  //Ex format: Jun 23 10:33:31 2008
var systime_millsec = Date.parse(newformat_systime); // millsec from system
var JS_timeObj = new Date(); // 1970.1.1
var cookie_pref = 'n56u_cookie_';

var uagent = navigator.userAgent.toLowerCase();
var is_ie11p = (/trident\/7\./).test(uagent);
var is_mobile = (/iphone|ipod|ipad|iemobile|android|blackberry|fennec/).test(uagent);

var new_wan_internet = '<% nvram_get_x("", "link_internet"); %>';
var id_check_status = 0;
var id_system_info = 0;

var cookie = {
	set: function(key, value, days) {
		document.cookie = cookie_pref + key + '=' + value + '; expires=' +
			(new Date(new Date().getTime() + ((days ? days : 14) * 86400000))).toUTCString() + '; path=/';
	},
	get: function(key) {
		var r = ('; ' + document.cookie + ';').match('; ' + cookie_pref + key + '=(.*?);');
		return r ? r[1] : null;
	},
	unset: function(key) {
		document.cookie = cookie_pref + key + '=; expires=' + (new Date(1)).toUTCString() + '; path=/';
	}
};

<% firmware_caps_hook(); %>

function get_ap_mode(){
	return (wan_route_x == 'IP_Bridged' || sw_mode == '3') ? true : false;
}

function unload_body(){
	disableCheckChangedStatus();
	no_flash_button();
	return true;
}

function enableCheckChangedStatus(flag){
	var tm_int_sec = 1;

	disableCheckChangedStatus();

	if (new_wan_internet == '0')
		tm_int_sec = 2;
	else if (new_wan_internet == '1')
		tm_int_sec = 5;

	id_check_status = setTimeout("get_changed_status();", tm_int_sec * 1000);
}

function disableCheckChangedStatus(){
	clearTimeout(id_check_status);
}

function update_internet_status(){
	if (new_wan_internet == '1')
		showMapWANStatus(1);
	else if(new_wan_internet == '2')
		showMapWANStatus(2);
	else
		showMapWANStatus(0);
}

function notify_status_internet(wan_internet){
	this.new_wan_internet = wan_internet;
	if((location.pathname == "/" || location.pathname == "/index.asp") && (typeof(update_internet_status) === 'function'))
		update_internet_status();
}

function notify_status_vpn_client(vpnc_state){
	if((location.pathname == "/vpncli.asp") && (typeof(update_vpnc_status) === 'function'))
		update_vpnc_status(vpnc_state);
}

function get_changed_status(){
	var $j = jQuery.noConflict();
	$j.ajax({
		type: 'get',
		url: '/status_internet.asp',
		dataType: 'script',
		cache: true,
		error: function(xhr) {
			;
		},
		success: function(response) {
			notify_status_internet(now_wan_internet);
			notify_status_vpn_client(now_vpnc_state);
			enableCheckChangedStatus();
		}
	});
}

function get_system_info(){
	var $j = jQuery.noConflict();
	clearTimeout(id_system_info);
	$j.ajax({
		type: 'get',
		url: '/system_status_data.asp',
		dataType: 'script',
		cache: true,
		error: function(xhr) {
			id_system_info = setTimeout('get_system_info()', 2000);
		},
		success: function(response) {
			id_system_info = setTimeout('get_system_info()', 2000);
			setSystemInfo(response);
		}
	});
}

function bytesToSize(bytes, precision){
	var absval = Math.abs(bytes);
	var kilobyte = 1024;
	var megabyte = kilobyte * 1024;
	var gigabyte = megabyte * 1024;
	var terabyte = gigabyte * 1024;

	if (absval < kilobyte)
		return bytes + ' B';
	else if (absval < megabyte)
		return (bytes / kilobyte).toFixed(precision) + ' KB';
	else if (absval < gigabyte)
		return (bytes / megabyte).toFixed(precision) + ' MB';
	else if (absval < terabyte)
		return (bytes / gigabyte).toFixed(precision) + ' GB';
	else
		return (bytes / terabyte).toFixed(precision) + ' TB';
}

function getLALabelStatus(num){
	var la = parseFloat(num);
	return la > 0.9 ? 'danger' : (la > 0.5 ? 'warning' : 'info');
}

function setSystemInfo(response){
	if(typeof(si_new) !== 'object')
		return;

	var cpu_now = {};
	var cpu_total = (si_new.cpu.total - sysinfo.cpu.total);
	if (!cpu_total)
		cpu_total = 1;

	cpu_now.busy = parseInt((si_new.cpu.busy - sysinfo.cpu.busy) * 100 / cpu_total);
	cpu_now.user = parseInt((si_new.cpu.user - sysinfo.cpu.user) * 100 / cpu_total);
	cpu_now.nice = parseInt((si_new.cpu.nice - sysinfo.cpu.nice) * 100 / cpu_total);
	cpu_now.system = parseInt((si_new.cpu.system - sysinfo.cpu.system) * 100 / cpu_total);
	cpu_now.idle = parseInt((si_new.cpu.idle - sysinfo.cpu.idle) * 100 / cpu_total);
	cpu_now.iowait = parseInt((si_new.cpu.iowait - sysinfo.cpu.iowait) * 100 / cpu_total);
	cpu_now.irq = parseInt((si_new.cpu.irq - sysinfo.cpu.irq) * 100 / cpu_total);
	cpu_now.sirq = parseInt((si_new.cpu.sirq - sysinfo.cpu.sirq) * 100 / cpu_total);

	sysinfo = si_new;

	showSystemInfo(cpu_now,1);
}

function showSystemInfo(cpu_now,force){
	var $j = jQuery.noConflict();
	var arrLA = sysinfo.lavg.split(' ');
	var h = sysinfo.uptime.hours < 10 ? ('0'+sysinfo.uptime.hours) : sysinfo.uptime.hours;
	var m = sysinfo.uptime.minutes < 10 ? ('0'+sysinfo.uptime.minutes) : sysinfo.uptime.minutes;

	$j("#la_info").html('<span class="label label-'+getLALabelStatus(arrLA[0])+'">'+arrLA[0]+'</span>&nbsp;<span class="label label-'+getLALabelStatus(arrLA[1])+'">'+arrLA[1]+'</span>&nbsp;<span class="label label-'+getLALabelStatus(arrLA[2])+'">'+arrLA[2]+'</span>');
	$j("#cpu_info").html(cpu_now.busy + '%');
	$j("#mem_info").html(bytesToSize(sysinfo.ram.free*1024, 2) + " / " + bytesToSize(sysinfo.ram.total*1024, 2));
	$j("#uptime_info").html(sysinfo.uptime.days + "<#Day#>".substring(0,1) + " " + h+"<#Hour#>".substring(0,1) + " " + m+"<#Minute#>".substring(0,1));

	$j("#cpu_usage tr:nth-child(1) td:first").html('busy: '+cpu_now.busy+'%');
	$j("#cpu_usage tr:nth-child(2) td:first").html('user: '+cpu_now.user+'%');
	$j("#cpu_usage tr:nth-child(2) td:last").html('system: '+cpu_now.system+'%');
	$j("#cpu_usage tr:nth-child(3) td:first").html('sirq: '+cpu_now.sirq+'%');
	$j("#cpu_usage tr:nth-child(3) td:last").html('irq: '+cpu_now.irq+'%');
	$j("#cpu_usage tr:nth-child(4) td:first").html('idle: '+cpu_now.idle+'%');
	$j("#cpu_usage tr:nth-child(4) td:last").html('nice: '+cpu_now.nice+'%');

	$j("#mem_usage tr:nth-child(1) td:first").html('total: '+bytesToSize(sysinfo.ram.total*1024, 2));
	$j("#mem_usage tr:nth-child(2) td:first").html('free: '+bytesToSize(sysinfo.ram.free*1024, 2));
	$j("#mem_usage tr:nth-child(2) td:last").html('used: '+bytesToSize(sysinfo.ram.used*1024, 2));
	$j("#mem_usage tr:nth-child(3) td:first").html('cached: '+bytesToSize(sysinfo.ram.cached*1024, 2));
	$j("#mem_usage tr:nth-child(3) td:last").html('buffers: '+bytesToSize(sysinfo.ram.buffers*1024, 2));
	$j("#mem_usage tr:nth-child(4) td:first").html('swap: '+bytesToSize(sysinfo.swap.total*1024, 2));
	$j("#mem_usage tr:nth-child(4) td:last").html('swap used: '+bytesToSize(sysinfo.swap.used*1024, 2));

	if(parseInt(sysinfo.wifi2.state) > 0)
		$j('#wifi2_b').addClass('btn-info');
	else
		$j('#wifi2_b').removeClass('btn-info');

	if(parseInt(sysinfo.wifi5.state) > 0)
		$j('#wifi5_b').addClass('btn-info');
	else
		$j('#wifi5_b').removeClass('btn-info');

	if(parseInt(sysinfo.wifi2.guest) > 0)
		$j('#wifi2_b_g').addClass('btn-info');
	else
		$j('#wifi2_b_g').removeClass('btn-info');

	if(parseInt(sysinfo.wifi5.guest) > 0)
		$j('#wifi5_b_g').addClass('btn-info');
	else
		$j('#wifi5_b_g').removeClass('btn-info');

	setLogStamp(sysinfo.logmt);

	if(force && typeof(parent.getSystemJsonData) === 'function')
		getSystemJsonData(cpu_now, sysinfo.ram);
}

var menu_code="", navL1="", navL2="", tab_code="", footer_code;
var enabled2Gclass = '<% nvram_match_x("","rt_radio_x", "1", "btn-info"); %>';
var enabled5Gclass = '<% nvram_match_x("","wl_radio_x", "1", "btn-info"); %>';
var enabledGuest2Gclass = '<% nvram_match_x("","rt_guest_enable", "1", "btn-info"); %>';
var enabledGuest5Gclass = '<% nvram_match_x("","wl_guest_enable", "1", "btn-info"); %>';
var enabledBtnCommit = '<% nvram_match_x("","nvram_manual", "0", "display:none;"); %>';

// L3 = The third Level of Menu
function show_banner(L3){
	var bc = '';
	var style_2g = 'width:55px;';
	var style_5g = 'width:55px;';
	if (!support_5g_radio()) {
		style_2g = 'width:114px;';
		style_5g = 'width:21px;display:none;';
	}
	var title_2g = '"2.4G"'
	if (!support_2g_radio()) {
		title_2g = '"N/A" disabled';
	}

	// log panel
	if (!is_mobile && log_float != '0'){
		bc += '<div class="syslog_panel">\n';
		bc += '<button id="syslog_panel_button" class="handle" href="/"><span class="log_text">Log</span></button>\n';
		bc += '<table class="" style="margin-top: 0px; margin-bottom: 5px" width="100%" border="0">\n';
		bc += '  <tr>\n';
		bc += '    <td width="60%" style="text-align: left"><b><#General_x_SystemTime_itemname#>:</b><span class="alert alert-info" style="margin-left: 10px; padding-top: 4px; padding-bottom: 4px;" id="system_time_log_area"></span></td>\n';
		bc += '    <td style="text-align: lift"><input type="hidden" id="scrATop" value=""></td>\n';
		bc += '    <td style="text-align: right"><button type="button" id="clearlog_btn" class="btn btn-info" style="min-width: 170px;" onclick="clearlog();"><#CTL_clear#></button></td>\n';
		bc += '  </tr>\n';
		bc += '</table>\n';
		bc += '<span><textarea rows="28" wrap="off" class="span12" readonly="readonly" id="log_area"></textarea></span>\n';
		bc += '</div>\n';
	}

	// for chang language
	bc +='<form method="post" name="titleForm" id="titleForm" action="/start_apply.htm" target="hidden_frame">\n';
	bc +='<input type="hidden" name="current_page" value="">\n';
	bc +='<input type="hidden" name="sid_list" value="LANGUAGE;">\n';
	bc +='<input type="hidden" name="action_mode" value=" Apply ">\n';
	bc +='<input type="hidden" name="preferred_lang" value="">\n';
	bc +='<input type="hidden" name="flag" value="">\n';
	bc +='</form>\n';

	// --->
	bc += '<div class="container-fluid" style="padding-left: 0px; margin-left: -6px;">\n';
	bc += '<div class="row-fluid">\n';

	// block system info
	bc += '<div class="span6">\n';
	bc += '<div class="well" style="margin-bottom: 0px; height: 109px; padding: 7px 6px 6px 6px;">\n';
	bc += '<div class="row-fluid">\n';

	bc += '<div id="main_info">\n';
	bc += '<table class="table table-condensed" width="100%" style="margin-bottom: 0px;">\n';
	bc += '  <tr>\n';
	bc += '    <td width="43%" style="border: 0 none;"><#SI_LoadAvg#></td>\n';
	bc += '    <td style="border: 0 none; min-width: 115px;"><div id="la_info"> -- -- -- </div></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td style="height: 20px;"><a class="adv_info" href="javascript:void(0)" onclick="click_info_cpu();"><#SI_LoadCPU#></a></td>\n';
	bc += '    <td><span id="cpu_info"> -- % </span></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td><a class="adv_info" href="javascript:void(0)" onclick="click_info_mem();"><#SI_FreeMem#></a></td>\n';
	bc += '    <td><span id="mem_info"> -- MB / -- MB </span></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td><#SI_Uptime#></td>\n';
	bc += '    <td><span id="uptime_info">&nbsp;</span></td>\n';
	bc += '  </tr>\n';
	bc += '</table>\n';
	bc += '</div>\n';

	bc += '<div id="cpu_usage" style="display: none;">\n';
	bc += '<table class="table table-condensed" width="100%" style="margin-bottom: 0px;">\n';
	bc += '  <tr>\n';
	bc += '    <td width="43%" style="text-align:left; border: 0 none;"></td>\n';
	bc += '    <td style="border: 0 none; text-align:right;"><a class="label" href="javascript:void(0)" onclick="hide_adv_info();">hide</a></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td style="height: 20px;"></td>\n';
	bc += '    <td></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td></td>\n';
	bc += '    <td></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td></td>\n';
	bc += '    <td></td>\n';
	bc += '  </tr>\n';
	bc += '</table>\n';
	bc += '</div>\n';

	bc += '<div id="mem_usage" style="display: none;">\n';
	bc += '<table class="table table-condensed" width="100%" style="margin-bottom: 0px;">\n';
	bc += '  <tr>\n';
	bc += '    <td width="43%" style="text-align:left; border: 0 none;"></td>\n';
	bc += '    <td style="border: 0 none; text-align:right;"><a class="label" href="javascript:void(0)" onclick="hide_adv_info();">hide</a></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td style="height: 20px;"></td>\n';
	bc += '    <td></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td></td>\n';
	bc += '    <td></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td></td>\n';
	bc += '    <td></td>\n';
	bc += '  </tr>\n';
	bc += '</table>\n';
	bc += '</div>\n';

	bc += '</div>\n';
	bc += '</div>\n';
	bc += '</div>\n';

	// block firmware version
	bc += '<div class="span6">\n';
	bc += '<div class="well" style="margin-bottom: 0px; height: 109px; padding: 5px 6px 8px 6px;">\n';
	bc += '<div class="row-fluid">\n';
	bc += '<table class="table table-condensed" style="margin-bottom: 0px">\n';
	bc += '  <tr>\n';
	bc += '    <td width="50%" style="border: 0 none;"><#menu5_1#>:</td>\n';
	bc += '    <td style="border: 0 none; min-width: 115px;"><div class="form-inline"><input type="button" id="wifi2_b" class="btn btn-mini '+enabled2Gclass+'" style="'+style_2g+'" value='+title_2g+' onclick="go_setting(2);">&nbsp;<input type="button" id="wifi5_b" style="'+style_5g+'" class="btn btn-mini '+enabled5Gclass+'" value="5G" onclick="go_setting(5);"></div></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td><#menu5_1_2#>:</td>\n';
	bc += '    <td><div class="form-inline"><input type="button" id="wifi2_b_g" class="btn btn-mini '+enabledGuest2Gclass+'" style="'+style_2g+'" value='+title_2g+' onclick="go_wguest(2);">&nbsp;<input type="button" id="wifi5_b_g" style="'+style_5g+'" class="btn btn-mini '+enabledGuest5Gclass+'" value="5G" onclick="go_wguest(5);"></div></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td><#General_x_FirmwareVersion_itemname#></td>\n';
	bc += '    <td><a href="/Advanced_FirmwareUpgrade_Content.asp"><span id="firmver" class="time"></span></a></td>\n';
	bc += '  </tr>\n';
	bc += '  <tr>\n';
	bc += '    <td><button type="button" id="commit_btn" class="btn btn-mini" style="width: 114px; height: 21px; outline:0; '+enabledBtnCommit+'" onclick="commit();"><i class="icon icon-fire"></i>&nbsp;<#CTL_Commit#></button></td>\n';
	bc += '    <td><button type="button" id="logout_btn" class="btn btn-mini" style="height: 21px; outline:0;" title="<#t1Logout#>" onclick="logout();"><i class="icon icon-user"></i></button> <button type="button" id="reboto_btn" class="btn btn-mini" style="height: 21px; outline:0;" title="<#BTN_REBOOT#>" onclick="reboot();"><i class="icon icon-repeat"></i></button> <button type="button" id="shutdown_btn" class="btn btn-mini" style="height: 21px; outline:0;" title="<#BTN_SHUTDOWN#>" onclick="shutdown();"><i class="icon icon-off"></i></button></td>\n';
	bc += '  </tr>\n';
	bc += '</table>\n';
	bc += '</div>\n';
	bc += '</div>\n';
	bc += '</div>\n';

	bc += '</div>\n';
	bc += '</div>\n';

	bc +='</td></tr></table>\n';

	$("TopBanner").innerHTML = bc;

	show_loading_obj();
	show_top_status();
}

//new MENU 2021-1-2 17:47 by xtr3mz
var tabM0=[
	{"title":"<#menu5_1_1#>","link":"Advanced_Wireless2g_Content.asp"},
	{"title":"<#menu5_1_2#>","link":"Advanced_WGuest2g_Content.asp"},
	{"title":"<#menu5_1_3#>","link":"Advanced_WMode2g_Content.asp"},
	{"title":"<#menu5_1_4#>","link":"Advanced_ACL2g_Content.asp"},
	{"title":"<#menu5_1_5#>","link":"Advanced_WSecurity2g_Content.asp"},
	{"title":"<#menu5_1_6#>","link":"Advanced_WAdvanced2g_Content.asp"}
];
var tabM1=[
	{"title":"<#menu5_1_1#>","link":"Advanced_Wireless_Content.asp"},
	{"title":"<#menu5_1_2#>","link":"Advanced_WGuest_Content.asp"},
	{"title":"<#menu5_1_3#>","link":"Advanced_WMode_Content.asp"},
	{"title":"<#menu5_1_4#>","link":"Advanced_ACL_Content.asp"},
	{"title":"<#menu5_1_5#>","link":"Advanced_WSecurity_Content.asp"},
	{"title":"<#menu5_1_6#>","link":"Advanced_WAdvanced_Content.asp"}
];

var tabM2=[
	{"title":"<#menu5_2_1#>","link":"Advanced_LAN_Content.asp"},
	{"title":"<#menu5_2_2#>","link":"Advanced_DHCP_Content.asp"},
	{"title":"<#menu5_2_3#>","link":"Advanced_GWStaticRoute_Content.asp"},
	{"title":"<#menu5_2_4#>","link":"Advanced_IPTV_Content.asp"},
	{"title":"<#menu5_2_5#>","link":"Advanced_Switch_Content.asp"},
	{"title":"<#menu5_2_6#>","link":"Advanced_WOL_Content.asp"}
];
var tabM3=[
	{"title":"<#menu5_3_1#>","link":"Advanced_WAN_Content.asp"},
	{"title":"<#menu5_3_3#>","link":"Advanced_IPv6_Content.asp"},
	{"title":"<#menu5_3_4#>","link":"Advanced_VirtualServer_Content.asp"},
	{"title":"<#menu5_3_5#>","link":"Advanced_Exposed_Content.asp"},
	{"title":"<#menu5_3_6#>","link":"Advanced_DDNS_Content.asp"}
];
var tabM4=[
	{"title":"<#menu5_5_1#>","link":"Advanced_BasicFirewall_Content.asp"},
	{"title":"<#menu5_5_5#>","link":"Advanced_Netfilter_Content.asp"},
	{"title":"<#menu5_5_2#>","link":"Advanced_URLFilter_Content.asp"},
	{"title":"<#menu5_5_3#>","link":"Advanced_MACFilter_Content.asp"},
	{"title":"<#menu5_5_4#>","link":"Advanced_Firewall_Content.asp"}
];
var tabM5=[
	{"title":"<#menu5_4_3#>","link":"Advanced_AiDisk_others.asp"},
	{"title":"<#menu5_4_1#>","link":"Advanced_AiDisk_samba.asp"},
	{"title":"<#menu5_4_2#>","link":"Advanced_AiDisk_ftp.asp"},
	{"title":"<#menu5_4_4#>","link":"Advanced_Modem_others.asp"},
	{"title":"<#menu5_4_5#>","link":"Advanced_Printer_others.asp"}
];
var tabM6=[
	{"title":"<#menu5_6_2#>","link":"Advanced_System_Content.asp"},
	{"title":"<#menu5_6_5#>","link":"Advanced_Services_Content.asp"},
	{"title":"<#menu5_6_1#>","link":"Advanced_OperationMode_Content.asp"},
	{"title":"<#menu5_6_3#>","link":"Advanced_FirmwareUpgrade_Content.asp"},
	{"title":"<#menu5_6_4#>","link":"Advanced_SettingBackup_Content.asp"},
	{"title":"<#menu5_6_6#>","link":"Advanced_Console_Content.asp"}
];
var tabM7=[
	{"title":"<#menu5_10_1#>","link":"Advanced_Tweaks_Content.asp"},
	{"title":"<#menu5_10_2#>","link":"Advanced_Scripts_Content.asp"},
	{"title":"<#menu5_10_3#>","link":"Advanced_InetDetect_Content.asp"}
];
var tabM8=[
	{"title":"<#menu5_11#>","link":"Main_WStatus2g_Content.asp"},
	{"title":"<#menu5_12#>","link":"Main_WStatus_Content.asp"},
	{"title":"WAN","link":"Main_EStatus_Content.asp#0"},
	{"title":"","link":""},
	{"title":"","link":""},
	{"title":"","link":""},
	{"title":"","link":""},
	{"title":"","link":""},
	{"title":"","link":""},
	{"title":"","link":""}
];
var tabM9=[
	{"title":"<#menu5_7_2#>","link":"Main_LogStatus_Content.asp"},
	{"title":"<#menu5_7_3#>","link":"Main_DHCPStatus_Content.asp"},
	{"title":"<#menu5_7_5#>","link":"Main_IPTStatus_Content.asp"},
	{"title":"<#menu5_7_6#>","link":"Main_RouteStatus_Content.asp"},
	{"title":"<#menu5_7_8#>","link":"Main_CTStatus_Content.asp"},
];
var tabM=[tabM0,tabM1,tabM2,tabM3,tabM4,tabM5,tabM6,tabM7,tabM8,tabM9];

//Level 1 Menu in Gateway, Router mode
//生成子菜单 /L1 sub 与 L2 sub对应
var menuL1=[
	{"title":"<#menu1#>","link":"index.asp","icon":"icon-home","sub":"main"},
	//{"title":"HDD","link":"","icon":"icon-hdd"},
	//{"title":"","link":"","icon":"icon-retweet"},
	//{"title":"","link":"","icon":"icon-globe"},
	{"title":"<#menu4#>","link":"Main_TrafficMonitor_realtime.asp","icon":"icon-tasks"},
	{"title":"<#menu5_8#>","link":"Advanced_System_Info.asp","icon":"icon-random","sub":"log"},
	{"title":"<#menu5#>","link":"as.asp","icon":"icon-wrench","sub":"adv"},
	{"title":"插件","link":"javascript:;","icon":"icon-wrench","sub":"plugin"}
];
//Level 2 Menu
//sub 与 L1的sub 对应，自动显示到L1下面
var menuL2=[
	{"title":"<#menu5_11#>","link":tabM[0][0].link,"sub":"main"},
	{"title":"<#menu5_12#>","link":tabM[1][0].link,"sub":"main"},
	{"title":"<#menu5_2#>","link":tabM[2][0].link,"sub":"main"},
	{"title":"<#menu5_3#>","link":tabM[3][0].link,"sub":"main"},
	{"title":"<#menu5_5#>","link":tabM[4][0].link,"sub":"adv"},
	{"title":"<#menu5_4#>","link":tabM[5][0].link,"sub":"adv"},
	{"title":"<#menu5_6#>","link":tabM[6][0].link,"sub":"adv"},
	{"title":"<#menu5_10#>","link":tabM[7][0].link,"sub":"adv"},
	{"title":"<#menu5_9#>","link":support_2g_radio() ? tabM[8][0].link : "Main_EStatus_Content.asp","sub":"log"},
	{"title":"<#menu5_7#>","link":tabM[9][0].link,"sub":"log"}
];

/* plugin menu 插件菜单 */
if (found_app_scutclient()){
	var mx={"title":"<#menu5_13#>","link":"scutclient.asp","sub":"plugin"};//json格式
	var mx2=[mx,{"title":"log","link":"scutclient_log.asp"}];//显示tab，多个页面
	menuL2.push(mx);//必须写
	tabM.push(mx2);//必须写
}
if (found_app_dnsforwarder()){
	var mx={"title":"<#menu5_15#>","link":"dns-forwarder.asp","sub":"plugin"};
	var mx2=[mx];
	menuL2.push(mx);
	tabM.push(mx2);
}
if (found_app_shadowsocks()){
	var mx={"title":"<#menu5_16#>","link":"Shadowsocks.asp","sub":"plugin"};
	var mx2=[mx,{"title":"log","link":"Shadowsocks_log.asp"}];
	menuL2.push(mx);
	tabM.push(mx2);
}
if (found_app_mentohust()){
	var mx={"title":"mentohust","link":"mentohust.asp","sub":"plugin"};
	var mx2=[mx,{"title":"log","link":"mentohust_log.asp"}];
	menuL2.push(mx);
	tabM.push(mx2);
}
/* plugin menu 插件菜单 结束*/

/* 旧代码兼容/as.asp menu compatibility start */
var menuL2_title=Array();var menuL2_link=Array();
for(var i=0;i<menuL2.length;i++){
	menuL2_title[i]=menuL2[i].title;
	menuL2_link[i]=menuL2[i].link;
}
var tabtitle=Array();var tablink=Array();
for(var i=0;i<tabM.length;i++){
	tabtitle[i]= Array();
	tablink[i]=Array();
	for(var j=0;j<tabM[i].length;j++){
		tablink[i][j]=tabM[i][j].link;
		tabtitle[i][j]=tabM[i][j].title;
	}
}
/* menu compatibility end */

function show_menu(L1, L2, L3){
	var $j = jQuery.noConflict();
	var i;
	if(sw_mode == '3'){
		tabM[2].splice(3,1);//LAN
		tabM[3].splice(1,5);//WAN
		tabM[4].splice(1,5);//firewall
		tabM[5].splice(4,1);//USB
		tabM[9].splice(2,4);//log
		menuL2[4].link = "";  //remove WAN
		menuL2[5].link = "";  //remove Firewall
		if (lan_proto == '1'){
			tabM[2].splice(2,1);
		}
		var url="Advanced_APLAN_Content.asp";
		tabM[2][1].link = url;
		menuL2[3].link = url;
	}else{
		if(sw_mode == '4'){
			tabM[3].splice(3,2);
		}
		if(!support_ipv6()){
			tabM[3].splice(2,1);
		}
	}
	//LAN编号 网络信息页
	var num_ephy = support_num_ephy();
	if (num_ephy < 2)
		num_ephy = 2;
	if (num_ephy > 8)
		num_ephy = 8;
	for (i=1;i<num_ephy;i++){
		tabM[8][i+3] = {"title":"LAN"+i,"link":"Main_EStatus_Content.asp#"+i};
	}
	if(num_ephy<8){
		tabM[8].splice(3+num_ephy,8-num_ephy);
	}

	if(!support_2g_radio()){
		menuL2.splice(1,1);  //remove 2G
		tabM[0].splice(1,6);
		tabM[8].splice(1,1);
	}

	if(!support_5g_radio()){
		menuL2.splice(2,1);;  //remove 5GHz
		tabM[1].splice(1,6);
		var idx = support_2g_radio() ? 2 : 1;
		tabM[8].splice(idx,1);
	}

	if(!support_storage()){
		tabM[5].splice(1,5);
		menuL2[6].link = "";  //remove USB
	}else{
		if(!support_usb()){
			tabM[5].splice(4,2);
		}
		if(!found_app_smbd() && !found_app_ftpd()){
			tabM[5].splice(2,2);
		}
		else if(!found_app_smbd()){
			tabM[5].splice(2,1);
		}
		else if(!found_app_ftpd()){
			tabM[5].splice(3,1);
		}
	}
	//showmenu(L1_id , L2_id , L3_id)
	//L1
	var navL1="";var navL2S="";//submenu
	for(i = 0; i < menuL1.length; i++){
		var navL2="";
		var title1=menuL1[i].title;
		var link1=menuL1[i].link;
		var sub1=menuL1[i].sub || "";
		
		if(title1 == ""){continue;}
		if(typeof sub1 !="undefined" && sub1 != ""){
			//L2 ，根据sub属性，显示到L1的下面
			for(var j = 0; j < menuL2.length; j++){
				console.log(menuL2[j].sub +"--" + sub1);
				if (typeof menuL2[j].sub =='undefined' || menuL2[j].sub != sub1) {continue;}
				var title2= menuL2[j].title;
				var link2= menuL2[j].link;
				if(title2 == ""){continue;}
				else if(L2 == (j+1))
					navL2 += '<a href="javascript: void(0)" style="color: #005580"><i class="icon-minus"></i><b>&nbsp;&nbsp;'+title2+'</b></a>';
				else
					navL2 += '<a href="'+link2+'"><i class="icon-minus"></i>&nbsp;&nbsp;'+title2+'</a>';
			}
			$j('#subMenu').append(navL2);
			navL2= '<div class="accordion">'+navL2+'</div>';
		}
		var icon=menuL1[i].icon !== ""?menuL1[i].icon:"";
		if(L1 == (i+1) && L2 <= 0)
			navL1 += '<li class="active" id="option'+i+'"><a href="javascript:;"><i class="'+icon+'"></i>&nbsp;&nbsp;'+title1+'</a>'+navL2+'</li>';
		else
			navL1 += '<li id="option'+i+'"><a href="'+link1+'"><i class="'+icon+'"></i>&nbsp;&nbsp;'+title1+'</a>'+navL2+'</li>';
	}
	$j("#mainMenu").html(navL1);
	
	//L3
	if(L3){
		tab_code = '<ul class="nav nav-tabs" style="margin-bottom: 0px;">';
		for(var i = 0; i < tabM[L2-1].length; ++i){
			var title=typeof tabM[L2-1][i].title =="undefined"?"":tabM[L2-1][i].title;
			var link=typeof tabM[L2-1][i].link =="undefined"?"":tabM[L2-1][i].link;
			if(title == "")
				continue;
			if(L3 ==( i+1)){
				var tab_ref = (L2==9 && i>0 && link.indexOf("#")>0)?link:"javascript: void(0)";
				tab_code += '<li class="active"><a href="' +tab_ref+ '">'+title+'</a></li>';
			}else
				tab_code += '<li><a href="' +link+ '">'+title+'</a></li>';
		}
		tab_code += '</ul>';
		$j("#tabMenu").html(tab_code);
	}
	else
		$j("#tabMenu").html("");
}

function show_footer(){
	footer_code = '<div align="center" class="bottom-image"></div>\n';
	footer_code +='<div align="center" class="copyright"><#footer_copyright_desc#></div>\n';
	footer_code +='<div align="center">\n';
	footer_code +='  <span>Highcharts by Torstein Hønsi & <a href="http://www.highcharts.com">Highsoft</a></span></br>\n';
	footer_code +='  <span>Big icons designed by <a href="http://www.freepik.com">Freepik</a></br></span>\n';
	footer_code +='  <span>Non-Commercial Use Only</span></br>\n';
	footer_code +='</div>\n';

	$("footer").innerHTML = footer_code;

	flash_button();
}

function show_top_status(){
	var $j = jQuery.noConflict();

	$j("#cpu_info").click(function(){
		$j("#main_info").hide();
		$j("#cpu_usage").show();
	});
	$j("#mem_info").click(function(){
		$j("#main_info").hide();
		$j("#mem_usage").show();
	});

	id_system_info = setTimeout('get_system_info()', 2000);
	showSystemInfo({busy: 0, user: 0, nice: 0, system: 0, idle: 0, iowait: 0, irq: 0, sirq: 0}, 0);

	showtext($("firmver"), '<% nvram_get_x("",  "firmver_sub"); %>');

	/*if(sw_mode == "3")
		$("sw_mode_span").innerHTML = "AP";
	else
		$("sw_mode_span").innerHTML = "Router";*/
}

function go_setting(band){
	if(band == "2")
		location.href = "Advanced_Wireless2g_Content.asp";
	else
		location.href = "Advanced_Wireless_Content.asp";
}

function go_wguest(band){
	if(band == "2")
		location.href = "Advanced_WGuest2g_Content.asp";
	else
		location.href = "Advanced_WGuest_Content.asp";
}

function show_time(){
	JS_timeObj.setTime(systime_millsec); // Add millsec to it.
	JS_timeObj3 = JS_timeObj.toString();
	JS_timeObj3 = checkTime(JS_timeObj.getHours()) + ":" +
			checkTime(JS_timeObj.getMinutes()) + ":" +
			checkTime(JS_timeObj.getSeconds());
	$('systemtime').innerHTML ="<a href='/Advanced_System_Content.asp'>" + JS_timeObj3 + "</a>";
	systime_millsec += 1000;
	stime_ID = setTimeout("show_time();", 1000);
}

function checkTime(i){
	if (i<10)
		{i="0" + i}
	return i;
}

function show_loading_obj(){
	var code = '';

	code += '<center><div id="loadingBlock" class="loadingBlock">';
	code += '<div class="container-fluid">';
	code += '<div class="well" style="background-color: #212121; width: 60%;">';
	code += '<div class="progress progress-striped active" style="width: 50%; text-align: left;"><div class="bar" id="proceeding_bar" style="width: 0%;"><span id="proceeding_txt"></span></div></div>';
	code += '<span id="proceeding_main_txt"><#Main_alert_proceeding_desc4#></span></span>';
	code += '</div>';
	code += '</div>';
	code += '</div></center>';

	$("Loading").innerHTML = code;
	id_check_status = setTimeout('hideLoading();', 3000);
}

function submit_language(){
	if($("select_lang").value != $("preferred_lang").value){
		showLoading();
		
		with(document.titleForm){
			action = "/start_apply.htm";
			
			if(location.pathname == "/")
				current_page.value = "/index.asp";
			else
				current_page.value = location.pathname;
			
			preferred_lang.value = $("select_lang").value;
			flag.value = "set_language";
			
			submit();
		}
	}
}

function logout(){
	if(!confirm('<#JS_logout#>'))
		return;
	setTimeout('location = "Logout.asp";', 1);
}

function reboot(){
	if(!confirm('<#Main_content_Login_Item7#>'))
		return;
	showLoading(board_boot_time());
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' Reboot ',
	});
}

function shutdown(){
	if(!confirm('<#JS_shutdown#>'))
		return;
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' Shutdown ',
		'current_page': 'Main_LogStatus_Content.asp'
	});
}

function click_info_cpu(){
	location.href="/Advanced_System_Info.asp#CPU";
}

function click_info_mem(){
	location.href="/Advanced_System_Info.asp#MEM";
}

function hide_adv_info(){
	var $j = jQuery.noConflict();
	$j("#cpu_usage").hide();
	$j("#mem_usage").hide();
	$j("#main_info").show();
}

function reset_btn_commit(btn_id){
	var $j = jQuery.noConflict();
	var $btn=$j('#'+btn_id);
	$btn.removeClass('alert-error').removeClass('alert-success');
}

function commit(){
	if(!confirm('<#Commit_confirm#>'))
		return;
	var $j = jQuery.noConflict();
	var $btn = $j('#commit_btn');
	$j.ajax({
		type: "post",
		url: "/apply.cgi",
		data: {
			action_mode: " CommitFlash ",
			nvram_action: "commit_nvram"
		},
		dataType: "json",
		error: function(xhr) {
			$btn.addClass('alert-error');
			setTimeout("reset_btn_commit('#commit_btn')", 1500);
		},
		success: function(response) {
			var sys_result = (response != null && typeof response === 'object' && "sys_result" in response)
				? response.sys_result : -1;
			if(sys_result == 0)
				$btn.addClass('alert-success');
			else
				$btn.addClass('alert-error');
			setTimeout("reset_btn_commit('commit_btn')", 1500);
		}
	});
}

function clearlog(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' ClearLog ',
		'current_page': 'Main_LogStatus_Content.asp'
	});
	setLogData();
}

function kb_to_gb(kilobytes){
	if(typeof(kilobytes) == "string" && kilobytes.length == 0)
		return 0;
	return (kilobytes*1024)/(1024*1024*1024);
}

function simpleNum(num){
	if(typeof(num) == "string" && num.length == 0)
		return 0;
	return parseInt(kb_to_gb(num)*1000)/1000;
}

function simpleNum2(num){
	if(typeof(num) == "string" && num.length == 0)
		return 0;
	return parseInt(num*1000)/1000;
}

function simpleNum3(num){
	if(typeof(num) == "string" && num.length == 0)
		return 0;
	return parseInt(num)/1024;
}

function $(){
	var elements = new Array();

	for(var i = 0; i < arguments.length; ++i){
		var element = arguments[i];
	if(typeof element == 'string')
		element = document.getElementById(element);
		
		if(arguments.length == 1)
			return element;
		
		elements.push(element);
	}

	return elements;
}

function E(e) {
	return (typeof(e) === 'string') ? document.getElementById(e) : e;
}

function getElementsByName_iefix(tag, name){
	var tagObjs = document.getElementsByTagName(tag);
	var objsName;
	var targetObjs = new Array();
	var targetObjs_length;

	if(!(typeof(name) == "string" && name.length > 0))
		return [];

	for(var i = 0, targetObjs_length = 0; i < tagObjs.length; ++i){
		objsName = tagObjs[i].getAttribute("name");
		
		if(objsName && objsName.indexOf(name) == 0){
			targetObjs[targetObjs_length] = tagObjs[i];
			++targetObjs_length;
		}
	}

	return targetObjs;
}

function getElementsByClassName_iefix(tag, name){
	var tagObjs = document.getElementsByTagName(tag);
	var objsName;
	var targetObjs = new Array();
	var targetObjs_length;

	if(!(typeof(name) == "string" && name.length > 0))
		return [];

	for(var i = 0, targetObjs_length = 0; i < tagObjs.length; ++i){
		if(navigator.appName == 'Netscape')
			objsName = tagObjs[i].getAttribute("class");
		else
			objsName = tagObjs[i].getAttribute("className");
		
		if(objsName == name){
			targetObjs[targetObjs_length] = tagObjs[i];
			++targetObjs_length;
		}
	}

	return targetObjs;
}

function showtext(obj, str){
	if(obj)
		obj.innerHTML = str;//*/
}

function showhtmlspace(ori_str){
	var str = "", head, tail_num;

	head = ori_str;
	while((tail_num = head.indexOf(" ")) >= 0){
		str += head.substring(0, tail_num);
		str += "&nbsp;";
		
		head = head.substr(tail_num+1, head.length-(tail_num+1));
	}
	str += head;

	return str;
}

function showhtmland(ori_str){
	var str = "", head, tail_num;

	head = ori_str;
	while((tail_num = head.indexOf("&")) >= 0){
		str += head.substring(0, tail_num);
		str += "&amp;";
		
		head = head.substr(tail_num+1, head.length-(tail_num+1));
	}
	str += head;

	return str;
}

// A dummy function which just returns its argument. This was needed for localization purpose
function translate(str){
	return str;
}

function trim(str){
	return str.replace(/^\s+|\s+$/g, '');
}

function validate_string(string_obj, flag){
	if(string_obj.value.charAt(0) == '"'){
		if(flag != "noalert")
			alert('<#JS_validstr1#> ["]');
		
		string_obj.value = "";
		string_obj.focus();
		
		return false;
	}
	else{
		invalid_char = "";
		
		for(var i = 0; i < string_obj.value.length; ++i){
			if(string_obj.value.charAt(i) < ' ' || string_obj.value.charAt(i) > '~'){
				invalid_char = invalid_char+string_obj.value.charAt(i);
			}
		}
		
		if(invalid_char != ""){
			if(flag != "noalert")
				alert("<#JS_validstr2#> '"+invalid_char+"' !");
			string_obj.value = "";
			string_obj.focus();
			
			return false;
		}
	}
	
	return true;
}

function validate_hex(obj){
	var obj_value = obj.value
	var re = new RegExp("[^a-fA-F0-9]+","gi");
	if(re.test(obj_value))
		return false;
	else
		return true;
}

function validate_psk(psk_obj){
	var psk_length = psk_obj.value.length;
	if(psk_length < 8){
		alert("<#JS_passzero#>");
		psk_obj.value = "00000000";
		psk_obj.focus();
		psk_obj.select();
		
		return false;
	}
	if(psk_length > 64){
		alert("<#JS_PSK64Hex#>");
		psk_obj.value = psk_obj.value.substring(0, 64);
		psk_obj.focus();
		psk_obj.select();
		
		return false;
	}
	if(psk_length >= 8 && psk_length <= 63 && !validate_string(psk_obj)){
		alert("<#JS_PSK64Hex#>");
		psk_obj.value = "00000000";
		psk_obj.focus();
		psk_obj.select();
		
		return false;
	}
	if(psk_length == 64 && !validate_hex(psk_obj)){
		alert("<#JS_PSK64Hex#>");
		psk_obj.value = "00000000";
		psk_obj.focus();
		psk_obj.select();
		
		return false;
	}
	return true;
}

function checkDuplicateName(newname, targetArray){
	var existing_string = targetArray.join(',');
	existing_string = ","+existing_string+",";
	var newstr = ","+trim(newname)+",";
	
	var re = new RegExp(newstr, "gi");
	var matchArray = existing_string.match(re);
	
	if(matchArray != null)
		return true;
	else
		return false;
}

function alert_error_msg(error_msg){
	alert(error_msg);
	refreshpage();
}

function refreshpage(seconds){
	if(typeof(seconds) == "number")
		setTimeout("refreshpage()", seconds*1000);
	else
		location.href = location.href;
}

function hideLinkTag(){
	if(document.all){
		var tagObjs = document.all.tags("a");
		
		for(var i = 0; i < tagObjs.length; ++i)
			tagObjs(i).outerHTML = tagObjs(i).outerHTML.replace(">"," hidefocus=true>");
	}
}

function buttonOver(o){	//Lockchou 1206 modified
	o.style.color = "#FFFFFF";
	o.style.background = "url(/images/bgaibutton.gif) #ACCCE1";
	o.style.cursor = "hand";
}

function buttonOut(o){	//Lockchou 1206 modified
	o.style.color = "#000000";
	o.style.background = "url(/images/bgaibutton0.gif) #ACCCE1";
}

function flash_button(){
	if(navigator.appName.indexOf("Microsoft") < 0)
		return;
	
	var btnObj = getElementsByClassName_iefix("input", "button");
	
	for(var i = 0; i < btnObj.length; ++i){
		btnObj[i].onmouseover = function(){
				buttonOver(this);
			};
		
		btnObj[i].onmouseout = function(){
				buttonOut(this);
			};
	}
}

function no_flash_button(){
	if(navigator.appName.indexOf("Microsoft") < 0)
		return;

	var btnObj = getElementsByClassName_iefix("input", "button");

	for(var i = 0; i < btnObj.length; ++i){
		btnObj[i].onmouseover = "";
		
		btnObj[i].onmouseout = "";
	}
}

function gotoprev(formObj){
	var prev_page = formObj.prev_page.value;

	if(prev_page == "/")
		prev_page = "/index.asp";

	formObj.action = prev_page;
	formObj.target = "_parent";
	formObj.submit();
}

function add_option(selectObj, str, value, selected){
	var tail = selectObj.options.length;

	if(typeof(str) != "undefined")
		selectObj.options[tail] = new Option(str);
	else
		selectObj.options[tail] = new Option();

	if(typeof(value) != "undefined")
		selectObj.options[tail].value = value;
	else
		selectObj.options[tail].value = "";

	if(selected == 1)
		selectObj.options[tail].selected = selected;
}

function free_options(selectObj){
	if(selectObj == null)
		return;

	for(var i = selectObj.options.length-1; i >= 0; --i){
		selectObj.options[i].value = null;
		selectObj.options[i] = null;
	}
}

function blocking(obj_id, show){
	var state = show?'block':'none';

	if(document.getElementById)
		$(obj_id).style.display = state;
	else if(document.layers)
		document.layers[obj_id].display = state;
	else if(document.all)
		document.all[obj_id].style.display = state;
}

function inputCtrl(obj, flag){
	obj.disabled = (flag == 0);
}

// add eagle23
jQuery(document).ready(function(){
    var $j = jQuery.noConflict();

    $j("#logo").click(function(){
        location.href = '/';
    });

    // tabindex navigation
    $j(function(){
        var tabindex = 1;
        $j('input,select').each(function() {
            if (this.type != "hidden"  && this.type != 'radio') {
                var $input = $j(this);
                $input.attr("tabindex", tabindex);
                tabindex++;
            }
        });
    });

    var idFindSyslogPanel = setInterval(function(){
        if(is_mobile || log_float == '0'){
            clearInterval(idFindSyslogPanel);
        }else if($j('.syslog_panel').size() > 0){
            clearInterval(idFindSyslogPanel);

            var offsetLeft = $j('.wrapper').offset().left;
            $j('.syslog_panel').css({opacity: 1});
            $j('.syslog_panel').tabSlideOut({
                tabHandle: '.handle',
                imageHeight: '20px',
                imageWidth: '62px',
                tabLocation: 'top',
                speed: 300,
                action: 'click',
                topPos: '400px',
                leftPos: (offsetLeft+5)+'px',
                fixedPosition: true
            });

            setLogData();
            showClockLogArea();
        }
    }, 100);
});

// fix for ie
String.prototype.nl2br = function(){
    return this.replace(/\n/g, "\n\r");
}

function setLogStamp(mt){
    if(is_mobile || log_float == '0')
        return;

    var $j = jQuery.noConflict();

    if(isLocalStorageAvailable())
        log_stamp = localStorage.getItem('syslog_stamp');
    if(log_stamp == null)
        log_stamp = 0;

    if (log_stamp != mt){
        setToLocalStorage('syslog_stamp', mt);
        if (log_stamp != 0){
            setLogData();
            if(!$j('.syslog_panel').hasClass('open')){
                var tabText = 'Log <span class="label label-important">!</span>';
                $j(".log_text").html(tabText);
            }
        }
        log_stamp = mt;
    }
}

function setLogData(){
    var $j = jQuery.noConflict();
    $j.get('/log_content.asp', function(data){
        // fix for ie
        if($j.browser.msie && !is_ie11p)
            data = data.nl2br();
        if($j("#log_area").val() == ''){
            $j("#log_area").text(data);
            $j("#log_area").prop('scrollTop', $j("#log_area").prop('scrollHeight'));
            $j("#scrATop").val($j("#log_area").prop('scrollTop'));
        }else{
            var scrMaxTop = $j("#log_area").prop('scrollHeight')
            var scrTop = $j("#log_area").prop('scrollTop');
            $j("#log_area").text(data);
            var scrITop = scrMaxTop - scrTop;
            if($j("#scrATop").val() == scrTop || scrITop < 629){
                $j("#log_area").prop('scrollTop', scrMaxTop);
                $j("#scrATop").val($j("#log_area").prop('scrollTop'));
            }else{
                $j("#log_area").prop('scrollTop', scrTop);
            }
        }
    });
}

function showClockLogArea(){
    if(jQuery('#system_time').size() == 0){
        JS_timeObj.setTime(systime_millsec);
        systime_millsec += 1000;

        JS_timeObj2 = JS_timeObj.toString();
        JS_timeObj2 = JS_timeObj2.substring(0,3) + ", " +
        JS_timeObj2.substring(4,10) + "  " +
        checkTime(JS_timeObj.getHours()) + ":" +
        checkTime(JS_timeObj.getMinutes()) + ":" +
        checkTime(JS_timeObj.getSeconds()) + "  " +
        JS_timeObj.getFullYear() + " GMT" + timezone;
    }
    jQuery("#system_time_log_area").html(JS_timeObj2);
    setTimeout("showClockLogArea()", 1000);
}

function onCompleteSlideOutLogArea(){
    var idTimeout = setTimeout(function(){
        clearTimeout(idTimeout);
        jQuery(".log_text").html('Log');
    }, 1500);
}

function passwordShowHide(id){
    var obj = $j('#'+id);
    var changeTo = (obj.attr('type') == 'password') ? 'text' : 'password';
    if ($j.browser.msie && parseInt($j.browser.version, 10) < 9){
        var marker = $j('<span />').insertBefore('#'+id);
        obj.detach().attr('type', changeTo).insertAfter(marker);
        marker.remove();
    }else{
        document.getElementById(id).type = changeTo;
    }
}

/**
 * Local Storage HTML5 Standart
 * http://www.w3.org/TR/webstorage/
 */
/**
 * ckeck if localStorage available
 * @return void
 */
function isLocalStorageAvailable(){
    try {
        return 'localStorage' in window && window['localStorage'] !== null;
    } catch (e) {
        return false;
    }
}

/**
 * set value to localStorage
 * @param name string
 * @param value mixed
 */
function setToLocalStorage(name, value){
    if(isLocalStorageAvailable()){
        try {
            localStorage.setItem(name, value);
        } catch (e) {
            if (e == QUOTA_EXCEEDED_ERR) {
            }
        }
    }
}

/**
 * get from localStorage
 * @param name
 * @return mixed
 */
function getFromLocalStorage(name){
    if(isLocalStorageAvailable()){
        return localStorage.getItem(name);
    }
}

/**
 * remove from localStorage
 * @param name
 * @return void
 */
function removeFromLocalStorage(name){
    if(isLocalStorageAvailable()){
        localStorage.removeItem(name);
    }
}

function mobilestyle(){
var sc = document.createElement("meta");sc.setAttribute("name", "viewport");sc.setAttribute("content", "width=device-width, initial-scale=1, user-scalable=yes");document.head.appendChild(sc);
var style=document.createElement('style');
style.type='text/css';
style.innerHTML="#mainMenu li>i{margin:0 5px 0 0}"
+"#subMenu{display:none}"
+"@media screen and (max-width:800px){"
+"#mainMenu .accordion{display:none}"
+"#subMenu{display:block}"
+"#loadingBlock{margin-top:50px !important}"
+".wrapper{width:100%}"
+".wrapper>.container-fluid,.wrapper>form>.container-fluid{padding:0 5px 5px 5px;margin:0}"
+".container-fluid{padding:none}"
+"#TopBanner .span6{width:auto;float:none;margin:5px;}"
+"#TopBanner .container-fluid{padding:0;margin:0}"
+"#logo{height:50px;margin:-8px auto -12px auto;z-index:-1;}"
+".row-fluid>.span3,.row-fluid>.span9{float:none;width:auto;margin:0}"
//*menu*/
+".sidebar-nav.side_nav,#mainMenu{padding:none;background:none}"
+"#mainMenu{margin:0 0 10px;list-style:none;background:none repeat scroll 0 0 #F5F5F5}"
+"#mainMenu li {float: left; width:50%}"
+"#mainMenu li.active a,#mainMenu li:hover a{background: green;}"
+"#mainMenu li a{display:block;line-height:30px;text-align:center;border-left:1px solid #ccc;}"
+"#subMenu{clear:both;background:none}"
+"#subMenu a{display:block;height:30px;overflow:hidden;float:left;width:33.3%;padding:0;line-height:30px}"
//*body menu*/
+".row-fluid .span9{float:none;width:auto;margin:0}"
+".row-fluid>.span2{float:none;width:auto;height:auto}"
+".row-fluid .span10{float:none;width:auto;margin:0}"
+"#menu_body.sitemap .nav-list{padding:0}"
+"#menu_body.sitemap .nav-list>li>a{margin:0;padding:0}"
+"#menu_body.sitemap table{font-size:0.9em;}"
+"#menu_body.sitemap table td{padding:3px}"
+"#menu_body.sitemap table td li{line-height:22px}"
+".chart-parent{width:100%;overflow:scroll}"
//tabM devs
+".row-fluid>.span2>.well{height:50px !important;padding:0 !important}"
+".quickmenu{padding:0 !important;margin:5px 0;position:relative;}"
+".quickmenu .sub{float:left;width:20%;position:relative}"
+".quickmenu .badge{margin:0 10px 0 -30px}"
+".big-icons,.big-ss {width: 35px !important;height: 35px !important;background-size:35px;}"
+"#iconInternet{background-position:0 0 !important}"
+"#iconRouter{background-position:0 -165px !important}"
+"#iconClient{background-position:0 -82px !important}"
+"#iconUSBdisk0{background-position:0 -333px !important}"
+"}";
document.getElementsByTagName('head')[0].appendChild(style);

	$j = jQuery.noConflict();
	setTimeout(function(){
		if($j(window).width()<800){//body 加载晚
			var qc="";
			$j('.table-big tr').each(function(){
				var o=$j(this);
				qc+='<div class="sub" id="'+o.attr('id')+'" style="'+o.attr('style')+'">'+$j('td',o).html()+'</div>';
				console.log('111');
			});
			$j('<div class="quickmenu">'+qc+'</div>').insertBefore("#tabMenu");
			$j('.table-big').remove();

			$j('#net_chart,#cpu_chart').parents("table").parent().addClass('chart-parent');

		}
	},500);
}

(function($){
    var $j = $.noConflict();
    $j.fn.tabSlideOut = function(callerSettings){
        var settings =  $j.extend({
            tabHandle: '.handle',
            speed: 300,
            action: 'click',
            tabLocation: 'left',
            topPos: '200px',
            leftPos: '20px',
            fixedPosition: false,
            positioning: 'absolute',
            pathToTabImage: null,
            imageHeight: null,
            imageWidth: null
        }, callerSettings||{});

        settings.tabHandle =  $j(settings.tabHandle);
        var obj = this;
        if (settings.fixedPosition === true) {
            settings.positioning = 'fixed';
        } else {
            settings.positioning = 'absolute';
        }

        //ie6 doesn't do well with the fixed option
        if (document.all && !window.opera && !window.XMLHttpRequest) {
            settings.positioning = 'absolute';
        }

        //set initial tabHandle css
        settings.tabHandle.css({
            'display': 'block',
            'width' : settings.imageWidth,
            'height': settings.imageHeight,
            //'textIndent' : '-99999px',
            //'background' : 'url('+settings.pathToTabImage+') no-repeat',
            'outline' : 'none',
            'position' : 'absolute',
            'border-radius': '0px 0px 4px 4px',
            'background-color': '#f5f5f5',
            'border-left': '1px solid #ddd',
            'border-right': '1px solid #ddd',
            'border-bottom': '1px solid #ddd'
        });

        obj.css({
            'line-height' : '1',
            'position' : settings.positioning
        });

        var properties = {
            containerWidth: parseInt(obj.outerWidth(), 10) + 'px',
            containerHeight: parseInt(obj.outerHeight(), 10) + 'px',
            tabWidth: parseInt(settings.tabHandle.outerWidth(), 10) + 'px',
            tabHeight: parseInt(settings.tabHandle.outerHeight(), 10) + 'px'
        };

        //set calculated css
        if(settings.tabLocation === 'top' || settings.tabLocation === 'bottom') {
            obj.css({'left' : settings.leftPos});
            settings.tabHandle.css({'right' : -1});
        }

        if(settings.tabLocation === 'top') {
            obj.css({'top' : '-' + properties.containerHeight});
            settings.tabHandle.css({'bottom' : '-' + properties.tabHeight});
        }

        if(settings.tabLocation === 'bottom') {
            obj.css({'bottom' : '-' + properties.containerHeight, 'position' : 'fixed'});
            settings.tabHandle.css({'top' : '-' + properties.tabHeight});

        }

        if(settings.tabLocation === 'left' || settings.tabLocation === 'right') {
            obj.css({
                'height' : properties.containerHeight,
                'top' : settings.topPos
            });

            settings.tabHandle.css({'top' : 0});
        }

        if(settings.tabLocation === 'left') {
            obj.css({ 'left': '-' + properties.containerWidth});
            settings.tabHandle.css({'right' : '-' + properties.tabWidth});
        }

        if(settings.tabLocation === 'right') {
            obj.css({ 'right': '-' + properties.containerWidth});
            settings.tabHandle.css({'left' : '-' + properties.tabWidth});

            $j('html').css('overflow-x', 'hidden');
        }

        //functions for animation events

        settings.tabHandle.click(function(event){
            event.preventDefault();
        });

        var slideIn = function() {

            if (settings.tabLocation === 'top') {
                obj.animate({top:'-' + properties.containerHeight}, settings.speed).removeClass('open');
            } else if (settings.tabLocation === 'left') {
                obj.animate({left: '-' + properties.containerWidth}, settings.speed).removeClass('open');
            } else if (settings.tabLocation === 'right') {
                obj.animate({right: '-' + properties.containerWidth}, settings.speed).removeClass('open');
            } else if (settings.tabLocation === 'bottom') {
                obj.animate({bottom: '-' + properties.containerHeight}, settings.speed).removeClass('open');
            }

        };

        var slideOut = function() {

            if (settings.tabLocation == 'top') {
                obj.animate({top:'-3px'},  settings.speed, onCompleteSlideOutLogArea()).addClass('open');
            } else if (settings.tabLocation == 'left') {
                obj.animate({left:'-3px'},  settings.speed, onCompleteSlideOutLogArea()).addClass('open');
            } else if (settings.tabLocation == 'right') {
                obj.animate({right:'-3px'},  settings.speed, onCompleteSlideOutLogArea()).addClass('open');
            } else if (settings.tabLocation == 'bottom') {
                obj.animate({bottom:'-3px'},  settings.speed, onCompleteSlideOutLogArea()).addClass('open');
            }
        };

        var clickScreenToClose = function() {
            obj.click(function(event){
                event.stopPropagation();
            });

            $j(document).click(function(){
                slideIn();
            });
        };

        var clickAction = function(){
            settings.tabHandle.click(function(event){
                if (obj.hasClass('open')) {
                    slideIn();
                } else {
                    slideOut();
                }
            });

            clickScreenToClose();
        };

        var hoverAction = function(){
            obj.hover(
                function(){
                    slideOut();
                },

                function(){
                    slideIn();
                });

            settings.tabHandle.click(function(event){
                if (obj.hasClass('open')) {
                    slideIn();
                }
            });
            clickScreenToClose();

        };

        //choose which type of action to bind
        if (settings.action === 'click') {
            clickAction();
        }

        if (settings.action === 'hover') {
            hoverAction();
        }
    };
    mobilestyle();
})(jQuery);
