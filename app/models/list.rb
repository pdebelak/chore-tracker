class List < ApplicationRecord
  has_many :users_lists
  has_many :users, through: :users_lists
  has_many :tasks
  has_many :task_with_completions

  validates :name, presence: true

  def add_user!(user)
    users << user
  end
end
