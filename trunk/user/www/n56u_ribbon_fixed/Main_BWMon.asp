<!DOCTYPE html>
<html>
<head>
    <title><#Web_Title#>
        -
        <流量监控></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="-1">

        <link rel="shortcut icon" href="images/favicon.ico">
        <link rel="icon" href="images/favicon.png">
        <link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">

        <link rel="stylesheet" href="/bwmon/bwmon.css" />
        <script type="text/javascript" src="/jquery.js"></script>
        <script type="text/javascript" src="/state.js"></script>
        <script type="text/javascript" src="/popup.js"></script>
        <script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>

        <script type="text/javascript">

var $j = jQuery.noConflict();
var num = 10
var showDevice = 'host';

function getCookie(cname)
{
var name = cname + "=";
var ca = document.cookie.split(';');
for(var i=0; i<ca.length; i++) 
  {
  var c = ca[i].trim();
  if (c.indexOf(name)==0) return c.substring(name.length,c.length);
  }
return "";
}


function setCookie(cname,cvalue,exdays)
{
var d = new Date();
d.setTime(d.getTime()+(exdays*24*60*60*1000));
var expires = "expires="+d.toGMTString();
document.cookie = cname + "=" + cvalue + "; " + expires;
}



function round(value) {
        return Math.round(value * 100)/100
    }
function getRate(Kbps) {
        if (isNaN(Kbps) || Kbps < 0)
            return '0'
        if (Kbps / 1000 > 1)
            return round(Kbps/1000) + ' MB/s'
        return round(Kbps) + ' KB/s'
    }
function getSize(KB) {
    if (KB / Math.pow(1024, 2) > 1) {
        return round(KB/Math.pow(1024, 2)) + ' GB'
    }
    if (KB / 1024 > 1) {
        return round(KB/1024) + ' MB';
    }
    return round(KB) + ' KB'
}
function getData() {
    $j('.popover_top').popover('hide');
    $j.ajax({  
        url: '/bwmon/usage_stats.js',
        type: 'get',  
        //cache:false,
        dataType: 'text',
        success:function(data) {
            
            // -- 解析数据 --
            var array = data.split("\n");
            var dataDevice = []
            $j.each(array, function(k, v){
                tempAr = v.split(',')
                if (tempAr.length == 7) {
                    dataDevice.push(tempAr)
                }
            })

            // -- 拼接数据，添加到对应的html位置 --
            var mainHtml = ""
            var total = {
                upFlow: 0,
                nextFlow: 0,
                flow: 0,
                upRate: 0,
                upFlow: 0,
                nextRate: 0,
            }
            var total_d = {
                upFlow: 0,
                nextFlow: 0,
                flow: 0,
                upRate: 0,
                upFlow: 0,
                nextRate: 0,
            }
            
            var dsort = getCookie("dsort");
            
            switch (dsort)
            {
                case "0":
                  dataDevice.sort(function(a,b){
                    return b[5]-a[5];
                  })
                    break;
                case "1":
                    dataDevice.sort(function(a,b){
                        return (b[5]-b[6])-(a[5]-a[6]);
                    });
                    break;
                case "2":
                    dataDevice.sort(function(a,b){
                        return (b[3]-b[4])-(a[3]-a[4]);
                    });
                    break;
                case "3":
                    dataDevice.sort(function(a,b){
                        return (b[3]+b[5])-(a[3]+a[5]);
                    });
                    break;
                    
                default:
                    dataDevice.sort(function(a,b){
                        return b[3]-a[3];
                  })
            }


            $j.each(dataDevice, function(k, v){


                totalFlowItem = parseInt(v[3]) + parseInt(v[5])
                upRate = ((parseInt(v[3]) - parseInt(v[4])) / 10)
                nextRate = ((parseInt(v[5]) - parseInt(v[6])) / 10)
                totalFlowItem_d = getSize(totalFlowItem)


                total.upFlow += parseInt(v[3])
                total.nextFlow += parseInt(v[5])
                total.flow += totalFlowItem
                total.upRate += upRate
                total.nextRate += nextRate
                active = ""
                if ((upRate+nextRate)>0)
                    active = " active-traffic"

                mainHtml += '<tr class="device'+ active +'">'
                mainHtml += '<td class="name" onclick="">'

                mainHtml += '<div class="popover_top" data-original-title="<font size=-1>'
                // mainHtml += 'data-toggle="tooltip" '
                // mainHtml += 'data-placement="right" '
                mainHtml += '设备：' + v[0] + '</font> "data-content="MAC地址: ' + v[1]+ '<br/>IP地址: ' + v[2]+'"'
                mainHtml += 'ondblclick="switchoverDeviceName()">'
                mainHtml += '<span class="hostDevice">' + v[0] + '</span>'
                mainHtml += '<span class="MACDevice">' + v[1] + '</span>'
                mainHtml += '<span class="ipDevice">' + v[2] + '</span>'
                mainHtml += '</div>'
                //mainHtml += '<div class="popover_top" data-original-title="<font size=-1>MAC 地址: B8:AE:ED:79:61:42</font>" data-content="名字: Andy-NUC">Andy-NUC</div>'
                mainHtml += '</td>'
                mainHtml += '<td class="cell-right min-width">'
                mainHtml += getSize(v[3])
                mainHtml += '</td>'
                mainHtml += '<td class="cell-right min-width">'
                mainHtml += getSize(v[5])
                mainHtml += '</td>'
                mainHtml += '<td class="cell-right min-width">'
                mainHtml += getSize(totalFlowItem)
                mainHtml += '</td>'
                mainHtml += '<td class="cell-right min-width" align="right">'
                mainHtml += getRate(upRate)
                mainHtml += '</td>'
                mainHtml += '<td class="cell-right min-width" align="right">'
                mainHtml += getRate(nextRate)
                mainHtml += '</td>'
                mainHtml += '</tr>'
            })
            total_d.upFlow = getSize(total.upFlow) 
            total_d.nextFlow = getSize(total.nextFlow)
            total_d.flow = getSize(total.flow)
            total_d.upRate = getRate(total.upRate)
            total_d.nextRate = getRate(total.nextRate)

            mainHtml += '<tr class="table-row-total">'
            mainHtml += '<td class="total">'
            mainHtml += '<div class="cell-padding">'
            mainHtml += '合计'
            mainHtml += '</div>'
            mainHtml += '</td>'


            $j.each(total_d, function(k, v){
                mainHtml += '<td class="cell-right min-width">'
                mainHtml += v
                mainHtml += '</td>'
            })
            mainHtml += '</tr>'
            $j('#deviceMain').html(mainHtml)
            $j('#totalRate').html(getRate(total.upRate + total.nextRate))
            
            switch (showDevice) {
                case 'host':
                    showHostDevice()
                    break;
                case 'MAC':
                    showMACDevice()
                    break;
                case 'ip':
                    showIpDevice()
                    break;
            }
            $j('[data-toggle="tooltip"]').tooltip()
            $j('.popover_top').popover({placement: 'right'});

        }
    })
}

function switchoverDeviceName() {
    var host = $j('.hostDevice').is(':hidden')
    var MAC = $j('.MACDevice').is(':hidden')
    var ip = $j('.ipDevice').is(':hidden')

    var hintDevice = $('#hintDevice label')

    if (MAC && ip) {
        $j('.hostDevice').hide()
        $j('.MACDevice').show()
        $j('.ipDevice').hide()
        // hintDevice.removeClass('active')
        // hintDevice.eq(1).addClass('active')
        return
    }
    if (ip && host) {
        $j('.hostDevice').hide()
        $j('.MACDevice').hide()
        $j('.ipDevice').show()
        // hintDevice.removeClass('active')
        // hintDevice.eq(2).addClass('active')
        return
    }
    if (host && MAC) {
        $j('.hostDevice').show()
        $j('.MACDevice').hide()
        $j('.ipDevice').hide()
        // hintDevice.removeClass('active')
        // hintDevice.eq(0).addClass('active')
        return
    }
}

function showHostDevice() {
    showDevice = 'host'
    $j('.hostDevice').show()
    $j('.MACDevice').hide()
    $j('.ipDevice').hide()
    hintDeviceActive(0)
}
function showMACDevice() {
    showDevice = 'MAC'
    $j('.hostDevice').hide()
    $j('.MACDevice').show()
    $j('.ipDevice').hide()
    hintDeviceActive(1)
}
function showIpDevice() {
    showDevice = 'ip'
    $j('.hostDevice').hide()
    $j('.MACDevice').hide()
    $j('.ipDevice').show()
    hintDeviceActive(2)
}

function hintDeviceActive(index) {
    var hintDevice = $j('#hintDevice label')
    hintDevice.removeClass('active')
    hintDevice.eq(index).addClass('active')
}


function initial(){

    show_banner(1);
    show_menu(5,9,get_page_id());
    show_footer();
    
    getData();

    var num = 10
    var showDevice = 'host';
    $j('#num').html(num)
    setInterval(function(){
        num--
        $j('#num').html(num)
        if (num == 0) {
            getData()
            num = 10
        }
    }, 1000)



}

function get_page_id(){
    var page_id = 7
    if (support_5g_radio())
        page_id += 1;
    return page_id;
}

</script>
        <style>
.nav-tabs > li > a {
    padding-right: 6px;
    padding-left: 6px;
}
</style>
</head>

<body onload="initial();" >

        <div class="wrapper">
            <div class="container-fluid" style="padding-right: 0px">
                <div class="row-fluid">
                    <div class="span3">
                        <center>
                            <div id="logo"></div>
                        </center>
                    </div>
                    <div class="span9" >
                        <div id="TopBanner"></div>
                    </div>
                </div>
            </div>

            <div id="Loading" class="popup_bg"></div>

            <iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

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
                                    <h2 class="box_head round_top">
                                        <#menu5_9#>- 流量监控</h2>
                                    <div class="round_bottom">
                                        <div class="row-fluid">
                                            <div id="tabMenu" class="submenuBlock"></div>

                                            <div class="alert alert-info" style="margin: 10px;">
                                                目前不支持SS通道流量监控，也没有打算增加。HWNAT会让统计数据不准确，但没必要去关闭HWNAT，这会降低你的网速和增加CPU负担。
                                        </div>
                                        <table class="table table-striped table-hover table-condensed table-padding" ng-class="{'table-compact': displayDensity === 'Compact'}">
                                            <tr class="table-heading">
                                                <th>
                                                    <div class="cell-padding">设备</div>
                                                </th>
                                                <th class="cell-right min-width clickable" onclick='javascript:setCookie("dsort",4,365);getData();'>
                                                        <i class="icon-circle-arrow-down"></i>下行流量
                                                </th>
                                                <th class="cell-right min-width clickable" onclick='javascript:setCookie("dsort",0,365);getData();'>
                                                        <i class="icon-circle-arrow-down"></i>上行流量
                                                </th>
                                                <th class="cell-right min-width clickable" onclick='javascript:setCookie("dsort",3,365);getData();'>
                                                    <i class="icon-circle-arrow-down"></i>总流量
                                                </th>
                                                <th class="cell-right min-width clickable" onclick='javascript:setCookie("dsort",1,365);getData();'>
                                                        <i class="icon-circle-arrow-down"></i>下行速率
                                                </th>
                                                <th class="cell-right min-width clickable" onclick='javascript:setCookie("dsort",2,365); getData();'">
                                                        <i class="icon-circle-arrow-down"></i>上行速率
                                                </th>
                                            </tr>

                                            <tbody id="deviceMain"></tbody>

                                            <tr class="table-row-total">
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td class="cell-right min-width">速率总和</td>
                                            </td>

                                            <td class="cell-right min-width" id="totalRate"></td>
                                        </tr>
                                        <tr></tr>
                                    </table>

                                    <div class="bottom-controls">
                                        <div class="left" style="width:260px;">
                                            <div class="controls">
                                                <div class="btn-group" data-toggle="tooltip" 
                            data-placement="right"
                            title="设备栏双击可直接切换."
                            id="hintDevice">
                                                    <label onclick="showHostDevice()" class="btn btn-default" ng-model="displayNameType" btn-radio="'NAME'">设备名</label>
                                                    <label onclick="showMACDevice()" class="btn btn-default" ng-model="displayNameType" btn-radio="'MAC'">MAC</label>
                                                    <label onclick="showIpDevice()" class="btn btn-default" ng-model="displayNameType" btn-radio="'IP'">IP</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="update-counter" ng-hide="serviceEnabled" style=" min-width:75px;">
                                            更新倒数:
                                            <span id="num"></span>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="footer"></div>
</div>
</body>
</html>
