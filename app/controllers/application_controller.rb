class ApplicationController < ActionController::Base
   protect_from_forgery
   

   def after_sign_in_path_for(resource)
     post_login_path
  end

  def after_sign_up_path_for(resource)
    "http://localhost:3000/"
     # <- Path you want to redirect the user to after signup
  end 
end
