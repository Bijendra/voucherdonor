class Authentication
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :access_token, type: String
  belongs_to :user

  def self.assign_social_data_to_user(user, omniauth, force_update = false)
    require 'open-uri'
    begin
      ######################################################################
      # add fields to populate from facebook data
      if(omniauth['provider'].to_s == "facebook")
        if(omniauth['info']['last_name'].present?)
          user.last_name = omniauth['info']['last_name']
        end
        
        if(omniauth['info']['first_name'].present?)
          user.first_name = omniauth['info']['first_name']
        end
        
        if(omniauth['info']['image'].present?)
          user.profile_pic_url = omniauth['info']['image']
        end
        
        if(omniauth['info']['urls']['Facebook'].present?)
          user.facebook_url = omniauth['info']['urls']['Facebook']
        end

      end

    rescue Exception => ex 
      logger.info("\n\n#{ex.to_s}\n\n")
      logger.info("\n\n#{ex.backtrace}\n\n")
    end
    return user
  end
end
