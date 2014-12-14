Rails.application.config.middleware.use OmniAuth::Builder do    
  if(Rails.env.development?)
    provider :facebook, '179716845394813', 'bdfca7d1c57344d6deec30f95e70d8f0', {:scope => "email, user_location, user_interests, user_likes, user_friends,manage_friendlists "}      
  else
    provider :facebook, '406135692869624', '1053ff9e1ebcfc1f10da2a69e606b20c', {:scope => "email, user_location, user_interests, user_likes, user_friends,manage_friendlists "}      
  end
end
