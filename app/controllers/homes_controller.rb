class HomesController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :about]
  def index
  end
  
  def post_login
  end 	
  
  def about
  end

end
