class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def current_user
    @_current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def signed_in?
    current_user.present?
  end
end
