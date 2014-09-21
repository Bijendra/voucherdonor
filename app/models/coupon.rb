class Coupon	
  include Mongoid::Document
  include Mongoid::Timestamps

  #field :user_id, type: String
  field :coupon_vendor, type: String
  field :expire_at, type: Time
  field :status, type: Integer, default: 0
  field :used_by, type: String
  field :type, type: Integer
  field :desc, type: String
  field :code, type: String
  field :user_name, type: String
  field :expire_text, type: String
  field :fb_id, type: String

  belongs_to :user
  
  VENDOR_MYNTRA = 10
  VENDOR_SNAPDEAL = 20
  VENDOR_CCD = 30
  VENDOR_KFC = 40

  VENDOR_NAMES = {
    VENDOR_MYNTRA => "Myntra",
    VENDOR_SNAPDEAL => "Snapdeal",
    VENDOR_CCD => "Cafe Coffee Day",
    VENDOR_KFC => "KFC"
  }

  COUPON_ACTIVE = 0
  COUPON_INACTIVE = -100

  COUPON_STATUS = {
  	COUPON_ACTIVE => "Active Coupon",
  	COUPON_INACTIVE => "Inactive Coupon"
  }
  
  def self.check_validity_of_coupons
    @g = Koala::Facebook::API.new(Koala::Facebook::OAuth.new("179716845394813","bdfca7d1c57344d6deec30f95e70d8f0").get_app_access_token)
    Coupon.all.each do |coupon|
    #   coupon.expires
      if (Date.today + 1).strftime("%Y-%m-%d") > coupon.expire_at.strftime("%Y-%m-%d")
        @g.put_connections(coupon.user.facebook_uid, "notifications", template: "Checkout your friends discount coupon ", href: "http://localhost:3000")    
      end  
    end
  end  

end
