#encoding:utf-8
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

  def is_admin
    if current_user and current_user.name==ENV["ADMIN"]
      return true
    else
      return false
    end
  end
   def format_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end

  def format_date(time)
    time.strftime("%Y.%m.%d")
  end
  helper_method :current_user,:login_needed, :is_admin, :format_date, :format_time
end