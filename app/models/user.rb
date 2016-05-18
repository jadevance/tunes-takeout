# require-relative '../../lib/TunesTakeoutWrapper.rb'

class User < ActiveRecord::Base
  validates :display_name, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user
    user = self.find_by(id: auth_hash["info"]["id"], provider: auth_hash["provider"])
    
    if !user.nil?
      return user 
    else
     user = User.new
     user.uid           = auth_hash["info"]["id"]
     user.display_name  = auth_hash["info"]["display_name"]
     user.email         = auth_hash["info"]["email"]
     user.provider      = auth_hash["provider"]

      if user.save 
        return user
      else
        return nil
      end 
    end
  end
end
