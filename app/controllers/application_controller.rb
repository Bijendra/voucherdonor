class ApplicationController < ActionController::Base
  protect_from_forgery  
  helper_method :check_credential
  def check_credential           
    admin_emails = ["rishabh1923@gmail.com","bijendra.bijju@gmail.com","sagar_krupa2000@yahoo.co.in","raghvendrasinghfb1501@gmail.com"]
    if((request.format != :json) && current_user.present? && (!(admin_emails.include? current_user.email)))
      redirect_to root_url
    end    
  end

   def after_sign_in_path_for(resource)
     #post_login_path
     root_path
   end

   def after_sign_up_path_for(resource)
     "http://localhost:3000/"
     # <- Path you want to redirect the user to after signup
   end 
end
