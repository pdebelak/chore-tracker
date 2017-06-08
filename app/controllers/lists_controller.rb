class ListsController < ApplicationController
  require_user

  def index
    @lists = current_user.lists
  end

  def show
    @list = find_list
    @grouped_tasks = @list.task_with_completions.grouped_by_completion
    @users = @list.users.except_user(current_user)
    respond_to do |format|
      format.html
      format.js { render "tasks/refresh_tasks" }
    end
  end

  def new
    @list = current_user.lists.new
  end

  def create
    @list = current_user.lists.create list_params
    if @list.valid?
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def edit
    @list = find_list
  end

  def update
    @list = find_list
    if @list.update list_params
      flash[:success] = "List updated"
      redirect_to list_path(@list)
    else
      render :edit
    end
  end

  def destroy
    find_list.destroy!
    flash[:success] = "List deleted"
    redirect_to lists_path
  end

  def add_user
    @list = find_list
    user = User.find_by email: params[:list][:user_email]
    if user.present?
      @list.add_user! user
      flash[:success] = "That person was added to the list!"
      redirect_to list_path(@list)
    else
      flash.now[:error] = "That person could not be found."
      render :edit
    end
  end

  private

  def list_params
    params.require(:list).permit :name
  end

  def find_list
    current_user.lists.find params[:id]
  end
end
