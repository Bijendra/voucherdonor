class Friend
  include Mongoid::Document
  field :user_id, type: String
  field :friend_id, type: String
  field :friend_fb_id, type: String
  field :status, type: Integer
end
