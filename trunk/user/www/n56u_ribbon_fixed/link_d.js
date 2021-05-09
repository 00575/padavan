// app_24.sh
// app_25.sh
function link_d(link_url){
ss_name_d = '';
ss_server_d = '';
ss_port_d = '';
ss_password_d = '';
ss_method_d = '';
ss_usage_d = '';
ss_type_d = '';
app_71_d = '';
app_72_d = '';
app_73_d = '';
app_74_d = '';
app_75_d = '';
app_76_d = '';
app_77_d = '';
app_78_d = '';
app_79_d = '';
app_80_d = '';
app_81_d = '';
ssr_d_protocol = '';
ssr_d_obfs = '';
var link = link_url;
if(link.indexOf('ss://') != -1){
	if(link.indexOf('vmess://') == -1){
		if(link.indexOf('#') != -1){
			var decodeLink1 = link.split('#');
			ss_name_d = decodeURIComponent(decodeLink1[1]);
			var decodeLink = decodeLink1[0].replace('ss://', '');
		}else{
			var decodeLink = link.replace('ss://', '');
		}
		if(decodeLink.indexOf('@') != -1){
			var decodeLink1 = decodeLink.split('@');
			var decodeLink = Base64.decode(decodeLink1[0]) + '@' + decodeLink1[1];
		}else{
			var decodeLink = Base64.decode(decodeLink);
		}
		var plugin_opts = '';
		var param = decodeLink.substring(decodeLink, decodeLink.indexOf('/?'));
		if (String(param) != ""){
			var ex_param = decodeLink.substring(decodeLink.indexOf('/?') + 2);
			var ex_params = String(ex_param);
			var params = decodeLink.split('/?')[0].split('@');
		}else{
			var param = decodeLink.substring(decodeLink, decodeLink.indexOf('?'));
			if (String(param) != ""){
				var ex_param = decodeLink.substring(decodeLink.indexOf('?') + 1);
				var ex_params = String(ex_param);
				var params = decodeLink.split('?')[0].split('@');
			}
		}
		if (String(param) != ""){
			var patt1=/plugin\=[^\&#]+/;
			var ex_plugin=String(ex_params.match(patt1));
			var plugin_opts = String(ex_plugin.split('=')[1]);
			var plugin_opts = decodeURIComponent(plugin_opts);
			var plugin_opts = ' --plugin ' + plugin_opts;
			var plugin_opts = plugin_opts.replace(';', ' --plugin-opts ');
		}else{
			var plugin_opts = ' --plugin --plugin-opts ';
			var params = decodeLink.split('@');
		}
		
		
		
		var methodPasswdParams = params[0].split(':');
		var serverParams = params[1].split(':');
		
		if (String(ss_name_d) == ""){
			ss_name_d = '♯' + serverParams[0];
		}
		
		ss_server_d = serverParams[0];
		ss_port_d = serverParams[1];
		ss_password_d = methodPasswdParams[1];
		ss_method_d = methodPasswdParams[0];
		ss_usage_d = ' -O origin -o plain -G -g ' + plugin_opts;
		ss_type_d = 'ss';
		ssr_d_protocol = "origin";
		ssr_d_obfs = "plain";
	}
}

if(link.indexOf('ssr://') != -1){
	var decodeLink = Base64.decode(link.replace('ssr://', ''));
	var param = decodeLink.substring(decodeLink, decodeLink.indexOf('/?'));
	if (String(param) != ""){
		var ex_param = decodeLink.substring(decodeLink.indexOf('/?') + 2);
	}else{
		var param = decodeLink.substring(decodeLink, decodeLink.indexOf('?'));
		if (String(param) != ""){
			var ex_param = decodeLink.substring(decodeLink.indexOf('?') + 1);
		}
	}
	if (String(param) != ""){
		var params = param.split(':');
	}else{
		var param = String(decodeLink);
		var params = param.split(':');
		var ex_param = "";
	}
	var ex_params = String(ex_param);

	var patt1=/obfsparam\=[^\&]+/;
	var patt2=/protoparam\=[^\&]+/;
	var patt3=/remarks\=[^\&]+/;
	var patt4=/group\=[^\&]+/;
	var ex_obfsparam=String(ex_params.match(patt1));
	var ex_protoparam=String(ex_params.match(patt2));
	var ex_remarks=String(ex_params.match(patt3));
	var ex_group=String(ex_params.match(patt4));
	
	
	if (String(ex_remarks) != "null"){
		ss_name_d = Base64.decode(ex_remarks.split('=')[1]);
	}else{
		ss_name_d = '♯' + params[0];
	}
	ss_server_d = params[0];
	ss_port_d = params[1];
	ss_password_d = Base64.decode(params[5]);
	ss_method_d = params[3];
	if(params[4] == "tls1.2_ticket_fastauth"){
		params[4] = "tls1.2_ticket_auth";
	}
	ssr_d_protocol = params[2];
	ssr_d_obfs = params[4];
	//if (params[2] == "origin" && params[4] == "plain"){
	//	ss_type_d = 'ss';
	//	ss_usage_d = ' -O ' + params[2] + ' -o ' + params[4];
	//	ss_usage_d = ss_usage_d + ' -G -g '
	//} else {
		ss_type_d = 'ssr';
		ss_usage_d = ' -O ' + params[2] + ' -o ' + params[4];
		ss_usage_d = ss_usage_d + ' -G '
		if (String(ex_protoparam) != "null"){
			ss_usage_d = ss_usage_d + Base64.decode(ex_protoparam.split('=')[1]);
		}
		ss_usage_d = ss_usage_d + ' -g '
		if (String(ex_obfsparam) != "null"){
			ss_usage_d = ss_usage_d + Base64.decode(ex_obfsparam.split('=')[1]);
		}
	//}
	ss_usage_d = ss_usage_d + ' --plugin --plugin-opts '
}
if(link.indexOf('vmess://') != -1){
	var decodeLink = Base64.decode(link.replace('vmess://', ''));
	var obj = JSON.parse(decodeLink);

	app_71_d = obj.v;
	if (String(obj.ps) != ""){
		app_72_d = obj.ps;
	}else{
		app_72_d = '♯' + obj.add;
	}
	app_73_d = obj.add;
	app_74_d = obj.port;
	app_75_d = obj.id;
	app_76_d = obj.aid;
	app_77_d = obj.net;
	app_78_d = obj.type;
	app_79_d = obj.host;
	app_80_d = obj.path;
	app_81_d = obj.tls;
	ss_type_d = 'vmess';
}
}

function decodeUnicode(str){
	str = str.replace(/\\/g, "%");
	return unescape(str);
}

function base64decode(code){
if(code.indexOf('🔐📐') != -1){
var decode1 = code.replace('🔗', '');
var decode1 = decode1.replace('🔐📐', '');
var decode1 = decode1.replace('📐🔐', '');
var decode2 = Base64.decode(decode1);
	if(code.indexOf('🔗') != -1){
		return '🔗' + decode2;
	}
	return decode2;
}else{
	return code;
}
}
;(function (global, factory) {
    typeof exports === 'object' && typeof module !== 'undefined'
        ? module.exports = factory(global)
        : typeof define === 'function' && define.amd
        ? define(factory) : factory(global)
}((
    typeof self !== 'undefined' ? self
        : typeof window !== 'undefined' ? window
        : typeof global !== 'undefined' ? global
: this
), function(global) {
    'use strict';
    // existing version for noConflict()
    global = global || {};
    var _Base64 = global.Base64;
    var version = "2.5.2";
    // if node.js and NOT React Native, we use Buffer
    var buffer;
    if (typeof module !== 'undefined' && module.exports) {
        try {
            buffer = eval("require('buffer').Buffer");
        } catch (err) {
            buffer = undefined;
        }
    }
    // constants
    var b64chars
        = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    var b64tab = function(bin) {
        var t = {};
        for (var i = 0, l = bin.length; i < l; i++) t[bin.charAt(i)] = i;
        return t;
    }(b64chars);
    var fromCharCode = String.fromCharCode;
    // encoder stuff
    var cb_utob = function(c) {
        if (c.length < 2) {
            var cc = c.charCodeAt(0);
            return cc < 0x80 ? c
                : cc < 0x800 ? (fromCharCode(0xc0 | (cc >>> 6))
                                + fromCharCode(0x80 | (cc & 0x3f)))
                : (fromCharCode(0xe0 | ((cc >>> 12) & 0x0f))
                    + fromCharCode(0x80 | ((cc >>>  6) & 0x3f))
                    + fromCharCode(0x80 | ( cc         & 0x3f)));
        } else {
            var cc = 0x10000
                + (c.charCodeAt(0) - 0xD800) * 0x400
                + (c.charCodeAt(1) - 0xDC00);
            return (fromCharCode(0xf0 | ((cc >>> 18) & 0x07))
                    + fromCharCode(0x80 | ((cc >>> 12) & 0x3f))
                    + fromCharCode(0x80 | ((cc >>>  6) & 0x3f))
                    + fromCharCode(0x80 | ( cc         & 0x3f)));
        }
    };
    var re_utob = /[\uD800-\uDBFF][\uDC00-\uDFFFF]|[^\x00-\x7F]/g;
    var utob = function(u) {
        return u.replace(re_utob, cb_utob);
    };
    var cb_encode = function(ccc) {
        var padlen = [0, 2, 1][ccc.length % 3],
        ord = ccc.charCodeAt(0) << 16
            | ((ccc.length > 1 ? ccc.charCodeAt(1) : 0) << 8)
            | ((ccc.length > 2 ? ccc.charCodeAt(2) : 0)),
        chars = [
            b64chars.charAt( ord >>> 18),
            b64chars.charAt((ord >>> 12) & 63),
            padlen >= 2 ? '=' : b64chars.charAt((ord >>> 6) & 63),
            padlen >= 1 ? '=' : b64chars.charAt(ord & 63)
        ];
        return chars.join('');
    };
    var btoa = global.btoa ? function(b) {
        return global.btoa(b);
    } : function(b) {
        return b.replace(/[\s\S]{1,3}/g, cb_encode);
    };
    var _encode = function(u) {
        var isUint8Array = Object.prototype.toString.call(u) === '[object Uint8Array]';
        return isUint8Array ? u.toString('base64')
            : btoa(utob(String(u)));
    }
    var encode = function(u, urisafe) {
        return !urisafe
            ? _encode(u)
            : _encode(String(u)).replace(/[+\/]/g, function(m0) {
                return m0 == '+' ? '-' : '_';
            }).replace(/=/g, '');
    };
    var encodeURI = function(u) { return encode(u, true) };
    // decoder stuff
    var re_btou = /[\xC0-\xDF][\x80-\xBF]|[\xE0-\xEF][\x80-\xBF]{2}|[\xF0-\xF7][\x80-\xBF]{3}/g;
    var cb_btou = function(cccc) {
        switch(cccc.length) {
        case 4:
            var cp = ((0x07 & cccc.charCodeAt(0)) << 18)
                |    ((0x3f & cccc.charCodeAt(1)) << 12)
                |    ((0x3f & cccc.charCodeAt(2)) <<  6)
                |     (0x3f & cccc.charCodeAt(3)),
            offset = cp - 0x10000;
            return (fromCharCode((offset  >>> 10) + 0xD800)
                    + fromCharCode((offset & 0x3FF) + 0xDC00));
        case 3:
            return fromCharCode(
                ((0x0f & cccc.charCodeAt(0)) << 12)
                    | ((0x3f & cccc.charCodeAt(1)) << 6)
                    |  (0x3f & cccc.charCodeAt(2))
            );
        default:
            return  fromCharCode(
                ((0x1f & cccc.charCodeAt(0)) << 6)
                    |  (0x3f & cccc.charCodeAt(1))
            );
        }
    };
    var btou = function(b) {
        return b.replace(re_btou, cb_btou);
    };
    var cb_decode = function(cccc) {
        var len = cccc.length,
        padlen = len % 4,
        n = (len > 0 ? b64tab[cccc.charAt(0)] << 18 : 0)
            | (len > 1 ? b64tab[cccc.charAt(1)] << 12 : 0)
            | (len > 2 ? b64tab[cccc.charAt(2)] <<  6 : 0)
            | (len > 3 ? b64tab[cccc.charAt(3)]       : 0),
        chars = [
            fromCharCode( n >>> 16),
            fromCharCode((n >>>  8) & 0xff),
            fromCharCode( n         & 0xff)
        ];
        chars.length -= [0, 0, 2, 1][padlen];
        return chars.join('');
    };
    var _atob = function(a){
        return a.replace(/\S{1,4}/g, cb_decode);
    };
    var atob = function(a) {
        return _atob(String(a).replace(/[^A-Za-z0-9\+\/]/g, ''));
    };
    var _decode = buffer ?
        buffer.from && Uint8Array && buffer.from !== Uint8Array.from
        ? function(a) {
            return (a.constructor === buffer.constructor
                    ? a : buffer.from(a, 'base64')).toString();
        }
        : function(a) {
            return (a.constructor === buffer.constructor
                    ? a : new buffer(a, 'base64')).toString();
        }
        : function(a) { return btou(_atob(a)) };
    var decode = function(a){
        return _decode(
            String(a).replace(/[-_]/g, function(m0) { return m0 == '-' ? '+' : '/' })
                .replace(/[^A-Za-z0-9\+\/]/g, '')
        );
    };
    var noConflict = function() {
        var Base64 = global.Base64;
        global.Base64 = _Base64;
        return Base64;
    };
    // export Base64
    global.Base64 = {
        VERSION: version,
        atob: atob,
        btoa: btoa,
        fromBase64: decode,
        toBase64: encode,
        utob: utob,
        encode: encode,
        encodeURI: encodeURI,
        btou: btou,
        decode: decode,
        noConflict: noConflict,
        __buffer__: buffer
    };
    // if ES5 is available, make Base64.extendString() available
    if (typeof Object.defineProperty === 'function') {
        var noEnum = function(v){
            return {value:v,enumerable:false,writable:true,configurable:true};
        };
        global.Base64.extendString = function () {
            Object.defineProperty(
                String.prototype, 'fromBase64', noEnum(function () {
                    return decode(this)
                }));
            Object.defineProperty(
                String.prototype, 'toBase64', noEnum(function (urisafe) {
                    return encode(this, urisafe)
                }));
            Object.defineProperty(
                String.prototype, 'toBase64URI', noEnum(function () {
                    return encode(this, true)
                }));
        };
    }
    //
    // export Base64 to the namespace
    //
    if (global['Meteor']) { // Meteor.js
        Base64 = global.Base64;
    }
    // module.exports and AMD are mutually exclusive.
    // module.exports has precedence.
    if (typeof module !== 'undefined' && module.exports) {
        module.exports.Base64 = global.Base64;
    }
    else if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define([], function(){ return global.Base64 });
    }
    // that's it!
    return {Base64: global.Base64}
}));