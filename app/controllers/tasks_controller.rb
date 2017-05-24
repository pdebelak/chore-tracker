class TasksController < ApplicationController
  require_user

  def show
    @list = list
    @task = list.task_with_completions.find params[:id]
  end

  def new
    @task = list.tasks.new
  end

  def create
    @task = list.tasks.create task_params
    if @task.valid?
      flash[:success] = "Task created"
      redirect_to list_path list
    else
      render :new
    end
  end

  def edit
    @task = find_task
  end

  def update
    @task = find_task
    if @task.update task_params
      flash[:success] = "Task updated"
      redirect_to list_path(list)
    else
      render :edit
    end
  end

  def destroy
    find_task.destroy!
    flash[:success] = "Task deleted"
    redirect_to list_path(list)
  end

  private

  def task_params
    params.require(:task).permit :description, :schedule
  end

  def find_task
    list.tasks.find params[:id]
  end

  def list
    @_list ||= current_user.lists.find params[:list_id]
  end
end
