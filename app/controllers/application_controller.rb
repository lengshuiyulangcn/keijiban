class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find_by_token(cookies[:token]) if cookies[:token]
  end
  def login_needed
  	if !current_user
  		redirect_to :login
  	end
  end

  helper_method :current_user,:login_needed
end