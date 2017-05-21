class TaskWithCompletion < ApplicationRecord
  belongs_to :list

  private

  def readonly?
    true
  end
end
