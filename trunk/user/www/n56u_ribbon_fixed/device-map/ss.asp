<!DOCTYPE html>
<html>
<head>
<title></title>
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
<script type="text/javascript" src="/wireless.js"></script>
<script type="text/javascript" src="/wireless_2g.js"></script>
<script type="text/javascript" src="/help_wl.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="formcontrol.js"></script>
<script type="text/javascript" src="/client_function.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script type="text/javascript" src="/link/link.js"></script>
<script type="text/javascript" src="/link_d.js"></script>
<script type="text/javascript" src="/link/ping.js"></script>
<script>
var $j = jQuery.noConflict();

$j(document).ready(function() {
	init_itoggle('ss_enable');
});

</script>
<script>

<% login_state_hook(); %>

function initial(){

	document.form.rt_ssnum_x_tmp.value = document.form.ssr_link.value;
	document.getElementById("ss_method").options[0].text = '<% nvram_get_x("", "ss_method"); %>';
	document.getElementById("ss_method").options[0].value = '<% nvram_get_x("", "ss_method"); %>';
	document.getElementById("rt_ss_method_x_0").options[0].text = '<% nvram_get_x("", "rt_ss_method_x_0"); %>';
	document.getElementById("rt_ss_method_x_0").options[0].value = '<% nvram_get_x("", "rt_ss_method_x_0"); %>';
	set_wan();
	get_ACL2List();
	showACL2List();
	click_change_ss_method2();
	//document.form.ssr_type_protocol.value = "";
	//document.form.ssr_type_obfs.value = "";
	if (!login_safe())
		textarea_scripts_enabled(0);
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.app_24.sh'], v);
}

function getHashId(){
	var curHash = window.location.hash;
	if (curHash == '')
		curHash = '#0';
	var id = parseInt(curHash.replace('#', '0'));
	if (isNaN(id))
		return 0;
	return id;
}

function set_wan(){
	var wan_proto_id = getHashId();
	if(wan_proto_id == "1"){
	document.form.current_page.value = "/Advanced_Extensions_SS_list.asp";
	document.form.next_page.value = "";
	} else{
	document.form.current_page.value = "/";
	document.form.next_page.value = "device-map/ss.asp";
	
	}
}
function applyRule(){
	if (document.form.app_95.value == ""){
		document.form.ss_matching_enable.value = "1";
	} else{
		document.form.ss_matching_enable.value = "0";
	}
//	document.form.current_page.value = "/";
//	document.form.next_page.value =  "";
	document.form.action_mode.value = " Apply ";
	parent.showLoading();

	document.form.submit();
}




function add_del_link(o, b) {
	pageChanged = 0;
	document.form.current_page.value = "Advanced_Extensions_SS_list.asp";
	document.form.action_mode.value = b;
	return true;
}


function markGroupACL2(o, c, b) {
	if(b == " ASS "){
			var rusult=999;
			if(c == 1){
				rusult=document.form.app_97_select.value;
			}
			if(c == 999){
			var check_array=document.getElementsByName("rt_ACL2List_s");
			for(var i=0;i<check_array.length;i++)
			{
				if(check_array[i].checked==true)
				{
					rusult=parseInt(check_array[i].value);
					check_array[i].checked = false;
					changeBgColor1(i + 1);
					i = check_array.length
				}
			}
			}
			if(rusult < 999&&rusult > 0)
			{
			document.form.app_97.value ="[" + ACL2List[rusult][8] + "]" + ACL2List[rusult][0];
			document.form.ss_server.value = ACL2List[rusult][1];
			document.form.ss_server_port.value = ACL2List[rusult][2];
			document.form.ss_key.value = ACL2List[rusult][3];
			document.form.ss_method.value = ACL2List[rusult][4];
			document.getElementById("ss_method").options[0].text = ACL2List[rusult][4];
			document.getElementById("ss_method").options[0].value = ACL2List[rusult][4];
			document.getElementById("ss_method").options[0].selected = true;
			document.form.ss_usage.value = ACL2List[rusult][7];
			document.form.ss_type.value = (ACL2List[rusult][8] == "ssr") ? "1" : "0";
			if(document.form.ss_type.value == "0")
				document.getElementById("ss_type").options[0].selected = true;
			if(document.form.ss_type.value == "1")
				document.getElementById("ss_type").options[1].selected = true;
			}
			return false;
	}
	
	return true;
}

function showACL2List(){
	var code = '';
	var code2 = '';
	var Norule_i = 1;
	if (typeof(ACL2List) != "undefined"){
		if(ACL2List.length > 2) {
			var Norule_i = 0;
		}
	}
	if(Norule_i == 1){
		code +='<tr><td colspan="9" style="text-align: center;"><div class="alert alert-info"><#IPConnection_VSList_Norule#> <input class="btn btn-danger" type="button" name="ssr_ss" id="ssr_ss" value="重置订阅文件" onclick="clean_ssr_link();"></div></td></tr>';
	}
	if (typeof(ACL2List) != "undefined"){
	if(ACL2List.length > 2) {
		for(var i = 1; i < ACL2List.length -1; i++){
		if (typeof(ACL2List[i][0]) != "undefined"){
		ACL2List[i][0] = base64decode(ACL2List[i][0]);
		ACL2List[i][3] = base64decode(ACL2List[i][3]);
		ACL2List[i][7] = base64decode(ACL2List[i][7]);
		code +='<tr id="row2' + i + '">';
		code +='<td width="22%" style="padding-right: 0px; padding-left: 0px;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openToolss(this, ' + "'" + '服务器地址:' + ACL2List[i][1] + '<br/>端口:' + ACL2List[i][2]  + '<br/>密码:' + ACL2List[i][3]  + '<br/>加密方式:' + ACL2List[i][4]  + '<br/>协议混淆:' + ACL2List[i][7]  + "'" + ');">' + ACL2List[i][0] + '</td>';
		code +='<td width="13%" style="padding-right: 0px;">&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][1] + '" ></td>';
		code +='<td width="10%" style="padding-right: 0px;">&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][2] + '" ></td>';
		code +='<td width="11%" style="padding-right: 0px;">&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][3] + '" ></td>';
		//code +='<td>&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][4] + '" ></td>';
		code +='<td width="14%" style="padding-right: 0px;"><button class="btn-mini ' + ACL2List[i][5] + '" type="submit" >' + ACL2List[i][6] + '</button><input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][4] + '" ></td>';
		//code += '<td colspan="2">&nbsp;</td>'
		code +='<td width="13%" style="padding-right: 0px;">&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][7] + '" ></td>';
		code +='<td style="display:none;">&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][8] + '" ></td>';
		code +='<td style="display:none;">&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][5] + '" ></td>';
		code +='<td style="display:none;">&nbsp;<input type="text" maxlength="512" class="span12" size="32" readonly="readonly" value="' + ACL2List[i][6] + '" ></td>';
		if (typeof(ACL2List[i][9]) == "undefined"){
		code +='<td width="5%" style="text-align: center;"><input type="checkbox" name="rt_ACL2List_s" value="' + i + '" onClick="changeBgColor2(this,' + i + ');" id="check' + i + '"></td>';
		}else{
		code +='<td width="5%" style="text-align: center;"><input type="checkbox" name="rt_ACL2List_s" value="' + i + '" onClick="changeBgColor3(this,' + i + ' ,' + ACL2List[i][9] + ');" id="check' + i + '"></td>';
		}
		code +='</tr>';
		}
		}
		code += '<tr>';
		code += '<td colspan="3">&nbsp;</td>'
		code += '<td colspan="3"><button class="btn btn-success" type="submit" onclick="return markGroupACL2(this, 999, \' ASS \');" name="rt_ACLList3">🔗应用主SS</button></td>';
		code += '<td><button class="btn btn-danger" type="submit" onclick="return add_del_link(this, \' dellink \');" name="rt_ACLList"><i class="icon icon-minus icon-white"></i></button></td>';
		code += '</tr>'
	}
	if(ACL2List.length > 2) {
		code2 += '<tr><th style="border-top: 0 none;">选用节点:</th><td style="border-top: 0 none;">'
		code2 += '<select style="width: 400px;" name="app_97_select" id="app_97_select" class="input" onChange="return markGroupACL2(this, 1, \' ASS \');">'
		code2 += '<option value="0" >选[主用]服务器后点击[应用]生效</option>'
		for(var i = 1; i < ACL2List.length -1; i++){
		if (typeof(ACL2List[i][0]) != "undefined"){
		code2 += '<option value="' + i + '" >' + padding2(padding(ACL2List[i][6],7),7) + padding2(padding('[' + ACL2List[i][8] + ']',5),5) + ACL2List[i][0] + '</option>'
		}
		}
		code2 += '</select></td></tr>';
	}
	}
	$j('#ACLList_Block').append(code);
	$j('#ACLList_Block2').append(code2);
}
function padding(num, length) {
	return (Array(length).join("") + num).slice(-length);
}
function padding2(num, length) {
	var len = (num + "").length -1;
	var diff = length - len;
	if(diff > 0) {
		return Array(diff).join("&ensp;") + num;
	}
	return num;
}
function openToolss(obj, ss_server)
{
	$j(obj).attr('data-original-title', obj.innerHTML).attr('data-content', ss_server);
	$j(obj).popover('show');
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
function del_ssr_ss_link(){
	document.form.rt_ss_name_x_0.value = '';
	document.form.rt_ss_server_x_0.value = '';
	document.form.rt_ss_port_x_0.value = '';
	document.form.rt_ss_password_x_0.value = '';
	document.form.rt_ss_method_x_0.value = '';
	document.form.rt_ss_usage_x_0.value = '';
	applyRule();
}
function up_ssr_link(){
	document.form.rt_ssnum_x_tmp.value = document.form.ssr_link.value;
	var ssr_link_tmp = document.form.rt_ssnum_x_tmp.value;
	if(ssr_link_tmp == ""){
		alert("填入订阅下载地址后，请按【应用保存设置】");
		return false;
	}
	var str = "你确定要执行 【更新订阅】 按钮功能吗？";
	if(confirm(str)){
		var d = new Date();
		document.form.ss_link_status.value = d;
	//	document.form.current_page.value = "/";
	//	document.form.next_page.value =  "";
		document.form.action_mode.value = " Apply ";
		parent.showLoading();

		document.form.submit();
	}
}

function del_ssr_link(){
	var str = "你确定要执行 【清空🔗订阅】 按钮功能吗？";
	if(confirm(str)){
		document.form.rt_ssnum_x_tmp.value = "del";
	//	document.form.current_page.value = "/";
	//	document.form.next_page.value =  "";
		document.form.action_mode.value = " Apply ";
		parent.showLoading();

		document.form.submit();
	}
}
function clean_ssr_link(){
	var str = "你确定要执行 【重置订阅文件】 按钮功能吗？";
	if(confirm(str)){
		document.form.rt_ssnum_x_tmp.value = "clean";
	//	document.form.current_page.value = "/";
	//	document.form.next_page.value =  "";
		document.form.action_mode.value = " Apply ";
		parent.showLoading();

		document.form.submit();
	}
}

//同时启用ss-local
function click_run_ss_local(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.ss_run_ss_local.value = v;
}
//停止定时更新订阅
function click_ss_link_up(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.ss_link_up.value = v;
}
//停止ping订阅节点
function click_ss_link_ping(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.ss_link_ping.value = v;
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
		document.form.ss_link_ping.value = "0";
		document.form.ss_link_ping_fake.checked = false;
	}
}
//默认排序节点
function click_app_100(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.app_100.value = v;
}

function changeBgColor1(num){
	$("row2" + num).style.background='whiteSmoke';
}
function changeBgColor2(obj, num){
	$("row2" + num).style.background=(obj.checked)?'#D9EDF7':'whiteSmoke';
	var v = (obj.checked) ? "1" : "0";
	var num = num + 1;
	var num_v = ' _' + String(num) + '_';
	if(v == "1"){
		document.form.row_id_x_0.value = document.form.row_id_x_0.value + num_v;
		
	} else {
		document.form.row_id_x_0.value = document.form.row_id_x_0.value.replace(num_v, '');
	}
	//alert(document.form.row_id_x_0.value);
	
}
function changeBgColor3(obj, num, num_a){
	$("row2" + num).style.background=(obj.checked)?'#D9EDF7':'whiteSmoke';
	var v = (obj.checked) ? "1" : "0";
	var num_a = num_a + 1;
	var num_v = ' _A' + String(num_a) + '_';
	if(v == "1"){
		document.form.row_id_x_0.value = document.form.row_id_x_0.value + num_v;
		
	} else {
		document.form.row_id_x_0.value = document.form.row_id_x_0.value.replace(num_v, '');
	}
	//alert(document.form.row_id_x_0.value);
	
}

function done_validating(action){
	refreshpage();
}
function button_updatess(){
	var str = "你确定要执行 重启 按钮功能吗？";
	if(confirm(str)){
	
	var $j = jQuery.noConflict();
	parent.showLoading();
	$j.post('/apply.cgi',
	{
		'action_mode': ' updatess ',
	});
//	document.form.current_page.value = "/";
//	document.form.next_page.value = "";
	document.form.action_mode.value = " Apply ";
	
	
	document.form.submit();
	}
}
function button_matching(){
	var str = "你确定要执行 自动选用节点 按钮功能吗？";
	if(confirm(str)){
	
	var $j = jQuery.noConflict();
	parent.showLoading();
	$j.post('/apply.cgi',
	{
		'action_mode': ' button_matching ',
	});
//	document.form.current_page.value = "/";
//	document.form.next_page.value = "";
	document.form.action_mode.value = " Apply ";
	
	
	document.form.submit();
	}
}
function button_ping(){
	var str = "你确定要执行 ping 按钮功能吗？";
	if(confirm(str)){
	
	var $j = jQuery.noConflict();
	parent.showLoading();
	$j.post('/apply.cgi',
	{
		'action_mode': ' button_ping2 ',
	});
//	document.form.current_page.value = "/";
//	document.form.next_page.value = "";
	document.form.action_mode.value = " Apply ";
	
	
	document.form.submit();
	}
}
function domore_link_txt(obj){
	obj.value = "../Advanced_Extensions_SS.asp";
	domore_link(obj);
	document.form.submit();
}

function change_tmp_write(){
	if (document.form.rt_ss_method_tmp_write_x_0.value != document.form.rt_ss_method_x_0.value || document.form.rt_ss_method_tmp_write_x_0.value != document.form.rt_ss_method_write_x_0.value){
		if (document.form.rt_ss_method_tmp_write_x_0.value != document.form.rt_ss_method_x_0.value)
			var tmp_write = document.form.rt_ss_method_x_0.value;
		if (document.form.rt_ss_method_tmp_write_x_0.value != document.form.rt_ss_method_write_x_0.value)
			var tmp_write = document.form.rt_ss_method_write_x_0.value;
		if (tmp_write == "")
			var tmp_write = "none";
		document.form.rt_ss_method_x_0.value = tmp_write;
		document.form.rt_ss_method_write_x_0.value = tmp_write;
		document.form.rt_ss_method_tmp_write_x_0.value = tmp_write;
		document.getElementById("rt_ss_method_x_0").options[0].text = tmp_write;
		document.getElementById("rt_ss_method_x_0").options[0].value = tmp_write;
		document.getElementById("rt_ss_method_x_0").options[0].selected = true;
	}
	//SS和SSR切换
	var method_x = document.form.rt_ss_method_x_0.value;
	if (method_x == "aes-128-cfb" || method_x == "aes-128-ctr" || method_x == "aes-128-gcm" || method_x == "aes-192-cfb" || method_x == "aes-192-ctr" || method_x == "aes-192-gcm" || method_x == "aes-256-cfb" || method_x == "aes-256-ctr" || method_x == "aes-256-gcm" || method_x == "bf-cfb" || method_x == "camellia-128-cfb" || method_x == "camellia-192-cfb" || method_x == "camellia-256-cfb" || method_x == "chacha20" || method_x == "chacha20-ietf" || method_x == "chacha20-ietf-poly1305" || method_x == "rc4-md5" || method_x == "salsa20" || method_x == "xchacha20-ietf-poly1305"){
		if (document.form.ssr_type_protocol.value == "origin" && document.form.ssr_type_obfs.value == "plain"){
			document.form.ss_type_x_0.value = "ss";
		}else{
			document.form.ss_type_x_0.value = "ssr";
		}
	}else{
		document.form.ss_type_x_0.value = "ssr";
	}
	if(document.form.ss_type_x_0.value == "ss")
		document.getElementById("ss_type_x_0").options[0].selected = true;
	if(document.form.ss_type_x_0.value == "ssr")
		document.getElementById("ss_type_x_0").options[1].selected = true;
	var ss_usage_value = " ";
	var tmp_write = document.form.ssr_type_protocol.value;
	if (tmp_write == "")
		var tmp_write = "origin";
	var ss_usage_value = ss_usage_value + ' -O ' + tmp_write;
	
	var tmp_write = document.form.ssr_type_obfs.value;
	if (tmp_write == "")
		var tmp_write = "plain";
	var ss_usage_value = ss_usage_value + ' -o ' + tmp_write;
	document.form.rt_ss_usage_x_0.value = ss_usage_value + ' --plugin --plugin-opts ';
	document.form.rt_ss_usage_tmp_x_0.value = document.form.rt_ss_usage_x_0.value;
}
function change_rt_ss_usage_tmp_x_0_write(){
	document.form.rt_ss_usage_x_0.value = document.form.rt_ss_usage_tmp_x_0.value;
}

function clear_tmp_write(){
	var mmm = document.form.ss_change_2_ss_method.value;
	if(mmm == "1"){
		if(document.form.rt_ss_method_write_x_0.value != ""){
			document.getElementById("rt_ss_method_x_0").options[0].text = document.form.rt_ss_method_write_x_0.value;
			document.getElementById("rt_ss_method_x_0").options[0].value = document.form.rt_ss_method_write_x_0.value;
		}
		document.getElementById("rt_ss_method_x_0").options[0].selected = true;
	}
}

function click_change_ss_method(o) {
	var v = (o.checked) ? "1" : "0";
	document.form.ss_change_2_ss_method.value = v;
	click_change_ss_method2();
}
function click_change_ss_method2() {
	var m = document.form.ss_change_2_ss_method.value;
	var m_x = (m == "1") ? 0 : 1;
	showhide_div("ss_method_write1_tr", m_x);
	showhide_div("ss_method_write3_tr", m);
	document.form.rt_ss_method_write_x_0.value = document.form.rt_ss_method_x_0.value;
	document.form.rt_ss_method_tmp_write_x_0.value = document.form.rt_ss_method_x_0.value;
}

function usage_replace3(re_array,re_o){
	for(var i = 0;i < re_array.length; i++) {
		if (document.form.rt_ss_usage_x_0.value.indexOf(re_array[i],0)>0){
			document.form.rt_ss_usage_x_0.value = document.form.rt_ss_usage_x_0.value.replace(re_array[i], '');
			document.form.rt_ss_usage_x_0.value = document.form.rt_ss_usage_x_0.value.replace(re_o, '');
			document.form.rt_ss_usage_x_0.value = document.form.rt_ss_usage_x_0.value.replace('  ', ' ');
			document.form.rt_ss_usage_x_0.value = document.form.rt_ss_usage_x_0.value.replace(/\ \ /g,"\ ");
		}
	}
}

function get_ping(domain) {
	var ping_type = "";
	if (typeof(ping_data) != "undefined"){
		//var matchArr = ping_data.match('(?<=🔗' + domain + '=[^🔗]*)[^🔗\>]+');
		var matchArr = ping_data.match('🔗' + domain + '=[^🔗]+');
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
function get_ACL2List(){
	var tmp_ACL2List_tmp = new Array();
	if (typeof(document.getElementById("app_24_txt").childNodes["0"]) != "undefined"){
	var link_txt = document.getElementById("app_24_txt").childNodes["0"].data;
	link_txt.trim().split('\n').forEach(function(v, i) {
		link_d(v);
		if (ss_type_d == "ss" || ss_type_d == "ssr"){
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
		ACL2List_tmp.push(ss_type_d);
		ACL2List_tmp.push(i);
		tmp_ACL2List_tmp.push(ACL2List_tmp);
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

function addSSROrSSLink(){
	var link = document.form.ssr_ss_link.value;
	if(link.indexOf('vmess://') != -1){
		alert('vmess://无效链接');
		return;
	}
	else if(link.indexOf('ss://') != -1 || link.indexOf('ssr://') != -1 ){
		ss_name_d = '';
		ss_server_d = '';
		ss_port_d = '';
		ss_password_d = '';
		ss_method_d = '';
		ss_usage_d = '';
		link_d(link);
		document.form.rt_ss_name_x_0.value = ss_name_d;
		document.form.rt_ss_server_x_0.value = ss_server_d;
		document.form.rt_ss_port_x_0.value = ss_port_d;
		document.form.rt_ss_password_x_0.value = ss_password_d;
		document.form.rt_ss_method_x_0.value = ss_method_d;
		document.form.rt_ss_usage_x_0.value = ss_usage_d;
		document.form.ss_type_x_0.value = ss_type_d;
		document.form.rt_ss_usage_tmp_x_0.value = ss_usage_d;
	}
	else{
		alert('无效链接');
	}
}

</script>
<style>
.table-list td {
	padding: 6px 8px;
}
.table-list input,
.table-list select {
	margin-top: 0px;
	margin-bottom: 0px;
}
</style>
</head>

<body class="body_iframe" onload="initial();">

	
	
<iframe name="hidden_frame" style="position: absolute;" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

<form method="post" name="form" id="form" action="/start_apply.htm">
	<input type="hidden" name="current_page" value="">
<input type="hidden" name="next_page" value="/device-map/ss.asp">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="LANHostConfig;General;APP;">
	<input type="hidden" name="group_id" value="rt_ACLList">
<input type="hidden" name="action_mode" value="">
<input type="hidden" name="action_script" value="">
<input type="hidden" name="row_id_x_0" value="">

	<input type="hidden" name="ss_change_2_ss_method" value="<% nvram_get_x("", "ss_change_2_ss_method"); %>" />
	<input type="hidden" name="ss_run_ss_local" value="<% nvram_get_x("", "ss_run_ss_local"); %>" />
	<input type="hidden" name="ss_link_up" value="<% nvram_get_x("", "ss_link_up"); %>" />
	<input type="hidden" name="ss_link_ping" value="<% nvram_get_x("", "ss_link_ping"); %>" />
	<input type="hidden" name="app_99" value="<% nvram_get_x("", "app_99"); %>" />
	<input type="hidden" name="app_100" value="<% nvram_get_x("", "app_100"); %>" />
	<input type="hidden" name="ss_matching_enable" value="<% nvram_get_x("", "ss_matching_enable"); %>" />

<ul class="nav nav-tabs">
	<li class="active"><a href="javascript:;">设置参数</a></li>
	<li><a href="ssinfo.asp">查询Shadowsocks</a></li>
</ul>


				<!--Body content-->
				
						
							
							
								<div class="row-fluid">

									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table" style="margin-bottom: 0px;">

										<tr>
											<th width="30%" style="border-top: 0 none;"><#SSConfig_enable#></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_enable_on_of">
														<input type="checkbox" id="ss_enable_fake" <% nvram_match_x("", "ss_enable", "1", "value=1 checked"); %><% nvram_match_x("", "ss_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_enable" id="ss_enable_1" class="input" value="1" <% nvram_match_x("", "ss_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_enable" id="ss_enable_0" class="input" value="0" <% nvram_match_x("", "ss_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
											<td id="col_gotoss" width="40%" style="margin-top: 10px; border-top: 0 none;">
											&nbsp;<input class="btn btn-success" style="width:60px" type="button" value="重启" onclick="button_updatess()" />
												<input class="btn btn-info" type="button" name="gotoss" value="转到详细设置" onclick="domore_link_txt(this);">
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">代理方案选择</a></th>
											<td  colspan="3"  style="border-top: 0 none;">
												<select name="ss_mode_x" class="input" style="width: 60%;">
													<option value="0" <% nvram_match_x("","ss_mode_x", "0","selected"); %>>方案一chnroutes，国外IP走代理</option>
													<option value="1" <% nvram_match_x("","ss_mode_x", "1","selected"); %>>方案二gfwlist（推荐），只有被墙的站点IP走代理</option>
													<option value="2" <% nvram_match_x("","ss_mode_x", "2","selected"); %>>方案三，全部IP走代理</option>
													<option value="3" <% nvram_match_x("","ss_mode_x", "3","selected"); %>>方案四，只启用ss-local 建立本地 SOCKS 代理</option>
												</select>
												<label id="run_ss_local_tr" class="checkbox inline"><input type="checkbox" name="run_ss_local_fake" value="" style="margin-left:10;" onclick="click_run_ss_local(this);" <% nvram_match_x("", "ss_run_ss_local", "1", "checked"); %>/>同时启用 ss-local</label>
										</tr>
									</table>
									<table class="table" style="margin-bottom: 0px;">
										<tr>
											<td width="50%" style="margin-top: 10px; border-top: 0 none;">
											   <input class="btn btn-success" type="button" value="ping" onclick="button_ping();">
											&nbsp;<input class="btn btn-primary" type="button" value="自动选用节点" onclick="button_matching();">
											</td>
											<td style="border-top: 0 none;">
												<input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" />
											</td>
										</tr>
									</table>
									<table width="100%" cellpadding="4" cellspacing="0" class="table table-list" style="margin-bottom: 0px;">
										<tr>
											<th colspan="9" style="background-color: #E3E3E3;">Shadowsocks节点选择</th>
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
											<th><input style="width: 365px; background-color: #ffd;" type="text" maxlength="512" class="input" size="15" id="app_97" name="app_97" value="<% nvram_get_x("","app_97"); %>" onKeyPress="return is_string(this,event);" /></th>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="3" cellspacing="0" class="table-list" id="ACLList_Block2" style="margin-bottom: 0px;">
									</table>
									<table width="100%" cellpadding="4" cellspacing="0" class="table table-list" style="margin-bottom: 0px;">
										<tr>
											<th>服务器订阅节点:</th>
											<td cellpadding="3">
												<input type="text" style="width: 180px;" maxlength="1024" class="input" size="15" id="ssr_link" name="ssr_link" placeholder="(ss、ssr、ssd): https://www.123.com/ss_link.txt" value="<% nvram_get_x("","ssr_link"); %>" onKeyPress="return is_string(this,event);" />
												<button style="margin-left: -5px;" class="btn" type="button" onclick="delval('ssr_link')"><i class="icon-trash" name="ssr_link_icon" id="ssr_link_icon"></i></button>
												<input type="text" style="width: 20px; display:none;" maxlength="10" class="input" size="15" id="ss_link_status" name="ss_link_status" value="<% nvram_get_x("","ss_link_status"); %>" />
												<input type="text" style="width: 20px; display:none;" maxlength="10" class="input" size="15" id="rt_ssnum_x_tmp" name="rt_ssnum_x_tmp" value="<% nvram_get_x("","rt_ssnum_x_tmp"); %>" />
												<input class="btn btn-info" type="button" name="ssr_ss" id="ssr_ss" value="更新" onclick="up_ssr_link();">
												<input class="btn btn-danger" type="button" name="ssr_ss" id="ssr_ss" value="清空🔗订阅" onclick="del_ssr_link();">
												
												<div>
												<label id="ss_link_up_tr" class="checkbox inline"><input type="checkbox" name="ss_link_up_fake" value="" style="margin-left:10;" onclick="click_ss_link_up(this);" <% nvram_match_x("", "ss_link_up", "1", "checked"); %>/>停止定时更新</label>
												<label id="ss_link_ping_tr" class="checkbox inline"><input type="checkbox" name="ss_link_ping_fake" value="" style="margin-left:10;" onclick="click_ss_link_ping(this);" <% nvram_match_x("", "ss_link_ping", "1", "checked"); %>/>停止ping</label>
												<label id="app_100_tr" class="checkbox inline"><input type="checkbox" name="app_100_fake" value="" style="margin-left:10;" onclick="click_app_100(this);" <% nvram_match_x("", "app_100", "1", "checked"); %>/>停止排序节点</label>
												<label id="app_99_tr" class="checkbox inline"><input type="checkbox" name="app_99_fake" value="" style="margin-left:10;" onclick="click_app_99(this);" <% nvram_match_x("", "app_99", "1", "checked"); %>/>更新后优选匹配</label>
												</div>
											</td>
										</tr>
										<tr>
											<th><a href="https://shadowsocks.org/en/spec/SIP002-URI-Scheme.html" target="blank_ss">链接导入单节点</a>:</th>
											<td cellpadding="3">
												<input type="text" style="width: 255px;" maxlength="1024" class="input" size="15" id="ssr_ss_link" name="ssr_ss_link" placeholder="(ss、ssr): ss://cmM0LW1kNTpwYXNzd2Q=@192.168.100.1:8888/?plugin=obfs-local%3Bobfs%3Dhttp#Example2" value="" refresh="" onKeyPress="return is_string(this,event);" />
												<button style="margin-left: -5px;" class="btn" type="button" onclick="delval('ssr_ss_link')"><i class="icon-trash" name="ssr_ss_link_icon" id="ssr_ss_link_icon"></i></button>
												<input class="btn btn-info" type="button" name="ssr_ss" id="ssr_ss" value="导入" onclick="addSSROrSSLink();">
											</td>
										</tr>
										<tr>
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('app_24')"><span>批量导入链接节点(ss、ssr)</span></a>
												<div id="app_24" style="display:none;">
													<textarea id="app_24_txt" rows="10" wrap="off" spellcheck="false" maxlength="2097152" class="span12" name="scripts.app_24.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.app_24.sh",""); %></textarea>
												</div>
											</td>
										</tr>
									</table>
									<table width="100%" cellpadding="4" cellspacing="0" class="table table-list" style="margin-bottom: 0px;">
										<tr>
											<th colspan="2" style="background-color: #E3E3E3;">Shadowsocks节点配置</th>
											<th style="background-color: #E3E3E3;">代理类型</th>
											<td style="background-color: #E3E3E3;"" >
												<select name="ss_type_x_0" id="ss_type_x_0" class="input" style="width: 60px;">
													<option value="ss" <% nvram_match_x("","ss_type_x_0", "ss","selected"); %>>ss</option>
													<option value="ssr" <% nvram_match_x("","ss_type_x_0", "ssr","selected"); %>>ssr</option>
												</select>
											</td>
											<th colspan="4" style="background-color: #E3E3E3;"></th>
										</tr>
										<th style="border-top: 0 none;">协议插件 (protocol):</th>
										<td style="border-top: 0 none;">
											<select name="ssr_type_protocol" style="width: 140px;" onChange="change_tmp_write();">
											<option value="origin" <% nvram_match_x("","ssr_type_protocol", "origin","selected"); %>></option>
											<option value="verify_simple" <% nvram_match_x("","ssr_type_protocol", "verify_simple","selected"); %>>verify_simple</option>
											<option value="verify_sha1" <% nvram_match_x("","ssr_type_protocol", "verify_sha1","selected"); %>>verify_sha1</option>
											<option value="auth_simple" <% nvram_match_x("","ssr_type_protocol", "auth_simple","selected"); %>>auth_simple</option>
											<option value="auth_sha1" <% nvram_match_x("","ssr_type_protocol", "auth_sha1","selected"); %>>auth_sha1</option>
											<option value="auth_sha1_v2" <% nvram_match_x("","ssr_type_protocol", "auth_sha1_v2","selected"); %>>auth_sha1_v2</option>
											<option value="auth_sha1_v4" <% nvram_match_x("","ssr_type_protocol", "auth_sha1_v4","selected"); %>>auth_sha1_v4</option>
											<option value="auth_aes128_md5" <% nvram_match_x("","ssr_type_protocol", "auth_aes128_md5","selected"); %>>auth_aes128_md5</option>
											<option value="auth_aes128_sha1" <% nvram_match_x("","ssr_type_protocol", "auth_aes128_sha1","selected"); %>>auth_aes128_sha1</option>
											<option value="auth_chain_a" <% nvram_match_x("","ssr_type_protocol", "auth_chain_a","selected"); %>>auth_chain_a</option>
											<option value="auth_chain_b" <% nvram_match_x("","ssr_type_protocol", "auth_chain_b","selected"); %>>auth_chain_b</option>
											<option value="auth_chain_c" <% nvram_match_x("","ssr_type_protocol", "auth_chain_c","selected"); %>>auth_chain_c</option>
											<option value="auth_chain_d" <% nvram_match_x("","ssr_type_protocol", "auth_chain_d","selected"); %>>auth_chain_d</option>
											<option value="auth_chain_e" <% nvram_match_x("","ssr_type_protocol", "auth_chain_e","selected"); %>>auth_chain_e</option>
											<option value="auth_chain_f" <% nvram_match_x("","ssr_type_protocol", "auth_chain_f","selected"); %>>auth_chain_f</option>
											</select>
										</td>
										<th style="border-top: 0 none;">混淆插件 (obfs):</th>
										<td style="border-top: 0 none;">
											<select name="ssr_type_obfs" style="width: 140px;" onChange="change_tmp_write();">
											<option value="plain" <% nvram_match_x("","ssr_type_obfs", "plain","selected"); %>></option>
											<option value="http_simple" <% nvram_match_x("","ssr_type_obfs", "http_simple","selected"); %>>http_simple</option>
											<option value="http_post" <% nvram_match_x("","ssr_type_obfs", "http_post","selected"); %>>http_post</option>
											<option value="tls1.2_ticket_auth" <% nvram_match_x("","ssr_type_obfs", "tls1.2_ticket_auth","selected"); %>>tls1.2_ticket_auth</option>
											</select>
										</td>
									</table>
									<table width="100%" cellpadding="4" cellspacing="0" class="table table-list" style="margin-bottom: 0px;">
										<tr>
											<th style="border-top: 0 none;" width="25%">高级启动参数选项:</th>
											<td style="border-top: 0 none;" cellpadding="3">
												<input type="text" maxlength="512" class="span12" size="32" name="rt_ss_usage_tmp_x_0" onChange="change_rt_ss_usage_tmp_x_0_write();" value="<% nvram_get_x("", "rt_ss_usage_x_0"); %>" onKeyPress="return is_string(this,event);" />
											</td>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table table-list" id="link_Block" style="margin-bottom: 0px;">
										<tr>
											<th width="25%">节点名称<button style="margin-left: 10px;" class="btn" type="button" onclick="del_ssr_ss_link();"><i class="icon-trash" name="del_ssr_ss_link" id="del_ssr_ss_link"></i></button></th>
											<th width="13%">服务器地址</th>
											<th width="10%">端口</th>
											<th width="10%">密码</th>
											<th width="14%">加密方式&nbsp;<label id="change_ss_method_tr" class="checkbox inline"><input type="checkbox" name="change_ss_method_fake" value="" style="margin-left:10;" onclick="click_change_ss_method(this);" <% nvram_match_x("", "ss_change_2_ss_method", "1", "checked"); %>/>手填</label></th>
											<th width="13%">协议混淆</th>
											<th width="1%" style="display:none;">&nbsp;</th>
											<th width="1%" style="display:none;">&nbsp;</th>
											<th width="5%"><button class="btn btn-danger" type="submit" onclick="return add_del_link(this, ' dellink ');" name="dellink"><i class="icon icon-minus icon-white"></i></button></td></th>
										</tr>
										<tr>
											<td>
												<input type="text" maxlength="512" class="span12" size="32" name="rt_ss_name_x_0" value="<% nvram_get_x("", "rt_ss_name_x_0"); %>" onKeyPress="return is_string(this,event);" />
											</td>
											<td>
												<input type="text" maxlength="512" class="span12" size="32" name="rt_ss_server_x_0" value="<% nvram_get_x("", "rt_ss_server_x_0"); %>" onKeyPress="return is_string(this,event);" />
											</td>
											<td>
												<input type="text" maxlength="5" class="span12" size="32" name="rt_ss_port_x_0" value="<% nvram_get_x("", "rt_ss_port_x_0"); %>" onKeyPress="return is_number(this,event);" />
											</td>
											<td>
												<input type="text" maxlength="512" class="span12" size="32" name="rt_ss_password_x_0" value="<% nvram_get_x("", "rt_ss_password_x_0"); %>" onKeyPress="return is_string(this,event);" />
											</td>
											<td id="ss_method_write1_tr">
												<select name="rt_ss_method_x_0" id="rt_ss_method_x_0" style="width: 110px;" onChange="change_tmp_write();">
													<option value="" <% nvram_match_x("","rt_ss_method_x_0", "","selected"); %>></option>
														<option value="chacha20-ietf-poly1305" <% nvram_match_x("","ss_method", "chacha20-ietf-poly1305","selected"); %>>chacha20-ietf-poly1305 [SS]</option>
														<option value="xchacha20-ietf-poly1305" <% nvram_match_x("","ss_method", "xchacha20-ietf-poly1305","selected"); %>>xchacha20-ietf-poly1305 [SS]</option>
														<option value="aes-128-gcm" <% nvram_match_x("","ss_method", "aes-128-gcm","selected"); %>>aes-128-gcm [SS]</option>
														<option value="aes-192-gcm" <% nvram_match_x("","ss_method", "aes-192-gcm","selected"); %>>aes-192-gcm [SS]</option>
														<option value="aes-256-gcm" <% nvram_match_x("","ss_method", "aes-256-gcm","selected"); %>>aes-256-gcm [SS]</option>
														<option value="aes-128-cfb" <% nvram_match_x("","ss_method", "aes-128-cfb","selected"); %>>aes-128-cfb [SS/SSR]</option>
														<option value="aes-192-cfb" <% nvram_match_x("","ss_method", "aes-192-cfb","selected"); %>>aes-192-cfb [SS/SSR]</option>
														<option value="aes-256-cfb" <% nvram_match_x("","ss_method", "aes-256-cfb","selected"); %>>aes-256-cfb [SS/SSR]</option>
														<option value="aes-128-ctr" <% nvram_match_x("","ss_method", "aes-128-ctr","selected"); %>>aes-128-ctr [SS/SSR]</option>
														<option value="aes-192-ctr" <% nvram_match_x("","ss_method", "aes-192-ctr","selected"); %>>aes-192-ctr [SS/SSR]</option>
														<option value="aes-256-ctr" <% nvram_match_x("","ss_method", "aes-256-ctr","selected"); %>>aes-256-ctr [SS/SSR]</option>
														<option value="rc4-md5" <% nvram_match_x("","ss_method", "rc4-md5","selected"); %>>rc4-md5 [SS/SSR]</option>
														<option value="chacha20" <% nvram_match_x("","ss_method", "chacha20","selected"); %>>chacha20 [SS/SSR]</option>
														<option value="chacha20-ietf" <% nvram_match_x("","ss_method", "chacha20-ietf","selected"); %>>chacha20-ietf [SS/SSR]</option>
														<option value="camellia-128-cfb" <% nvram_match_x("","ss_method", "camellia-128-cfb","selected"); %>>camellia-128-cfb [SS/SSR]</option>
														<option value="camellia-192-cfb" <% nvram_match_x("","ss_method", "camellia-192-cfb","selected"); %>>camellia-192-cfb [SS/SSR]</option>
														<option value="camellia-256-cfb" <% nvram_match_x("","ss_method", "camellia-256-cfb","selected"); %>>camellia-256-cfb [SS/SSR]</option>
														<option value="bf-cfb" <% nvram_match_x("","ss_method", "bf-cfb","selected"); %>>bf-cfb [SS/SSR]</option>
														<option value="cast5-cfb" <% nvram_match_x("","ss_method", "cast5-cfb","selected"); %>>cast5-cfb</option>
														<option value="des-cfb" <% nvram_match_x("","ss_method", "des-cfb","selected"); %>>des-cfb</option>
														<option value="idea-cfb" <% nvram_match_x("","ss_method", "idea-cfb","selected"); %>>idea-cfb</option>
														<option value="rc2-cfb" <% nvram_match_x("","ss_method", "rc2-cfb","selected"); %>>rc2-cfb</option>
														<option value="rc4" <% nvram_match_x("","ss_method", "rc4","selected"); %>>rc4</option>
														<option value="rc4-md5-6" <% nvram_match_x("","ss_method", "rc4-md5-6","selected"); %>>rc4-md5-6</option>
														<option value="salsa20" <% nvram_match_x("","ss_method", "salsa20","selected"); %>>salsa20</option>
														<option value="seed-cfb" <% nvram_match_x("","ss_method", "seed-cfb","selected"); %>>seed-cfb</option>
														<option value="table" <% nvram_match_x("","ss_method", "table","selected"); %>>table</option>
														<option value="none" <% nvram_match_x("","ss_method", "none","selected"); %>>none [SSR]</option>
												</select>
											</td>
											<td id="ss_method_write2_tr" style="display:none;">
												<input type="text" maxlength="32" class="input" size="15" style="width: 100px;" name="rt_ss_method_tmp_write_x_0" value="<% nvram_get_x("","rt_ss_method_write_x_0"); %>" onKeyPress="return is_string(this,event);"  />
											</td>
											<td id="ss_method_write3_tr" style="display:none;">
												<input type="text" maxlength="32" class="input" size="15" style="width: 100px;" onChange="change_tmp_write();" name="rt_ss_method_write_x_0" value="<% nvram_get_x("","rt_ss_method_write_x_0"); %>" onKeyPress="return is_string(this,event);"  />
											</td>
											<td>
												<input type="text" maxlength="512" class="span12" size="32" name="rt_ss_usage_x_0" readonly="readonly" value="<% nvram_get_x("", "rt_ss_usage_x_0"); %>" onKeyPress="return is_string(this,event);" />
											</td>
											<td width="5%">
												<button class="btn" style="max-width: 219px" type="submit" onclick="return add_del_link(this, ' addlink ');" name="addlink" value="<#CTL_add#>" size="12"><i class="icon icon-plus"></i></button>
											</td>
										</tr>
									</table>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table table-list" id="ACLList_Block" style="margin-bottom: 0px;">
									</table>
									<table class="table">
										<tr>
											<td width="30%" style="margin-top: 10px; border-top: 0 none;">
											   <input class="btn btn-success" type="button" value=" ping " onclick="button_ping();">
											</td>
											<td width="20%" style="border-top: 0 none;">
												<input class="btn btn-danger" type="button" name="ssr_ss" id="ssr_ss" value="重置订阅文件" onclick="clean_ssr_link();">
											</td>
											<td style="border-top: 0 none;">
												<input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" />
											</td>
										</tr>
									</table>

<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table table-list">
<tr>
	<th width="30%">代理类型</th>
	<td>
		<select name="ss_type" id="ss_type" class="input">
			<option value="0" <% nvram_match_x("","ss_type", "0","selected"); %>>SS</option>
			<option value="1" <% nvram_match_x("","ss_type", "1","selected"); %>>SSR</option>
		</select>
	</td>
</tr>
<tr>
	<th><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 25, 1);"><#SSConfig_ServerIP_itemname#></a></th>
	<td>
		<input type="text" maxlength="512" class="input" size="15" id="ss_server" name="ss_server" value="<% nvram_get_x("","ss_server"); %>" onKeyPress="return is_string(this,event);" />
		<div>&nbsp;<span style="color:#888;">主服务器  [IP 或 域名]</span></div>
	</td>
</tr>
<tr>
	<th><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,2);"><#SSConfig_ServerPort_itemname#></a></th>
	<td>
		<input type="text" maxlength="5" class="input" size="15" name="ss_server_port" value="<% nvram_get_x("","ss_server_port"); %>" onKeyPress="return is_number(this,event);"/>
		<div>&nbsp;<span style="color:#888;">[100...65535]</span></div>
	</td>
</tr>
<tr>
	<th><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,4);"><#SSConfig_Key_itemname#></a></th>
	<td>
	<div class="input-append">
		<input type="password" maxlength="512" class="input" size="15" name="ss_key" id="ss_key" style="width: 175px;" value="<% nvram_get_x("","ss_key"); %>" onKeyPress="return is_string(this,event);"/>
		<button style="margin-left: -5px;" class="btn" type="button" onclick="passwordShowHide('ss_key')"><i class="icon-eye-close"></i></button>
	</div>
	<div>&nbsp;<span style="color:#888;">注意！大小写敏感！</span></div>
	</td>
	<td>
</tr>
<tr>
	<th><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,5);"><#SSConfig_Method_itemname#></a></th>
	<td>
		<select name="ss_method" id="ss_method" class="input">
			<option value="" <% nvram_match_x("","ss_method", "","selected"); %>></option>
				<option value="chacha20-ietf-poly1305" <% nvram_match_x("","ss_method", "chacha20-ietf-poly1305","selected"); %>>chacha20-ietf-poly1305 [SS]</option>
				<option value="xchacha20-ietf-poly1305" <% nvram_match_x("","ss_method", "xchacha20-ietf-poly1305","selected"); %>>xchacha20-ietf-poly1305 [SS]</option>
				<option value="aes-128-gcm" <% nvram_match_x("","ss_method", "aes-128-gcm","selected"); %>>aes-128-gcm [SS]</option>
				<option value="aes-192-gcm" <% nvram_match_x("","ss_method", "aes-192-gcm","selected"); %>>aes-192-gcm [SS]</option>
				<option value="aes-256-gcm" <% nvram_match_x("","ss_method", "aes-256-gcm","selected"); %>>aes-256-gcm [SS]</option>
				<option value="aes-128-cfb" <% nvram_match_x("","ss_method", "aes-128-cfb","selected"); %>>aes-128-cfb [SS/SSR]</option>
				<option value="aes-192-cfb" <% nvram_match_x("","ss_method", "aes-192-cfb","selected"); %>>aes-192-cfb [SS/SSR]</option>
				<option value="aes-256-cfb" <% nvram_match_x("","ss_method", "aes-256-cfb","selected"); %>>aes-256-cfb [SS/SSR]</option>
				<option value="aes-128-ctr" <% nvram_match_x("","ss_method", "aes-128-ctr","selected"); %>>aes-128-ctr [SS/SSR]</option>
				<option value="aes-192-ctr" <% nvram_match_x("","ss_method", "aes-192-ctr","selected"); %>>aes-192-ctr [SS/SSR]</option>
				<option value="aes-256-ctr" <% nvram_match_x("","ss_method", "aes-256-ctr","selected"); %>>aes-256-ctr [SS/SSR]</option>
				<option value="rc4-md5" <% nvram_match_x("","ss_method", "rc4-md5","selected"); %>>rc4-md5 [SS/SSR]</option>
				<option value="chacha20" <% nvram_match_x("","ss_method", "chacha20","selected"); %>>chacha20 [SS/SSR]</option>
				<option value="chacha20-ietf" <% nvram_match_x("","ss_method", "chacha20-ietf","selected"); %>>chacha20-ietf [SS/SSR]</option>
				<option value="camellia-128-cfb" <% nvram_match_x("","ss_method", "camellia-128-cfb","selected"); %>>camellia-128-cfb [SS/SSR]</option>
				<option value="camellia-192-cfb" <% nvram_match_x("","ss_method", "camellia-192-cfb","selected"); %>>camellia-192-cfb [SS/SSR]</option>
				<option value="camellia-256-cfb" <% nvram_match_x("","ss_method", "camellia-256-cfb","selected"); %>>camellia-256-cfb [SS/SSR]</option>
				<option value="bf-cfb" <% nvram_match_x("","ss_method", "bf-cfb","selected"); %>>bf-cfb [SS/SSR]</option>
				<option value="cast5-cfb" <% nvram_match_x("","ss_method", "cast5-cfb","selected"); %>>cast5-cfb</option>
				<option value="des-cfb" <% nvram_match_x("","ss_method", "des-cfb","selected"); %>>des-cfb</option>
				<option value="idea-cfb" <% nvram_match_x("","ss_method", "idea-cfb","selected"); %>>idea-cfb</option>
				<option value="rc2-cfb" <% nvram_match_x("","ss_method", "rc2-cfb","selected"); %>>rc2-cfb</option>
				<option value="rc4" <% nvram_match_x("","ss_method", "rc4","selected"); %>>rc4</option>
				<option value="rc4-md5-6" <% nvram_match_x("","ss_method", "rc4-md5-6","selected"); %>>rc4-md5-6</option>
				<option value="salsa20" <% nvram_match_x("","ss_method", "salsa20","selected"); %>>salsa20</option>
				<option value="seed-cfb" <% nvram_match_x("","ss_method", "seed-cfb","selected"); %>>seed-cfb</option>
				<option value="table" <% nvram_match_x("","ss_method", "table","selected"); %>>table</option>
				<option value="none" <% nvram_match_x("","ss_method", "none","selected"); %>>none [SSR]</option>
		</select>
		<div>&nbsp;<span style="color:#888;">选错无法连通</span></div>
	</td>
</tr>
<tr id="ss_usage">
	<th style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,10);">高级启动参数选项</a></th>
	<td style="border-top: 0 none;"  cellpadding="2">
		<input style="width: 400px;" type="text" maxlength="512" class="input" size="15" name="ss_usage" value="<% nvram_get_x("","ss_usage"); %>" onKeyPress="return is_string(this,event);"/>
	</td>
</tr>
</table>
								</div>
</form>

</body>
</html>
