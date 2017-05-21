class ListsController < ApplicationController
  require_user

  def index
    @lists = current_user.lists
  end

  def show
    @list = find_list
  end

  def new
    @list = current_user.lists.new
  end

  def create
    @list = current_user.lists.create list_params
    if @list.valid?
      redirect_to lists_path
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
      redirect_to lists_path
    else
      render :edit
    end
  end

  def destroy
    find_list.destroy!
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit :name
  end

  def find_list
    current_user.lists.find params[:id]
  end
end
