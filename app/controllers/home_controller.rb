class HomeController < ApplicationController
  def show
    redirect_to lists_path if signed_in?
  end
end
