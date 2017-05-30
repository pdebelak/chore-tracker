class Task < ApplicationRecord
  include Schedulable

  SCHEDULES = [
    WEEKLY = "weekly".freeze,
    MONTHLY = "monthly".freeze,
  ]

  belongs_to :list
  has_many :completions

  validates :description, presence: true
  validates :schedule, presence: true, inclusion: { in: SCHEDULES }

  def self.schedules
    SCHEDULES
  end

  def complete!(user)
    completions.create! user: user
  end

  def with_completion
    if persisted?
      TaskWithCompletion.find(id)
    else
      TaskWithCompletion.new(attributes)
    end
  end
end
