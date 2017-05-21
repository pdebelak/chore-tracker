class TaskWithCompletion < ApplicationRecord
  include Schedulable

  self.primary_key = :id

  belongs_to :list

  class GroupedByCompletion
    attr_reader :completed, :not_completed

    def initialize(groupings)
      @completed = groupings[true]
      @not_completed = groupings[false]
    end
  end

  def self.grouped_by_completion
    GroupedByCompletion.new(all.to_a.group_by { |t| t.complete? })
  end

  def complete?
    return false if last_completed_at.blank?
    if weekly?
      last_completed_at >= Time.now.beginning_of_week
    elsif monthly?
      last_completed_at >= Time.now.beginning_of_month
    end
  end

  private

  def readonly?
    true
  end
end
