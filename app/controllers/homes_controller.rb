class HomesController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index]
  def index
  end
  
  def post_login
  end 	
end
