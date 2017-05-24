class CompletionsController < ApplicationController
  require_user

  def create
    task.complete! current_user
    redirect_to list_path task.list
  end

  def destroy
    task.completions.find(params[:id]).destroy!
    redirect_to list_path task.list
  end

  private

  def task
    @_task ||= current_user
      .lists.find(params[:list_id])
      .tasks.find(params[:task_id])
  end
end
