class List < ApplicationRecord
  has_many :users_lists
  has_many :users, through: :users_lists

  validates :name, presence: true
end
