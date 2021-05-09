<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - V2Ray proxy</title>
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
<script type="text/javascript" src="/link/vmess.js"></script>
<script type="text/javascript" src="/link/ss.js"></script>
<script type="text/javascript" src="/link/link.js"></script>
<script type="text/javascript" src="/link_d.js"></script>
<script type="text/javascript" src="/link/ping_vmess.js"></script>
<script type="text/javascript" src="/link/ping_ss.js"></script>
<script type="text/javascript" src="/link/ping.js"></script>
<script>
var $j = jQuery.noConflict();

$j(document).ready(function() {

	init_itoggle('v2ray_enable',change_v2ray_enable);
	init_itoggle('ss_udp_enable');
	init_itoggle('v2ray_follow',change_v2ray_follow);
	init_itoggle('ss_keep_check');
	init_itoggle('v2ray_http_enable',change_v2ray_http_enable);
	init_itoggle('app_115');

});

</script>
<script>

<% login_state_hook(); %>

function initial(){
	show_banner(1);
	show_menu(8,<% nvram_get_x("", "v2ray_L2"); %>,<% nvram_get_x("", "v2ray_L3"); %>);
	show_footer();
	change_v2ray_enable(1);
	change_v2ray_follow(1);
	change_v2ray_http_enable(1);
	get_ACL2List();
	showACL2List();
	get_ACL3List();
	showACL3List();
	change_app_108_bridge();
	change_app_114_bridge();
	document.form.app_82.value = '0';
	document.form.app_83.value = '';
	if (!login_safe())
		textarea_scripts_enabled(0);

}

function markGroupACL3(o, c) {
	var rusult=c;
	document.form.app_71.value = ACL3List[rusult][1];
	document.form.app_72.value = ACL3List[rusult][2];
	document.form.app_73.value = ACL3List[rusult][3];
	document.form.app_74.value = ACL3List[rusult][4];
	document.form.app_75.value = ACL3List[rusult][5];
	document.form.app_76.value = ACL3List[rusult][6];
	document.form.app_77.value = ACL3List[rusult][7];
	document.form.app_78.value = ACL3List[rusult][8];
	document.form.app_79.value = ACL3List[rusult][9];
	document.form.app_80.value = ACL3List[rusult][10];
	document.form.app_81.value = ACL3List[rusult][11];
	document.form.app_82.value = ACL3List[rusult][0];
	document.form.app_98.value ="[" + document.form.app_82.value + "]" + document.form.app_72.value;
	return false;
}

function markGroupACL4(o, c) {
	var rusult=c;
	//alert(rusult);
	document.form.app_71.value = '';
	document.form.app_72.value = ACL4List[rusult][1];
	document.form.app_73.value = ACL4List[rusult][2];
	document.form.app_74.value = ACL4List[rusult][3];
	document.form.app_75.value = ACL4List[rusult][4];
	document.form.app_76.value = '';
	document.form.app_77.value = '';
	document.form.app_78.value = ACL4List[rusult][5];
	document.form.app_79.value = ACL4List[rusult][9];
	document.form.app_80.value = '';
	document.form.app_81.value = '';
	document.form.app_82.value = ACL4List[rusult][0];
	document.form.app_98.value ="[" + document.form.app_82.value + "]" + document.form.app_72.value;
	return false;
}

function markGroupACL2(o, c) {
	var rusult=c;
	//alert(rusult);
	document.form.app_71.value = '';
	document.form.app_72.value = ACL2List[rusult][0];
	document.form.app_73.value = ACL2List[rusult][1];
	document.form.app_74.value = ACL2List[rusult][2];
	document.form.app_75.value = ACL2List[rusult][3];
	document.form.app_76.value = '';
	document.form.app_77.value = '';
	document.form.app_78.value = ACL2List[rusult][4];
	document.form.app_79.value = '0';
	document.form.app_80.value = '';
	document.form.app_81.value = '';
	document.form.app_82.value = 'ss';
	document.form.app_98.value ="[" + document.form.app_82.value + "]" + document.form.app_72.value;
	return false;
}

function showACL2List(){
	var code = '';
	var Norule_i = 1;
	if (typeof(ACL2List) != "undefined"){
		if(ACL2List.length > 2) {
			var Norule_i = 0;
		}
	}
	if(Norule_i == 1){
		code +='<tr><td colspan="9" style="text-align: center;"><div class="alert alert-info"><#IPConnection_VSList_Norule#></div></td></tr>';
	}
	if (typeof(ACL2List) != "undefined"){
	if(ACL2List.length > 2) {
		for(var i = 1; i < ACL2List.length-1; i++){
		if (ACL2List[i][8] == "ss"){
		if (ACL2List[i][4] == "aes-256-cfb" || ACL2List[i][4] == "aes-128-cfb" || ACL2List[i][4] == "chacha20" || ACL2List[i][4] == "chacha20-ietf" || ACL2List[i][4] == "aes-256-gcm" || ACL2List[i][4] == "aes-128-gcm" || ACL2List[i][4] == "chacha20-poly1305" || ACL2List[i][4] == "chacha20-ietf-poly1305"){
		ACL2List[i][0] = base64decode(ACL2List[i][0]);
		ACL2List[i][3] = base64decode(ACL2List[i][3]);
		code +='<tr id="row2' + i + '">';
		code +='<td><a class="help_tooltip" href="javascript: void(0)" onmouseover="openToolss(this, ' + "'" + '服务器地址:' + ACL2List[i][1] + '<br/>端口:' + ACL2List[i][2]  + '<br/>密码:' + ACL2List[i][3]  + '<br/>加密方式:' + ACL2List[i][4]  + "'" + ');">' + ACL2List[i][0] + '</td>';
		code +='<td>&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][1] + '" ></td>';
		code +='<td>&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][2] + '" ></td>';
		code +='<td>&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][3] + '" ></td>';
		code +='<td><button class="btn-mini ' + ACL2List[i][5] + '" type="submit" >' + ACL2List[i][6] + '</button><input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][4] + '" ></td>';
		code += '<td width="10%"><button class="btn btn-success" type="submit" name="rt_ACL2List_s" onclick="return markGroupACL2(this, ' + i + ');" >应用</button></td>';
		code +='</tr>';
		}
		}
		}
	}
	}
	$j('#ACL2List_Block').append(code);
}

function showACL3List(){
	var code = '';
	var Norule_i = 1;
	if (typeof(ACL3List) != "undefined"){
		if(ACL3List.length > 0) {
			var Norule_i = 0;
		}
	}
	if (typeof(ACL4List) != "undefined"){
		if(ACL4List.length > 0) {
			var Norule_i = 0;
		}
	}
	if(Norule_i == 1){
		code +='<tr><td colspan="9" style="text-align: center;"><div class="alert alert-info"><#IPConnection_VSList_Norule#></div></td></tr>';
	}
	if (typeof(ACL3List) != "undefined"){
	if(ACL3List.length > 0) {
		for(var i = 0; i < ACL3List.length; i++){
		ACL3List[i][2] = base64decode(ACL3List[i][2]);
		code +='<tr id="row3' + i + '">';
		code +='<td><a class="help_tooltip" href="javascript: void(0)" onmouseover="openToolss(this, ' + "'" + 'v: ' + ACL3List[i][1]  + '<br/>ps: ' + ACL3List[i][2]  + '<br/>add: ' + ACL3List[i][3]  + '<br/>port: ' + ACL3List[i][4]  + '<br/>id: ' + ACL3List[i][5]  + '<br/>aid: ' + ACL3List[i][6]  + '<br/>net: ' + ACL3List[i][7]  + '<br/>type: ' + ACL3List[i][8]  + '<br/>host: ' + ACL3List[i][9]  + '<br/>path: ' + ACL3List[i][10]  + '<br/>tls: ' + ACL3List[i][11] + "'" + ');">' + ACL3List[i][2] + '</td>';
		code +='<td><button class="btn-mini ' + ACL3List[i][12] + '" type="submit" >' + ACL3List[i][13] + '</button><input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL3List[i][3] + '" ></td>';
		//code += '<td colspan="2">&nbsp;</td>'
		code +='<td>&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL3List[i][7] + '" ></td>';
		code +='<td>&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL3List[i][4] + '" ></td>';
		//code +='<td width="5%" style="text-align: center;"><input type="checkbox" name="rt_ACL3List_s" value="' + i + '" onClick="changeBgColor3(this,' + i + ');" id="check' + i + '"></td>';
		code += '<td width="10%"><button class="btn btn-success" type="submit" name="rt_ACL3List_s" onclick="return markGroupACL3(this, ' + i + ');" >应用</button></td>';
		code +='</tr>';
		}
	}
	}
	if (typeof(ACL4List) != "undefined"){
	if(ACL4List.length > 0) {
		for(var i = 0; i < ACL4List.length; i++){
		ACL4List[i][1] = base64decode(ACL4List[i][1]);
		ACL4List[i][4] = base64decode(ACL4List[i][4]);
		code +='<tr id="row4' + i + '">';
		code +='<td><a class="help_tooltip" href="javascript: void(0)" onmouseover="openToolss(this, ' + "'" + '服务器地址:' + ACL4List[i][2] + '<br/>端口:' + ACL4List[i][3]  + '<br/>密码:' + ACL4List[i][4]  + '<br/>加密方式:' + ACL4List[i][5]  + "'" + ');">' + ACL4List[i][1] + '</td>';
		code +='<td><button class="btn-mini ' + ACL4List[i][6] + '" type="submit" >' + ACL4List[i][7] + '</button><input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL4List[i][2] + '" ></td>';
		//code += '<td colspan="2">&nbsp;</td>'
		code +='<td>&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL4List[i][0] + '" ></td>';
		code +='<td>&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL4List[i][3] + '" ></td>';
		//code +='<td width="5%" style="text-align: center;"><input type="checkbox" name="rt_ACL4List_s" value="' + i + '" onClick="changeBgColor4(this,' + i + ');" id="check' + i + '"></td>';
		code += '<td width="10%"><button class="btn btn-success" type="submit" name="rt_ACL4List_s" onclick="return markGroupACL4(this, ' + i + ');" >应用</button></td>';
		code +='</tr>';
		}
	}
	}
	$j('#ACLList_Block').append(code);
}

function openToolss(obj, ss_server)
{
	$j(obj).attr('data-original-title', obj.innerHTML).attr('data-content', ss_server);
	$j(obj).popover('show');
}

//停止定时更新订阅
function click_app_67(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.app_67.value = v;
}
//停止ping订阅节点
function click_app_68(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.app_68.value = v;
	if(v == "1"){
		document.form.app_99.value = "0";
		document.form.app_99_fake.checked = false;
	}
}
//更新后自动选用节点
function click_app_99(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.app_99.value = v;
	if(v == "1"){
		document.form.app_68.value = "0";
		document.form.app_68_fake.checked = false;
	}
}
//默认排序节点
function click_app_100(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.app_100.value = v;
}
function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.v2ray_script.sh'], v);
	inputCtrl(document.form['scripts.v2ray_config_script.sh'], v);
	inputCtrl(document.form['scripts.app_25.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_v2ray.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function done_validating(action){
	refreshpage();
}

function change_v2ray_enable(mflag){
	var m = document.form.v2ray_enable.value;
	var is_v2ray_enable = (m == "1") ? "重启" : "更新";
	document.form.updatev2ray.value = is_v2ray_enable;
}

function change_v2ray_follow(mflag){
	var m = document.form.v2ray_follow[0].checked;
	showhide_div("ss_udp_enable_tr", m);
	showhide_div("app_114_tr", m);
	change_app_114_bridge();
}

function change_v2ray_http_enable(mflag){
	var m = document.form.v2ray_http_enable[0].checked;
	var mm = (m == "1") ? 0 : 1;
	showhide_div("app_default_config_tr", mm);
	showhide_div("v2ray_http_format_tr", m);
	showhide_div("v2ray_http_config_tr", m);
	showhide_div("v2ray_config_script_tr", mm);
	showhide_div("v2ray_config_script_2_tr", mm);
	showhide_div("v2ray_config_vmess1_tr", mm);
	showhide_div("v2ray_config_vmess2_tr", mm);
	showhide_div("ACLList_Block", mm);
	showhide_div("ACL2List_Block", mm);
	showhide_div("v2ray_config_vmess5_tr", mm);
}

function change_app_108_bridge(){
	var m = document.form.app_108.value;
	var m = (m == "1") ? 1 : 0;
		showhide_div("app_28_tr", m);
}
function change_app_114_bridge(){
	var m = document.form.app_114.value;
	var m = (m == "1") ? 0 : 1;
	var mm = document.form.v2ray_follow[0].checked;
	var m = (mm == "0") ? 0 : m;
	showhide_div("ss_keep_check_tr", m);
	showhide_div("ss_rebss_tr", m);
	showhide_div("ss_link_tr", m);
}
function button_updatev2ray(mflag){
	change_v2ray_enable(1);
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' updatev2ray ',
	});
}

function up_vmess_link(mflag){
	var vmess_link = document.form.app_66.value;
	if(vmess_link == ""){
		alert("填入订阅下载地址后，请按【应用保存设置】");
		return false;
	}
	var str = "你确定要执行 【更新订阅】 按钮功能吗？";
	if(confirm(str)){
		document.form.app_83.value = 'up_link';
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_Extensions_v2ray.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
	}
}

function del_vmess_link(mflag){
	var str = "你确定要执行 【清空订阅】 按钮功能吗？";
	if(confirm(str)){
		document.form.app_83.value = 'del_link';
	//	document.form.current_page.value = "/";
	//	document.form.next_page.value =  "";
		document.form.action_mode.value = " Apply ";
		parent.showLoading();

		document.form.submit();
	}
}

function ping_vmess_link(mflag){
	var str = "你确定要执行 【ping】 按钮功能吗？";
	if(confirm(str)){
		document.form.app_83.value = 'ping_link';
	//	document.form.current_page.value = "/";
	//	document.form.next_page.value =  "";
		document.form.action_mode.value = " Apply ";
		parent.showLoading();

		document.form.submit();
	}
}

function delval(id){
	var obj = $j('#'+id);
	var obj_icon = $j('#'+id+'_icon');
	var changeTo = (obj.attr('value') == '') ? '0' : '1';
	if (changeTo == 1){
		obj.attr('refresh' , obj.attr('value'));
		obj.attr('value' , '');
		obj_icon.attr('class' , 'icon-share-alt');
	}else{
		obj.attr('value' , obj.attr('refresh'));
		obj_icon.attr('class' , 'icon-trash');
	}
}

function get_ping(domain) {
	var ping_type = "";
	if (typeof(ping_data_all) != "undefined"){
		//var matchArr = ping_data_all.match('(?<=🔗' + domain + '=[^🔗]*)[^🔗\>]+');
		var matchArr = ping_data_all.match('🔗' + domain + '=[^🔗]+');
		if (!matchArr) {
			ping_type = "";
			return ping_type;
		}
		if (matchArr) {
			var matchArr2 = matchArr[0].split('=');
			if (typeof(matchArr2) != "undefined") {
				if (matchArr2.length > 1)
					ping_type = matchArr2[1];
				if (ping_type >= 1000) {
					ping_type = ">1000";
					return ping_type;
				}
			} 
		} else {
			ping_type = "";
			return ping_type;
		}
	}
	return ping_type;
}

function get_btn_type(ping_type) {
	var btn_type = "";
	if (ping_type >=0)
		btn_type = "btn-success";
	if (ping_type >= 250)
		btn_type = "btn-warning";
	if (ping_type >= 500)
		btn_type = "btn-danger";
	if (ping_type == ">1000")
		btn_type = "btn-danger";
	if (ping_type == "")
		btn_type = "";
	return btn_type;
}
function get_ACL3List(){
	var tmp_ACL3List_tmp = new Array();
	var tmp_ACL4List_tmp = new Array();
	ping_data_all = "";
	if (typeof(ping_data) != "undefined"){
		ping_data_all = ping_data_all + ping_data;
	}
	if (typeof(ping_data_3) != "undefined"){
		ping_data_all = ping_data_all + ping_data_3;
	}
	if (typeof(ping_data_4) != "undefined"){
		ping_data_all = ping_data_all + ping_data_4;
	}
	if (typeof(document.getElementById("app_25_txt").childNodes["0"]) != "undefined"){
	var link_txt = document.getElementById("app_25_txt").childNodes["0"].data;
	link_txt.trim().split('\n').forEach(function(v, i) {
		link_d(v);
		if (ss_type_d == "vmess"){
		var ACL3List_tmp = [ "vmess" ];
		ACL3List_tmp.push(app_71_d);
		ACL3List_tmp.push(app_72_d);
		ACL3List_tmp.push(app_73_d);
		ACL3List_tmp.push(app_74_d);
		ACL3List_tmp.push(app_75_d);
		ACL3List_tmp.push(app_76_d);
		ACL3List_tmp.push(app_77_d);
		ACL3List_tmp.push(app_78_d);
		ACL3List_tmp.push(app_79_d);
		ACL3List_tmp.push(app_80_d);
		ACL3List_tmp.push(app_81_d);
		var ping_type = get_ping(app_73_d);
		var btn_type = get_btn_type(ping_type);
		ACL3List_tmp.push(btn_type);
		ACL3List_tmp.push(ping_type + " ms");
		ACL3List_tmp.push("end");
		tmp_ACL3List_tmp.push(ACL3List_tmp);
		}
		if (ss_type_d == "ss" || ss_type_d == "ssr"){
		if (ssr_d_protocol == "origin" && ssr_d_obfs == "plain"){
		var ACL4List_tmp = [ 'ss' ];
		ACL4List_tmp.push(ss_name_d);
		ACL4List_tmp.push(ss_server_d);
		ACL4List_tmp.push(ss_port_d);
		ACL4List_tmp.push(ss_password_d);
		ACL4List_tmp.push(ss_method_d);
		var ping_type = get_ping(ss_server_d);
		var btn_type = get_btn_type(ping_type);
		ACL4List_tmp.push(btn_type);
		ACL4List_tmp.push(ping_type + " ms");
		ACL4List_tmp.push(ss_usage_d);
		ACL4List_tmp.push("0");
		ACL4List_tmp.push("end");
		tmp_ACL4List_tmp.push(ACL4List_tmp);
		}
		}
	})
	}
	if(document.form.app_100.value != 1){
		tmp_ACL3List_tmp.sort(function(a, b){
			if(a[2].indexOf('过期时间') != -1)
				return -1;
			if(a[2].indexOf('剩余流量') != -1)
				return -1;
			if(b[2].indexOf('过期时间') != -1)
				return 1;
			if(b[2].indexOf('剩余流量') != -1)
				return 1;
			return a[13].replace(' ms', '').replace('>', '') - b[13].replace(' ms', '').replace('>', '');
		});
		tmp_ACL4List_tmp.sort(function(a, b){
			if(a[1].indexOf('过期时间') != -1)
				return -1;
			if(a[1].indexOf('剩余流量') != -1)
				return -1;
			if(b[1].indexOf('过期时间') != -1)
				return 1;
			if(b[1].indexOf('剩余流量') != -1)
				return 1;
			return a[7].replace(' ms', '').replace('>', '') - b[7].replace(' ms', '').replace('>', '');
		});
	}
	if (typeof(ACL3List) == "undefined"){
		ACL3List = [];
	}
	if (typeof(ACL4List) == "undefined"){
		ACL4List = [];
	}
	ACL3List = ACL3List.concat(tmp_ACL3List_tmp);
	ACL4List = ACL4List.concat(tmp_ACL4List_tmp);
}

function get_ACL2List(){
	var tmp_ACL2List_tmp = new Array();
	ping_data_all = "";
	if (typeof(ping_data) != "undefined"){
		ping_data_all = ping_data_all + ping_data;
	}
	if (typeof(ping_data_3) != "undefined"){
		ping_data_all = ping_data_all + ping_data_3;
	}
	if (typeof(ping_data_4) != "undefined"){
		ping_data_all = ping_data_all + ping_data_4;
	}
	if (typeof(document.getElementById("app_24_txt").childNodes["0"]) != "undefined"){
	var link_txt = document.getElementById("app_24_txt").childNodes["0"].data;
	link_txt.trim().split('\n').forEach(function(v, i) {
		link_d(v);
		if (ss_type_d == "ss" || ss_type_d == "ssr"){
		if (ssr_d_protocol == "origin" && ssr_d_obfs == "plain"){
		var ACL2List_tmp = [ '🔗' + ss_name_d ];
		ACL2List_tmp.push(ss_server_d);
		ACL2List_tmp.push(ss_port_d);
		ACL2List_tmp.push(ss_password_d);
		ACL2List_tmp.push(ss_method_d);
		var ping_type = get_ping(ss_server_d);
		var btn_type = get_btn_type(ping_type);
		ACL2List_tmp.push(btn_type);
		ACL2List_tmp.push(ping_type + " ms");
		ACL2List_tmp.push(ss_usage_d);
		ACL2List_tmp.push("ss");
		ACL2List_tmp.push(i);
		tmp_ACL2List_tmp.push(ACL2List_tmp);
		}
		}
	})
	}
	if(document.form.app_100.value != 1){
		tmp_ACL2List_tmp.sort(function(a, b){
			if(a[0].indexOf('过期时间') != -1)
				return -1;
			if(a[0].indexOf('剩余流量') != -1)
				return -1;
			if(b[0].indexOf('过期时间') != -1)
				return 1;
			if(b[0].indexOf('剩余流量') != -1)
				return 1;
			return a[6].replace(' ms', '').replace('>', '') - b[6].replace(' ms', '').replace('>', '');
		});
	}
	if (typeof(ACL2List) != "undefined") {
		if(ACL2List.length > 1) {
		ACL2List.splice(ACL2List.length - 1, 1); 
		}else{
			ACL2List = [];
		}
	}else{
		ACL2List = [];
	}
	ACL2List = ACL2List.concat(tmp_ACL2List_tmp);
	ACL2List.push([]);
}

function addvmessLink(){
	var link = document.form.vmess_link.value;
	if(link.indexOf('ssr://') != -1){
		ss_name_d = '';
		ss_server_d = '';
		ss_port_d = '';
		ss_password_d = '';
		ss_method_d = '';
		ss_usage_d = '';
		link_d(link);if (ssr_d_protocol == "origin" && ssr_d_obfs == "plain"){
		if (ss_method_d == "aes-256-cfb" || ss_method_d == "aes-128-cfb" || ss_method_d == "chacha20" || ss_method_d == "chacha20-ietf" || ss_method_d == "aes-256-gcm" || ss_method_d == "aes-128-gcm" || ss_method_d == "chacha20-poly1305" || ss_method_d == "chacha20-ietf-poly1305"){
		document.form.app_72.value = ss_name_d;
		document.form.app_73.value = ss_server_d;
		document.form.app_74.value = ss_port_d;
		document.form.app_75.value = ss_password_d;
		document.form.app_78.value = ss_method_d;
		document.form.app_76.value = '';
		document.form.app_71.value = '';
		document.form.app_77.value = ss_usage_d;
		document.form.app_79.value = '0';
		document.form.app_80.value = '';
		document.form.app_81.value = '';
		document.form.app_82.value = 'ss';
		}else{
		alert('错误！链接的加密方式不兼容V2Ray');
		}
		}else{
		alert('错误！链接含 origin + plain 的ssr链接才能导入');
		}
		return;
	}
	else if(link.indexOf('vmess://') != -1){
		var decodeLink = Base64.decode(link.replace('vmess://', ''));
		var obj = JSON.parse(decodeLink);

		document.form.app_71.value = obj.v;
		document.form.app_72.value = obj.ps;
		document.form.app_73.value = obj.add;
		document.form.app_74.value = obj.port;
		document.form.app_75.value = obj.id;
		document.form.app_76.value = obj.aid;
		document.form.app_77.value = obj.net;
		document.form.app_78.value = obj.type;
		document.form.app_79.value = obj.host;
		document.form.app_80.value = obj.path;
		document.form.app_81.value = obj.tls;
		document.form.app_82.value = 'vmess';
		return;
	}
	else if(link.indexOf('ss://') != -1){
	if(link.indexOf('vmess://') == -1){
		ss_name_d = '';
		ss_server_d = '';
		ss_port_d = '';
		ss_password_d = '';
		ss_method_d = '';
		ss_usage_d = '';
		link_d(link);
		if (ss_method_d == "aes-256-cfb" || ss_method_d == "aes-128-cfb" || ss_method_d == "chacha20" || ss_method_d == "chacha20-ietf" || ss_method_d == "aes-256-gcm" || ss_method_d == "aes-128-gcm" || ss_method_d == "chacha20-poly1305" || ss_method_d == "chacha20-ietf-poly1305"){
		document.form.app_72.value = ss_name_d;
		document.form.app_73.value = ss_server_d;
		document.form.app_74.value = ss_port_d;
		document.form.app_75.value = ss_password_d;
		document.form.app_78.value = ss_method_d;
		document.form.app_76.value = '';
		document.form.app_71.value = '';
		document.form.app_77.value = ss_usage_d;
		document.form.app_79.value = '0';
		document.form.app_80.value = '';
		document.form.app_81.value = '';
		document.form.app_82.value = 'ss';
		}else{
		alert('错误！链接的加密方式不兼容V2Ray');
		}
		return;
	}
	}else{
		alert('无效链接');
	}
}

function heredoc(fn) {
	return fn.toString().split('\n').slice(1,-1).join('\n') + '\n'
}
function button_append_v2ray_config_script_code(){
	//var $j = jQuery.noConflict();
	var scripts_code = heredoc(function(){/*
<% nvram_dump("scripts.v2ray_config_script.sh",""); %>
*/});
	var code = '';
	code += '<td colspan="3" style="border-top: 0 none;" id="v2ray_config_script_code">';
	var codeId = document.getElementById("scripts.v2ray_config_script.sh");
	if (codeId == '' || codeId == undefined || codeId == null) {
	document.form.button_append_script_code.value = "点击按钮隐藏 V2Ray 配置（当前显示时保存设置时间随配置大小延长）";
	code +='<a><span>若文件太大建议直接修改 /etc/storage/v2ray_config_script.sh</span></a>';
	code +='<div id="v2ray_config_script">';
	code +='<textarea rows="18" wrap="off" spellcheck="false" maxlength="2097152" class="span12" id="scripts.v2ray_config_script.sh" name="scripts.v2ray_config_script.sh" style="font-family:\'Courier New\'; font-size:12px;">' + scripts_code + '</textarea>';
	code +='</div>';
	code +='</td>';
	}else{
	code +='</td>';
	document.form.button_append_script_code.value = "点击按钮显示 V2Ray 配置（当前隐藏时忽略 V2Ray 配置，能迅速保存设置）";
	}
	$j('#v2ray_config_script_code').replaceWith(code);
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

	<input type="hidden" name="current_page" value="Advanced_Extensions_v2ray.asp">
	<input type="hidden" name="next_page" value="">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="LANHostConfig;General;APP;">
	<input type="hidden" name="group_id" value="">
	<input type="hidden" name="action_mode" value="">
	<input type="hidden" name="action_script" value="">
	<input type="hidden" name="wan_ipaddr" value="<% nvram_get_x("", "wan0_ipaddr"); %>" readonly="1">
	<input type="hidden" name="wan_netmask" value="<% nvram_get_x("", "wan0_netmask"); %>" readonly="1">
	<input type="hidden" name="dhcp_start" value="<% nvram_get_x("", "dhcp_start"); %>">
	<input type="hidden" name="dhcp_end" value="<% nvram_get_x("", "dhcp_end"); %>">
	<input type="hidden" name="app_83" value="<% nvram_get_x("", "app_83"); %>" />
	<input type="hidden" name="app_67" value="<% nvram_get_x("", "app_67"); %>" />
	<input type="hidden" name="app_68" value="<% nvram_get_x("", "app_68"); %>" />
	<input type="hidden" name="app_100" value="<% nvram_get_x("", "app_100"); %>" />
	<input type="hidden" name="app_99" value="<% nvram_get_x("", "app_99"); %>" />

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
							<h2 class="box_head round_top">V2Ray proxy</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">欢迎使用 V2Ray 来连接世界的另一端。原生支持 Socks、HTTP、Shadowsocks、VMess 等协议。<div>上述协议均可使用 TLS、TCP、mKCP 等传输方式进行传输。</div><div>可以配合 Proxifier、chrome(switchysharp、SwitchyOmega) 代理插件使用。</div><div> <a href="https://www.v2fly.org/" target="blank">👉V2Ray 用户手册 </a> <a href="https://toutyrater.github.io/" target="blank"> 👉白话文版上手教程</a> <a href="https://tools.sprov.xyz/v2ray/" target="blank"> 👉服务器配置生成器</a></div><div><a href="https://github.com/v2fly/v2ray-core/" target="blank">👉项目地址: https://github.com/v2fly/v2ray-core </a> <a href="https://t.me/s/v2fly" target="blank"> 📢TG公告频道</a> <a href="https://t.me/v2fly_chat" target="blank"> 📝TG讨论组群</a>
									</div> <div>✨V2Ray服务端一键安装脚本：bash <(curl -L -s https://opt.cn2qq.com/opt-script/v2ray.sh)</div><span style="color:#FF0000;" class=""></span></div>

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;">开关</th>
										</tr>
										<tr>
											<th width="30%">V2Ray proxy 开关</th>
											<td>
													<div class="main_itoggle">
													<div id="v2ray_enable_on_of">
														<input type="checkbox" id="v2ray_enable_fake" <% nvram_match_x("", "v2ray_enable", "1", "value=1 checked"); %><% nvram_match_x("", "v2ray_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="v2ray_enable" id="v2ray_enable_1" class="input" value="1" onClick="change_v2ray_enable(1);" <% nvram_match_x("", "v2ray_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="v2ray_enable" id="v2ray_enable_0" class="input" value="0" onClick="change_v2ray_enable(1);" <% nvram_match_x("", "v2ray_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td colspan="1">
												<input class="btn btn-success" style="width:60px" type="button" name="updatev2ray" value="更新" onclick="button_updatev2ray(0)" />
												<span style="color:#888;">版本：<% nvram_get_x("","v2ray_v"); %></span>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border: 0 none;">开启透明代理(TCP)？</th>
											<td style="border: 0 none;">
													<div class="main_itoggle">
													<div id="v2ray_follow_on_of">
														<input type="checkbox" id="v2ray_follow_fake" <% nvram_match_x("", "v2ray_follow", "1", "value=1 checked"); %><% nvram_match_x("", "v2ray_follow", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="v2ray_follow" id="v2ray_follow_1" class="input" value="1" onClick="change_v2ray_follow(1);" <% nvram_match_x("", "v2ray_follow", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="v2ray_follow" id="v2ray_follow_0" class="input" value="0" onClick="change_v2ray_follow(1);" <% nvram_match_x("", "v2ray_follow", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td id="ss_matching_enable" style="border-top: 0 none;">
												<select name="ss_matching_enable">
													<option value="0" <% nvram_match_x("","ss_matching_enable", "0","selected"); %>>自动故障转移(透明代理时生效)</option>
													<option value="1" <% nvram_match_x("","ss_matching_enable", "1","selected"); %>>停用故障转移</option>
												</select>
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
												<select name="app_114" class="input" onChange="change_app_114_bridge();">
													<option value="0" <% nvram_match_x("","app_114", "0","selected"); %>>代理路由自身流量</option>
													<option value="1" <% nvram_match_x("","app_114", "1","selected"); %>>跳过代理路由自身流量</option>
												</select>
											</td>
										</tr>
										<tr style="display:none;">
											<th width="30%" style="border-top: 0 none;">工作模式</th>
											<td style="border-top: 0 none;">
												<select name="ss_mode_x" class="input">
													<option value="0" <% nvram_match_x("","ss_mode_x", "0","selected"); %>>【1】大陆白名单</option>
													<option value="1" <% nvram_match_x("","ss_mode_x", "1","selected"); %>>【2】gfwlist</option>
													<option value="2" <% nvram_match_x("","ss_mode_x", "2","selected"); %>>【3】全局代理</option>
													<option value="3" <% nvram_match_x("","ss_mode_x", "3","selected"); %>>【4】ss-local</option>
												</select>
											</td>
										</tr>
										<tr id="v2ray_path_tr" >
											<th style="border: 0 none;">主程序路径:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="512"  class="input" size="60" name="v2ray_path" placeholder="/opt/bin/v2ray" value="<% nvram_get_x("","v2ray_path"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="v2ray_door_tr" >
											<th style="border: 0 none;">透明代理端口:</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="512"  class="input" size="60" name="v2ray_door" placeholder="1099" value="<% nvram_get_x("","v2ray_door"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr id="v2ray_port_tr" >
											<th style="border: 0 none;">本地代理端口:</th>
											<td style="border: 0 none;">
												<input type="text" readonly="readonly" maxlength="512"  class="input" size="60" name="v2ray_port" placeholder="1088" value="<% nvram_get_x("","v2ray_port"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr>
											<th width="30%">透明代理路由规则使用方式:</th>
											<td colspan="4">
												<select name="app_108" class="input" style="width: 310px;" onChange="change_app_108_bridge();">
													<option value="0" <% nvram_match_x("","app_108", "0","selected"); %>>使用 V2Ray 内部分流路由规则</option>
													<option value="1" <% nvram_match_x("","app_108", "1","selected"); %>>使用 ss_tproxy 分流(降低负载，适合低配路由)</option>
												</select>
											</td>
										</tr>
										<tr id="app_28_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;">工作模式</th>
											<td style="border-top: 0 none;">
												<select name="app_28" class="input">
													<option value="0" <% nvram_match_x("","app_28", "0","selected"); %>>【1】大陆白名单</option>
													<option value="1" <% nvram_match_x("","app_28", "1","selected"); %>>【2】gfwlist</option>
													<option value="2" <% nvram_match_x("","app_28", "2","selected"); %>>【3】全局代理</option>
													<option value="3" <% nvram_match_x("","app_28", "3","selected"); %>>【4】回国模式</option>
												</select>
											</td>
										</tr>
										<tr id="ss_keep_check_tr" style="display:none;">
											<th width="30%">检查 V2Ray 服务器状态</th>
											<td colspan="2">
													<div class="main_itoggle">
													<div id="ss_keep_check_on_of">
														<input type="checkbox" id="ss_keep_check_fake" <% nvram_match_x("", "ss_keep_check", "1", "value=1 checked"); %><% nvram_match_x("", "ss_keep_check", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_keep_check" id="ss_keep_check_1" class="input" value="1" <% nvram_match_x("", "ss_keep_check", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_keep_check" id="ss_keep_check_0" class="input" value="0" <% nvram_match_x("", "ss_keep_check", "0", "checked"); %> /><#checkbox_No#>
												</div>
												&nbsp;<span style="color:#888;">运行时持续检测</span>
											</td>
										</tr>
										<tr id="ss_rebss_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;">多次检测断线后执行</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="512" class="input" size="15" name="ss_rebss_n" placeholder="0" value="<% nvram_get_x("","ss_rebss_n"); %>" onKeyPress="return is_number(this,event);"/>
												<div><span style="color:#888;">最大断线次数，[0]不执行</span></div>
											</td>
											<td style="border-top: 0 none;">
												<select name="ss_rebss_a" class="input">
													<option value="0" <% nvram_match_x("","ss_rebss_a", "0","selected"); %>>重启V2Ray</option>
													<option value="1" <% nvram_match_x("","ss_rebss_a", "1","selected"); %>>停止V2Ray</option>
													<option value="2" <% nvram_match_x("","ss_rebss_a", "2","selected"); %>>重启路由</option>
													<option value="3" <% nvram_match_x("","ss_rebss_a", "3","selected"); %>>更新订阅</option>
												</select>
												<div><span style="color:#888;">检测断线 [<% nvram_get_x("", "ss_rebss_b"); %>] 次，大于 [<% nvram_get_x("", "ss_rebss_n"); %>] 次后执行</span></div>
											</td>
										</tr>
										<tr id="ss_link_tr" style="display:none;">
											<th style="border-top: 0 none;">连接检测的域名:</th>
											<td style="border-top: 0 none;" colspan="1">
												<input type="text" maxlength="512" class="input" size="15" name="ss_link_2" placeholder="www.google.com.hk" value="<% nvram_get_x("","ss_link_2"); %>" onKeyPress="return is_string(this,event);"/>
												&nbsp;<span style="color:#888;">谷歌网站，若是回国模式需要更换</span>
											</td>
											<td style="border-top: 0 none;" colspan="1">
												<input type="text" maxlength="512" class="input" size="15" name="ss_link_1" placeholder="88" value="<% nvram_get_x("","ss_link_1"); %>" onKeyPress="return is_number(this,event);"/>
												&nbsp;<span style="color:#888;">检测间隔时间：秒(s)</span>
											</td>
										</tr>
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;" >启动前运行的脚本</th>
										</tr>
										<tr id="v2ray_script" colspan="4">
											<td colspan="4" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script12')"><span>v2ray_script</span><div>&nbsp;<span style="color:#888;">查看以下文件修改 V2Ray 启动前运行的脚本。</span></div></a>
												<div id="script12" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.v2ray_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.v2ray_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;" >V2Ray 配置文件</th>
										</tr>
										<tr>
											<th width="30%" style="border: 0 none;">http(s)读取配置？</th>
											<td style="border: 0 none;">
													<div class="main_itoggle">
													<div id="v2ray_http_enable_on_of">
														<input type="checkbox" id="v2ray_http_enable_fake" <% nvram_match_x("", "v2ray_http_enable", "1", "value=1 checked"); %><% nvram_match_x("", "v2ray_http_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="v2ray_http_enable" id="v2ray_http_enable_1" class="input" value="1" onClick="change_v2ray_http_enable(1);" <% nvram_match_x("", "v2ray_http_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="v2ray_http_enable" id="v2ray_http_enable_0" class="input" value="0" onClick="change_v2ray_http_enable(1);" <% nvram_match_x("", "v2ray_http_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="app_default_config_tr" style="display:none;">
											<th style="border-top: 0 none;">不改写配置直接启动？</th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="app_115_on_of">
														<input type="checkbox" id="app_115_fake" <% nvram_match_x("", "app_115", "1", "value=1 checked"); %><% nvram_match_x("", "app_115", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="app_115" id="app_115_1" class="input" value="1" <% nvram_match_x("", "app_115", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="app_115" id="app_115_0" class="input" value="0" <% nvram_match_x("", "app_115", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td  colspan="2" style="border-top: 0 none;">
												<span style="color:#888;">有可能端口不匹配导致功能失效</span>
											</td>
										</tr>
										<tr id="v2ray_http_format_tr" style="display:none;">
											<th width="30%" style="border-top: 0 none;">配置文件格式</th>
											<td style="border-top: 0 none;">
												<select name="v2ray_http_format" class="input">
													<option value="1" <% nvram_match_x("","v2ray_http_format", "1","selected"); %>>JSON 格式</option>
													<option value="2" <% nvram_match_x("","v2ray_http_format", "2","selected"); %>>Protobuf 格式</option>
												</select>
											</td>
										</tr>
										<tr id="v2ray_http_config_tr" style="display:none;">
											<th style="border: 0 none;">加载配置远程地址</th>
											<td style="border: 0 none;">
												<input type="text" maxlength="5120"  class="input" size="60" name="v2ray_http_config" placeholder="https://www.v2fly.org/v2ray.json" value="<% nvram_get_x("","v2ray_http_config"); %>" onKeyPress="return is_string(this,event);" />
												<span style="color:#888;">以http://或https://开头(小写)</span>
											</td>
										<tr id="v2ray_config_script_tr" colspan="4" style="display:none;">
											<td style="border-top: 0 none;" colspan="4">
												<i class="icon-hand-right"></i><input class="btn btn-primary" style="" type="button" name="button_append_script_code"  value="点击按钮显示 V2Ray 配置（当前隐藏时忽略 V2Ray 配置，能迅速保存设置）" onclick="button_append_v2ray_config_script_code()" tabindex="24">
											</td>
										</tr>
										<tr id="v2ray_config_script_2_tr" colspan="4" style="display:none;">
											<td colspan="4" style="border-top: 0 none;" id="v2ray_config_script_code">
											</td>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<td colspan="4" style="border-top: 0 none;">
												<br />
												<center><input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" /></center>
											</td>
										</tr>
									</table>
									<table id="v2ray_config_vmess1_tr" style="display:none;" width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
										<tr>
											<th colspan="4" style="background-color: #E3E3E3;" >V2Ray 订阅链接</th>
										</tr>
										<tr>
											<th style="border-top: 0 none;padding-bottom: 0px;border-top-width: 0px;">匹配关键词节点故障转移:</th>
											<td cellpadding="3" style="border-top: 0 none;padding-bottom: 0px;border-top-width: 0px;">
											<input type="text" maxlength="512" class="input" size="15" id="app_95" name="app_95" placeholder="留空停用,填[|]分割关键词,填[.]全选" value="<% nvram_get_x("","app_95"); %>" onKeyPress="return is_string(this,event);" />&nbsp;<span style="color:#888;">对节点名称有效，支持<a href="https://www.runoob.com/regexp/regexp-syntax.html" target="blank_regexp">正则表达式</a></span>
											</td>
										</tr>
										<tr>
											<th style="border-top: 0 none;padding-bottom: 0px;border-top-width: 0px;">排除关键词节点故障转移:</th>
											<td cellpadding="3" style="border-top: 0 none;padding-bottom: 0px;border-top-width: 0px;">
											<input type="text" maxlength="512" class="input" size="15" id="app_96" name="app_96" placeholder="留空则只使用上行的匹配关键词" value="<% nvram_get_x("","app_96"); %>" onKeyPress="return is_string(this,event);" />&nbsp;<span style="color:#888;">优选低延迟，支持<a href="https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Regular_Expressions" target="blank_Regular">正则表达式</a></span>
											</td>
										</tr>
										<tr>
											<th>当前使用服务器节点:</th>
											<th><input style="width: 365px; background-color: #ffd;" type="text" maxlength="512" class="input" size="15" id="app_98" name="app_98" value="<% nvram_get_x("","app_98"); %>" onKeyPress="return is_string(this,event);" /></th>
										</tr>
										<tr>
											<th>服务器订阅节点: <input class="btn btn-success" type="button" name="vmess_ping" id="vmess_ping" value="ping" onclick="ping_vmess_link(3);"><DIV>(vmess://、ss://、ssd://)</DIV></th>
											<td cellpadding="3">
												<input type="text" style="width: 220px;" maxlength="1024" class="input" size="15" id="app_66" name="app_66" placeholder=" https://www.123.com/vmess_link.txt"  value="<% nvram_get_x("","app_66"); %>" onKeyPress="return is_string(this,event);" />
												<button style="margin-left: -5px;" class="btn" type="button" onclick="delval('app_66')"><i class="icon-trash" name="app_66_icon" id="app_66_icon"></i></button>
												<input class="btn btn-info" type="button" name="vmess_up" id="vmess_up" value="更新" onclick="up_vmess_link(1);">
												<input class="btn btn-danger" type="button" name="vmess_del" id="vmess_del" value="清空订阅" onclick="del_vmess_link(2);">
												<div>
												<label id="app_67_tr" class="checkbox inline"><input type="checkbox" name="app_67_fake" value="" style="margin-left:10;" onclick="click_app_67(this);" <% nvram_match_x("", "app_67", "1", "checked"); %>/>停止定时更新</label>
												<label id="app_68_tr" class="checkbox inline"><input type="checkbox" name="app_68_fake" value="" style="margin-left:10;" onclick="click_app_68(this);" <% nvram_match_x("", "app_68", "1", "checked"); %>/>停止ping</label>
												<label id="app_100_tr" class="checkbox inline"><input type="checkbox" name="app_100_fake" value="" style="margin-left:10;" onclick="click_app_100(this);" <% nvram_match_x("", "app_100", "1", "checked"); %>/>停止排序节点</label>
												<label id="app_99_tr" class="checkbox inline"><input type="checkbox" name="app_99_fake" value="" style="margin-left:10;" onclick="click_app_99(this);" <% nvram_match_x("", "app_99", "1", "checked"); %>/>更新后优选匹配</label>
												</div>
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;">链接导入单节点:(<a href="https://github.com/2dust/v2rayN/wiki/%E5%88%86%E4%BA%AB%E9%93%BE%E6%8E%A5%E6%A0%BC%E5%BC%8F%E8%AF%B4%E6%98%8E(ver-2)" target="blank_vmess">vmess://</a>、<a href="https://shadowsocks.org/en/spec/SIP002-URI-Scheme.html" target="blank_ss">ss://</a>)</th>
											<td cellpadding="3" style="border: 0 none;">
												<input type="text" style="width: 220px;" maxlength="1024" class="input" size="15" id="vmess_link" name="vmess_link" placeholder="vmess://base64" value="" refresh="" onKeyPress="return is_string(this,event);" />
												<button style="margin-left: -5px;" class="btn" type="button" onclick="delval('vmess_link')"><i class="icon-trash" name="vmess_link_icon" id="vmess_link_icon"></i></button>
												<input class="btn btn-info" type="button" name="ssr_ss" id="ssr_ss" value="导入" onclick="addvmessLink();">
											</td>
										</tr>
										<tr>
											<td colspan="3" style="display:none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('app_24')"><span>批量导入链接节点</span></a>
												<div id="app_24" style="display:none;">
													<textarea id="app_24_txt" rows="10" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.app_24.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.app_24.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('app_25')"><span>批量导入链接节点(vmess://、ss://)</span></a>
												<div id="app_25" style="display:none;">
													<textarea id="app_25_txt" rows="10" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.app_25.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.app_25.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th>透明代理方案(更换需重新生成)</a></th>
											<td  colspan="3">
												<select name="app_69" class="input" style="width: 100%;">
													<option value="0" <% nvram_match_x("","app_69", "0","selected"); %>>方案一chnroutes，国外IP走代理</option>
													<option value="1" <% nvram_match_x("","app_69", "1","selected"); %>>方案二gfwlist（推荐），只有被墙的站点IP走代理</option>
													<option value="2" <% nvram_match_x("","app_69", "2","selected"); %>>方案三全局代理，全部IP走代理</option>
													<option value="3" <% nvram_match_x("","app_69", "3","selected"); %>>方案四回国模式，国内IP走代理</option>
												</select>
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;">本地代理方案(更换需重新生成)</a></th>
											<td  colspan="3" style="border: 0 none;">
												<select name="app_70" class="input" style="width: 100%;">
													<option value="0" <% nvram_match_x("","app_70", "0","selected"); %>>同上选项透明代理方案</option>
													<option value="1" <% nvram_match_x("","app_70", "1","selected"); %>>全局代理，全部走代理</option>
												</select>
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;">使用 V2Ray 的内置 DNS 服务？</a></th>
											<td  colspan="3" style="border: 0 none;">
												<select name="app_105" class="input" style="width: 100%;">
													<option value="0" <% nvram_match_x("","app_105", "0","selected"); %>>不使用</option>
													<option value="1" <% nvram_match_x("","app_105", "1","selected"); %>>启用，监听 8053 端口</option>
												</select>
											</td>
										</tr>
									</table>
									<table id="v2ray_config_vmess2_tr" style="display:none;" width="100%" align="center" cellpadding="6" cellspacing="0" class="table">
										<tr>
											<th>v:</th>
											<td>
												<input style="width: 120px" type="text" maxlength="512"  class="input" size="60" name="app_71" placeholder="2" value="<% nvram_get_x("","app_71"); %>" onKeyPress="return is_string(this,event);" />
											</td>
											<th>ps:</th>
											<td>
												<input style="width: 120px" type="text" maxlength="512"  class="input" size="60" name="app_72" placeholder="备注别名" value="<% nvram_get_x("","app_72"); %>" onKeyPress="return is_string(this,event);" />
											</td>
											<th>add:</th>
											<td>
												<input style="width: 120px" type="text" maxlength="512"  class="input" size="60" name="app_73" placeholder="111.111.111.111" value="<% nvram_get_x("","app_73"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;">port:</th>
											<td style="border: 0 none;">
												<input style="width: 120px" type="text" maxlength="5"  class="input" size="60" name="app_74" placeholder="32000" value="<% nvram_get_x("","app_74"); %>" onKeyPress="return is_number(this,event);" />
											</td>
											<th style="border: 0 none;">id:</th>
											<td style="border: 0 none;">
												<input style="width: 85px" type="password" maxlength="512"  class="input" size="60" name="app_75" id="app_75" placeholder="1386f85e-657b-4d6e-9d56-78badb75e1fd" value="<% nvram_get_x("","app_75"); %>" onKeyPress="return is_string(this,event);" />
												<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('app_75')"><i class="icon-eye-close"></i></button>
											</td>
											<th style="border: 0 none;">aid:</th>
											<td style="border: 0 none;">
												<input style="width: 120px" type="text" maxlength="5"  class="input" size="60" name="app_76" placeholder="100" value="<% nvram_get_x("","app_76"); %>" onKeyPress="return is_number(this,event);" />
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;">net:</th>
											<td style="border: 0 none;">
												<input style="width: 120px" type="text" maxlength="512"  class="input" size="60" name="app_77" placeholder="tcp" value="<% nvram_get_x("","app_77"); %>" onKeyPress="return is_string(this,event);" />
											</td>
											<th style="border: 0 none;">type:</th>
											<td style="border: 0 none;">
												<input style="width: 120px" type="text" maxlength="512"  class="input" size="60" name="app_78" placeholder="none" value="<% nvram_get_x("","app_78"); %>" onKeyPress="return is_string(this,event);" />
											</td>
											<th style="border: 0 none;">host:</th>
											<td style="border: 0 none;">
												<input style="width: 120px" type="text" maxlength="512"  class="input" size="60" name="app_79" placeholder="www.baidu.com" value="<% nvram_get_x("","app_79"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
										<tr>
											<th style="border: 0 none;">path:</th>
											<td style="border: 0 none;">
												<input style="width: 120px" type="text" maxlength="512"  class="input" size="60" name="app_80" placeholder="/" value="<% nvram_get_x("","app_80"); %>" onKeyPress="return is_string(this,event);" />
											</td>
											<th style="border: 0 none;">tls:</th>
											<td style="border: 0 none;">
												<input style="width: 120px" type="text" maxlength="512"  class="input" size="60" name="app_81" placeholder="tls" value="<% nvram_get_x("","app_81"); %>" onKeyPress="return is_string(this,event);" />
											</td>
											<th style="border: 0 none; color:#FF0000;">json:</th>
											<td style="border-top: 0 none;">
												<select style="width: 130px;" name="app_82" id="app_82" class="input">
													<option value="0" <% nvram_match_x("","app_82", "0","selected"); %>>不生成配置</option>
													<option value="vmess" <% nvram_match_x("","app_82", "vmess","selected"); %>>生成vmess配置</option>
													<option value="ss" <% nvram_match_x("","app_82", "ss","selected"); %>>生成ss配置</option>
												</select>
											</td>
										</tr>
									</table>
									<table style="display:none;" width="100%" align="center" cellpadding="5" cellspacing="0" class="table table-list" id="ACLList_Block">
										<tr>
											<th>V2Ray 节点名称</th>
											<th>服务器地址</th>
											<th width="10%">传输协议</th>
											<th width="10%">端口</th>
											<th width="1%">&nbsp;</th>
										</tr>
									</table>
									
									<table style="display:none;" width="100%" align="center" cellpadding="6" cellspacing="0" class="table table-list" id="ACL2List_Block">
										<tr>
											<th width="25%">SS 节点名称</th>
											<th width="13%">服务器地址</th>
											<th width="10%">端口</th>
											<th width="10%">密码</th>
											<th width="14%"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openToolss(this, '可用的加密方式列表:<br/>aes-256-cfb<br/>aes-128-cfb<br/>chacha20<br/>chacha20-ietf<br/>aes-256-gcm<br/>aes-128-gcm<br/>chacha20-poly1305 或 chacha20-ietf-poly1305');">加密方式</th>
											<th width="1%"><a href="https://www.v2fly.org/chapter_02/protocols/shadowsocks.html#encryption-list" target="blank">👉说明</a></th>
										</tr>
									</table>
									<table id="v2ray_config_vmess5_tr" style="display:none;" width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
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

