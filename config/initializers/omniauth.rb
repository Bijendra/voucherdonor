Rails.application.config.middleware.use OmniAuth::Builder do    
    provider :facebook, '590181674401726', 'c8a6f327a054175cb0451984b751b97d', {:scope => "email, user_location, user_interests"}
  # provider :open_id, OpenID::Store::Filesystem.new('/tmp')                                                                                         
  # provider :linkedin, "consumer_key", "consumer_secret"                                                                                         
end