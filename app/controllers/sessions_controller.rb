class SessionsController < ApplicationController
  def create
    user = User.from_omniauth request.env["omniauth.auth"]
    session[:user_id] = user.id
    flash[:success] = "You are now logged in!"
    redirect_to lists_path
  end

  def failure
    flash[:error] = "There was an issue logging you in"
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You are now logged out"
    redirect_to root_path
  end
end
