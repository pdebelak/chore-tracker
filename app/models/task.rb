class Task < ApplicationRecord
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

  def weekly?
    schedule == WEEKLY
  end

  def monthly?
    schedule == MONTHLY
  end

  def complete!(user)
    completions.create! user: user
  end
end
