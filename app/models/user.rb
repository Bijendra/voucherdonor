class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
  field :first_name, :type => String, :default => ""
  field :middle_name, :type => String, :default => ""
  field :last_name, :type => String, :default => ""
  field :profile_pic_url, :type => String, :default => ""
  field :facebook_url, :type => String, :default => ""
  # field :fb_raw_info, :type => String
  field :location, :type => String
  field :facebook_uid , :type => String

  has_many :authentications
  has_many :coupons
  ## Confirmable
  # field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time
  
  def full_name
    return "#{first_name} #{last_name}"
  end

  def apply_omniauth(omniauth)
    token = ""
    token = omniauth['credentials']['token'] if(omniauth['credentials'].present? && omniauth['credentials']['token'].present?)
    auth = authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :access_token => token)
    return auth
  end
end
