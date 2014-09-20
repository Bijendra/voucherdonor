class Friend
  include Mongoid::Document
  field :user_id, type: String
  field :friend_id, type: String
  field :friend_fb_id, type: String
  field :status, type: Integer, default: 0
  field :name, type: String

  STATUS_FB = 0
  STATUS_DELETED = -100

  STATUS_NAMES = {
    STATUS_FB => "Facebook",
    STATUS_DELETED => "Deleted" 
  }

end
