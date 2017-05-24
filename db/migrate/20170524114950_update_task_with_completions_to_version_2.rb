class UpdateTaskWithCompletionsToVersion2 < ActiveRecord::Migration[5.0]
  def change
    update_view :task_with_completions, version: 2, revert_to_version: 1
  end
end
