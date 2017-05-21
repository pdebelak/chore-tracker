class User < ApplicationRecord
  has_many :users_lists
  has_many :lists, through: :users_lists
  has_many :completions

  validates :email, presence: true
  validates :name, presence: true

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.name = auth.info.name
      user.image_url = auth.info.image
      user.save!
    end
  end

  def self.except_user(user)
    where.not(id: user.id)
  end
end
