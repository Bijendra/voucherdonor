class Coupon	
  include Mongoid::Document
  include Mongoid::Timestamps

  #field :user_id, type: String
  field :coupon_vendor, type: String
  field :expire_at, type: Time
  field :status, type: Integer
  field :used_by, type: String
  field :type, type: Integer
  field :code, type: String
  field :user_name, type: String
  field :expire_text, type: String

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

end
