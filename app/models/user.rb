class User < ApplicationRecord
  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.name = auth.info.name
      user.image_url = auth.info.image
      user.save!
    end
  end
end
