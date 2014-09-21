function createCookie(name, value, days) {
    var expires;
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    }
    else {
        expires = "";
    }
    document.cookie = name + "=" + value + expires + "; path=/";
}

function getCookie(c_name) {
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(c_name + "=");
        if (c_start != -1) {
            c_start = c_start + c_name.length + 1;
            c_end = document.cookie.indexOf(";", c_start);
            if (c_end == -1) {
                c_end = document.cookie.length;
            }
            return unescape(document.cookie.substring(c_start, c_end));
        }
    }
    return "";
}
function ele(id) {
    return document.getElementById(id);
}

function ele_show(id) {
    document.getElementById(id).style.display="";
}

function ele_hide(id) {
    document.getElementById(id).style.display="none";
}

function ele_toggle(id) {
    if(document.getElementById(id).style.display=="none") {
	document.getElementById(id).style.display="";
    } else {
	document.getElementById(id).style.display="none";
    }
}

function submit_ajax_form(id) {
    $("#"+id).trigger("submit.rails");
}

function get_hash_keys(hsh) {
    var keys = [];
    for(var i in hsh) { if (hsh.hasOwnProperty(i)) keys.push(i); }
    return keys;
}
