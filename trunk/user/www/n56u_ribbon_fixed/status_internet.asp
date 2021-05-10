<% detect_internet(); %>
var now_wan_internet = '<% nvram_get_x("", "link_internet"); %>';
var now_ss_internet = '<% nvram_get_x("", "ss_internet"); %>';
var now_vpnc_state = '<% nvram_get_x("", "vpnc_state_t"); %>';
