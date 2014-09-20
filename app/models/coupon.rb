class Coupon	
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String
  field :coupon_vendor, type: String
  field :expire_at, type: Time
  field :status, type: Integer
  field :used_by, type: String
  field :type, type: Integer
end
