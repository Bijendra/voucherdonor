var vendor_str = "";
chrome.tabs.getSelected(null, function(tab) {
    var cur_url = tab.url;				   
    if(cur_url.match(/myntra.com/i) != null) {
	vendor_str = "&vid=10";
    } else if(cur_url.match(/snapdeal.com/i) != null) {
	vendor_str = "&vid=20";
    } else if(cur_url.match(/cafecoffeeday.com/i) != null) {
	vendor_str = "&vid=30";
    } else if(cur_url.match(/kfc.co.in/i) != null) {
	vendor_str = "&vid=40";
    }
});		

chrome.cookies.get({ url: 'http://localhost:3000/', name: 'vd' },
		   function (cookie) {
		       if(cookie) {
			 var uid = cookie.value;
			   if((uid != null) && (uid.length > 0)) {
			       var vendor = {
				   10: "Myntra",
				   20: "Snapdeal",
				   30: "Cafe Coffee Day",
				   40: "KFC"				   
			       }
			       document.getElementById("login").style.display="none"; 
			       document.getElementById("feeds").style.display=""; 
			       var xhr = new XMLHttpRequest();
			       var url = "http://localhost:3000/coupons.json?browser=true&uid="+uid+vendor_str
			       xhr.open("GET", url, true);
			       xhr.onreadystatechange = function() {
				   if (xhr.readyState == 4) {
				       // innerText does not let the attacker inject HTML elements.
				       var feeds_res = xhr.responseText;
				       var feeds = JSON.parse(feeds_res);
				       var html = "";
				       if((feeds != null) && (feeds.length > 0)) {
					   for(var i=0;i<feeds.length;i++) {
					       var feed = feeds[i];
					       html += feed["user_name"]+"'s coupon for "+vendor[feed["coupon_vendor"]]+" expires at "+feed["expire_text"]+", <a target='_blank' href='http://localhost:3000/coupons/"+feed["_id"]+"'>Grab it now</a><br>"
					   }
				       }
				       if(html.length == 0) {
					   html = "No coupon available for you"
				       }
				       document.getElementById("feeds").innerHTML = html
				   }
			       }
			       xhr.send();
			   }			   
		       }
		       else {
		       }
		   });