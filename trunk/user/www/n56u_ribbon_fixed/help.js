var helpcontent = new Array(28);
var help_enable = '<% nvram_get_x("", "help_enable"); %>';

helpcontent[0] = new Array("");
helpcontent[1] = new Array("");
helpcontent[2] = new Array("");
helpcontent[3] = new Array("");

helpcontent[4] = new Array("",
				"<#LANHostConfig_IPRouters_itemdesc#>",
				"<#LANHostConfig_SubnetMask_itemdesc#>",
				"<#LANHostConfig_x_Gateway_itemdesc#>");
helpcontent[5] = new Array("",
				"<#LANHostConfig_DHCPServerConfigurable_itemdesc#>",
				"<#LANHostConfig_DomainName_itemdesc#> <#LANHostConfig_x_DDNS_alarm_hostname#> <#LANHostConfig_DomainName_itemdesc2#>",
				"<#LANHostConfig_MinAddress_itemdesc#>",
				"<#LANHostConfig_MaxAddress_itemdesc#>",
				"<#LANHostConfig_LeaseTime_itemdesc#>",
				"<#LANHostConfig_x_LGateway_itemdesc#>",
				"<#LANHostConfig_x_LDNSServer1_itemdesc#>",
				"<#LANHostConfig_x_LDNSServer1_itemdesc#>",
				"<#LANHostConfig_x_LDNSServer1_itemdesc#>",
				"<#LANHostConfig_x_WINSServer_itemdesc#>",
				"<#LANHostConfig_ManualDHCPEnable_itemdesc#>",
				"<#LANHostConfig_x_LDNSServer6_itemdesc#>");
helpcontent[6] = new Array("",
				"<#RHELP_desc4#>",
				"<#RHELP_desc5#>",
				"<#RHELP_desc6#>",
				"<#RHELP_desc7#>",
				"<#RHELP_desc8#>",
				"<#RHELP_desc9#>",
				"<#RouterConfig_GWMulticast_Multicast_all_itemdesc#>",
				"<#RouterConfig_GWMulticast_Multicast_all_itemdesc#>",
				"<#RouterConfig_GWMulticast_Multicast_all_itemdesc#>",
				"<#RouterConfig_GWMulticast_Multicast_all_itemdesc#>");
//WAN
helpcontent[7] = new Array("",
				"<#IPConnection_ExternalIPAddress_itemdesc#>",
				"<#IPConnection_x_ExternalSubnetMask_itemdesc#>",
				"<#IPConnection_x_ExternalGateway_itemdesc#>",
				"<#PPPConnection_UserName_itemdesc#>",
				"<#PPPConnection_Password_itemdesc#>",
				"<#PPPConnection_IdleDisconnectTime_itemdesc#>",
				"<#PPPConnection_x_PPPoEMTU_itemdesc#>",
				"<#PPPConnection_x_PPPoEMRU_itemdesc#>",
				"<#PPPConnection_x_ServiceName_itemdesc#>",
				"<#PPPConnection_x_AccessConcentrator_itemdesc#>",
				"<#PPPConnection_x_PPPoERelay_itemdesc#>",
				"<#IPConnection_x_DNSServerEnable_itemdesc#>",
				"<#IPConnection_x_DNSServer1_itemdesc#>",
				"<#IPConnection_x_DNSServer1_itemdesc#>",
				"<#IPConnection_x_DNSServer1_itemdesc#>",
				"<#BOP_isp_host_desc#>",
				"<#PPPConnection_x_MacAddressForISP_itemdesc#>",
				"<#PPPConnection_x_PPTPOptions_itemdesc#>",
				"<#PPPConnection_x_AdditionalOptions_itemdesc#>",
				"<#BOP_isp_heart_desc#>",
				"<#IPConnection_BattleNet_itemdesc#>",
				"<#Layer3Forwarding_x_STB_itemdesc#>",
				"<#hwnat_desc#>",
				"<#hwnat_desc#>",
				"<#vpn_passthrough_desc#>",
				"<#vpn_passthrough_desc#>",
				"<#vpn_passthrough_desc#>");
//Firewall
helpcontent[8] = new Array("",
				"<#FirewallConfig_WanLanLog_itemdesc#>",
				"<#FirewallConfig_x_WanWebEnable_itemdesc#>",
				"<#FirewallConfig_x_WanWebPort_itemdesc#>",
				"<#FirewallConfig_x_WanLPREnable_itemdesc#>",
				"<#FirewallConfig_x_WanPingEnable_itemdesc#>",
				"<#FirewallConfig_FirewallEnable_itemdesc#>",
				"<#FirewallConfig_DoSEnable_itemdesc#>",
				"<#FirewallConfig_DoSEnable_itemdesc#>");
helpcontent[9] = new Array("",
				"<#FirewallConfig_URLActiveDate_itemdesc#>",
				"<#FirewallConfig_URLActiveTime_itemdesc#>");
helpcontent[10] = new Array("",
				"<#FirewallConfig_LanWanActiveDate_itemdesc#>",
				"<#FirewallConfig_LanWanActiveTime_itemdesc#>",
				"<#FirewallConfig_LanWanDefaultAct_itemdesc#>",
				"<#FirewallConfig_LanWanICMP_itemdesc#>",
				"<#FirewallConfig_LanWanFirewallEnable_itemdesc#>");
//Administration
helpcontent[11] = new Array("",
				"<#LANHostConfig_x_ServerLogEnable_itemdesc#>",
				"<#LANHostConfig_x_TimeZone_itemdesc#>",
				"<#LANHostConfig_x_NTPServer_itemdesc#>",
				"<#LANHostConfig_x_Password_itemdesc#>");
//Log
helpcontent[12] = new Array("",
				"<#General_x_SystemUpTime_itemdesc#>",
				"<#PrinterStatus_x_PrinterModel_itemdesc#>",
				"<#PrinterStatus_x_PrinterStatus_itemdesc#>",
				"<#PrinterStatus_x_PrinterUser_itemdesc#>");
//WPS
helpcontent[13] = new Array("",
				"<#WLANConfig11b_x_WPS_itemdesc#>",
				"<#WLANConfig11b_x_WPSMode_itemdesc#>",
				"<#WLANConfig11b_x_WPSPIN_itemdesc#>",
				"<#WLANConfig11b_x_DevicePIN_itemdesc#>",
				"<#WLANConfig11b_x_WPSband_itemdesc#>");
//UPnP
helpcontent[14] = new Array("",
				"<#UPnPMediaServer_Help#>");
//AiDisk Wizard
helpcontent[15] = new Array("",
				"<#AiDisk_moreconfig#>",
				"<#AiDisk_Step1_help#><p><a href='../Advanced_AiDisk_ftp.asp' target='_parent' hidefocus='true'><#MoreConfig#></a></p><!--span style='color:#CC0000'><#AiDisk_Step1_help2#></span-->",
				"<#AiDisk_Step2_help#>",
				"<#AiDisk_Step3_help#>");
//EzQoS
helpcontent[16] = new Array("",
				"<#EZQoSDesc1#><br><#EZQoSDesc2#> <a href='/Advanced_QOSUserSpec_Content.asp'><#BM_title_User#></a>");
//Others in the USB application
helpcontent[17] = new Array("",
				"<#JS_storageMLU#>",
				"<#JS_storageright#>",
				"<#Help_of_Workgroup#>",
				"<#JS_basiconfig1#>",
				"<#JS_basiconfig3#>",
				"<#JS_basiconfig8#>",
				"<#ShareNode_Seeding_itemdesc#>",
				"<#ShareNode_MaxUpload_itemdesc#>",
				"<#BasicConfig_USBStorageWhiteist_itemdesc#>",
				"<#ShareNode_FTPLANG_itemdesc#>",
				"<#StorageTorrent_itemdesc#>",
				"<#StorageAria_itemdesc#>");

// MAC filter
helpcontent[18] = new Array("",
				"<#FirewallConfig_MFMethod_itemdesc#>",
				"<#Port_format#>",
				"<#IP_format#>");
// Setting
helpcontent[19] = new Array("",
				"<#Setting_factorydefault_itemdesc#>",
				"<#Setting_save_itemdesc#>",
				"<#Setting_upload_itemdesc#>",
				"<#Storage_upload_itemdesc#>");
// QoS
helpcontent[20] = new Array("",
				"<#BM_measured_uplink_speed_desc#>",
				"<#BM_manual_uplink_speed_desc#>");
// HSDPA
helpcontent[21] = new Array("",
				"<#HSDPAConfig_hsdpa_mode_itemdesc#>",
				"<#HSDPAConfig_pin_code_itemdesc#>",
				"<#HSDPAConfig_private_apn_itemdesc#>",
				"<#HSDPAConfig_MTU_itemdesc#>",
				"<#IPConnection_x_DNSServerEnable_itemdesc#>",
				"<#IPConnection_x_DNSServer1_itemdesc#>",
				"<#IPConnection_x_DNSServer1_itemdesc#>",
				"<#IPConnection_x_DNSServer1_itemdesc#>",
				"<#HSDPAConfig_isp_itemdesc#>",
				"<#HSDPAConfig_country_itemdesc#>",
				"<#HSDPAConfig_dialnum_itemdesc#>",
				"<#HSDPAConfig_username_itemdesc#>",
				"<#HSDPAConfig_password_itemdesc#>");

helpcontent[22] = new Array("",
				"<#OP_GW_desc1#>",
				"<#OP_GW_desc1#>",
				"<#OP_AP_desc1#>");
// Tweaks
helpcontent[23] = new Array("",
				"<#TweaksWdg_desc#>");

// DDNS
helpcontent[24] = new Array("",
				"<#LANHostConfig_x_DDNSUserName_itemdesc#>",
				"<#LANHostConfig_x_DDNSPassword_itemdesc#>",
				"<#LANHostConfig_x_DDNSHostNames_itemdesc#>",
				"<#LANHostConfig_x_DDNSWildcard_itemdesc#>",
				"<#LANHostConfig_x_DDNSStatus_itemdesc#>");
//Extensions andy_modify
helpcontent[25] = new Array("",
				"<#SSConfig_ServerIP_itemdesc#>",
				"<#SSConfig_ServerPort_itemdesc#>",
				"<#SSConfig_LocalPort_itemdesc#>",
				"<#SSConfig_Key_itemdesc#>",
				"<#SSConfig_Method_itemdesc#>",
				"DNS程序选择，推荐 dnsproxy",
				"<#SSConfig_ss_upd_rules_itemdesc#>",
				"可以填写需要SS代理转发的特定端口，可填例子[22,80,443]或[1:65535]，[1:65535]=全部转发，严重警告，如果走chnrouter 和全局模式，又不限制端口，下载流量都会通过你的ss服务器往外走，随时导致你的ss服务器被封或ss服务商封你帐号，甚至连累你的SS服务商被封",
				"此功能要代理服务器支持UDP转发才有效，关闭时仅代理TCP流量; 开启时代理TCP和UDP流量",
				"此选项为SS程序的附加启动参数。",
				"重置SS的IP规则文件并重启SS，如出现SS的IP规则异常或日志出现【dnsmasq: FAILED to start up】等情况需要手动点击此按钮",
				"跳入墙内，此功能要SS服务在墙内转发才有效",
				"本地SOCKS代理端口，代理插件设置的SOCKS代理服务器的端口",
				"若使用dnsproxy查询全部DNS，则由TCP方式查询OpenDNS解决DNS污染问题（有可能导致网站链接到外国服务器，导致速度变慢，例如上淘宝变成美国淘宝，可以手动链接回国内淘宝。）；不启用时，则由本地DNS查询，遇到GFW规则的网站才走dnsproxy查询。（只有在GFW列表的网站才能解决DNS污染问题）",
				"强制使用路由的DNS（chromecast支持）：启用该项可以将局域网内客户端自定义的DNS进行接管，访问udp53端口的IP地址强制转发到路由器IP，通过设置防火墙规则，将所有DNS解析的请求“劫持”到路由器上，从而避免局域网内的主机使用自定义DNS时被污染，由于chromecast使用自定义DNS：8.8.8.8，对于chromecast这样的设备非常有用。");
helpcontent[26] = new Array("",
				"其他进程占用过高也会关闭adbyby",
				"不建议启用第三方规则,有可能破坏规则导致过滤失效",
				"白名单的域名不过滤广告，域名之间用【,】小写逗号隔开",
				"脚本中第三方程序、安装ipk所需要的opt环境，建议插入U盘，选择U盘安装。",
				"可以多个同步目录，直接复制一个config syncpath配置节，然后修改相应的localpath、remotepath等就可以了。默认模式：upload+。",
				"启动后刷新系统日志看说明",
				"迅雷快鸟是迅雷联合宽带运营商推出的一款致力于帮助用户解决宽带低、网速慢、上网体验差的专业级宽带加速软件。通过与中国最具实力的宽带运营商合作，采用最先进的智能提速技术支持，为中国亿万宽带用户提供最轻松、流畅的上网体验！",
				"启动后刷新系统日志看说明",
				"参考以下脚本说明填写参数",
				"会赚钱的路由器，绑定地址到日志查看",
				"自定义缓存目录为【空】时，默认使用第一个分区盘",
				"自定义16位sn；为【空】时自动根据MAC生成",
				"缓存大小(MB)，缓存的大小是按1000M=1G算的，如6G的剩余空间就填写6000，为【空】时默认6000",
				"这里需要输入你要显示城市的数字代码，需要进入 http://woeid.rosselliot.co.nz 输入城市拼音查询",
				"这里需要输入你要显示空气质量指数城市的城市拼音，需要进入 http://aqicn.org/city/beijing/cn/ 查询城市拼音并验证数据",
				"Opennvp专用的http代理，只能tcp，不能用udp,注意它仅能代理转发到本路由的 Opennvp端口！！！感谢KoolShare-小宝的源码。",
				"Syncthing是一个免费开源的工具，它能在你的各个网络计算机间同步文件、文件夹，所有的信息通讯都使用TLS进行加密，这样你的数据便能十分安全地逃离窥探。",
				"Syncthing有一个强大的响应式的网页管理界面(WebGUI)，它能够帮助用户简便地添加、删除和管理那些通过网络进行同步的文件夹。");
// DNSCrypt
helpcontent[27] = new Array("",
				"<#Adm_Svc_dnscrypt_desc#>",
				"<#Adm_Svc_dnscrypt_force_dns_desc#>",
				"<#Adm_Svc_dnscrypt_options_desc#>");


function openTooltip(obj, hint_array_id, hint_show_id)
{
	if (help_enable == "0" && hint_show_id > 0)
		return;

	if(hint_array_id >= helpcontent.length)
		return;

	if(hint_array_id == 14
	    || hint_array_id == 15
	    || hint_array_id == 16
	    || hint_array_id == 20)
		return;

	if(hint_show_id >= helpcontent[hint_array_id].length)
		return;

	$j(obj).attr('data-original-title', obj.innerHTML).attr('data-content', helpcontent[hint_array_id][hint_show_id]);
	$j(obj).popover('show');
}

function openHint(hint_array_id, hint_show_id){
	if (help_enable == "0" && hint_show_id > 0)
		return;
	
	$('hintofPM').style.display = "";
	
	showtext($('helpname'), "<#CTL_help#>");
	
	if($("statusframe")){
		$("statusframe").src = "";
		$("statusframe").style.display = "none";
	}
	
	$('hint_body').style.display = "";
	$("statusframe").style.display = "none";
	
	showtext($('helpname'), "<#CTL_help#>");
	showtext($('hint_body'), helpcontent[hint_array_id][hint_show_id]);
}

function closeHint(){
	$('hintofPM').style.display = "none";
}

