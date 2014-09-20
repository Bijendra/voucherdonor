_.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};

var userCoupons;
var userFriends;
var userCouponsHash = {};
var userFriendsHash = {};

var Coupon = Backbone.Model.extend({
    url: function() {
	var base = 'coupons';
	if(this.isNew()) return base;
	return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.id;
    }
});
var Friend = Backbone.Model.extend({
    url: function() {
	var base = 'friends';
	if(this.isNew()) return base;
	return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.id;
    }
});

var Coupons = Backbone.Collection.extend({
    model: Coupon,
    url: function() {
	base_url = '/coupons';
	if(this.uid != null) 
	    base_url += '?uid='+this.uid;
	return base_url;
    },
    initialize: function(uid) {
	this.uid = uid;
    },
    setUid: function(uid) {
	this.uid = uid;
    }
});

var Friends = Backbone.Collection.extend({
    model: Friend,
    url: function() {
	base_url = '/friends';
	if(this.uid != null) 
	    base_url += '?uid='+this.uid;
	return base_url;
    },
    initialize: function(uid) {
	this.uid = uid;
    },
    setUid: function(uid) {
	this.uid = uid;
    }
});	    	    

var load = function() {
    ele_show("loading");
    userCoupons = new Coupons(uid);
    userCoupons.setUid(uid);
    userCoupons.fetch({
	success: function() {
	    ele_hide("loading");
	    updateCoupons();
	    prepareCouponsView();
	},         
	error: function() {
	}
    });
    
    userFriends = new Friends(uid);
    userFriends.setUid(uid);
    userFriends.fetch({
	success: function() {
	    updateFriends();
	    prepareFriendsView();
	},         
	error: function() {
	}
    });
};

function updateCoupons() {
    if(userCoupons.length > 0) {
	userCouponsHash = {};
	userCoupons.each(function(obj) {
	    userCouponsHash[obj.get("_id")] = obj;
	});
    }
}

function updateFriends() {
    if(userFriends.length > 0) {
	userFriendsHash = {};
	userFriends.each(function(obj) {
	    userFriendsHash[obj.get("_id")] = obj;
	});
    }
}

function prepareFriendsView() {
    var friendsIds = get_hash_keys(userFriendsHash);    
    if(friendsIds.length > 0) {
	var html = "";
	for(var i=0;i<friendsIds.length;i++) {
	    var friendObj = userFriendsHash[friendsIds[i]];
	    if(friendsIds != null) {
		var pic_url = "http://graph.facebook.com/"+friendObj.get("friend_fb_id")+"/picture?width=125&height=125";
		console.log(pic_url);
		var variable = { pic: pic_url};
		html += _.template($("#userIcon").html(), variable);		    
	    }
	}
	ele("friends-area").innerHTML = html;
    }
}

function prepareCouponsView() {
    
}