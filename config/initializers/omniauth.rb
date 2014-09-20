Rails.application.config.middleware.use OmniAuth::Builder do    
    provider :facebook, '179716845394813', 'bdfca7d1c57344d6deec30f95e70d8f0', {:scope => "email, user_location, user_interests, user_likes, user_friends "}
  # provider :open_id, OpenID::Store::Filesystem.new('/tmp')                                                                                         
  # provider :linkedin, "consumer_key", "consumer_secret"                                                                                         
end