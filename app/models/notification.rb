class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  field :coupon_id, type: String
  field :status, type: Integer

  #belongs_to: user
  #has_one: coupon

end
