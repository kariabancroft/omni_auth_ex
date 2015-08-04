class User < ActiveRecord::Base
  validates :email, :username, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user
    auth_email = auth_hash[:info]? auth_hash[:info][:email] : nil
    if !auth_email.nil?
      user = self.find_by(email: auth_email)
      if user.nil?
        return self.create_from_omniauth(auth_hash)
      else
        user
      end
    end
  end

  def self.create_from_omniauth(auth_hash)
    user = self.new
    user.username = auth_hash[:info][:name]
    user.email = auth_hash[:info][:email]
    user.uid = auth_hash[:uid]
    user.provider = auth_hash[:provider]
    user.save

    return user
  end
end
