class UsersController < ApplicationController
  def welcome
    login_needed
  end

  def signup
     if current_user
      redirect_to :root
     else
  	   @user = User.new
     end
  end

  def login
    if current_user
      redirect_to root_url
    end
  end
  def weibologin
    client = WeiboOAuth2::Client.new
    redirect_to client.authorize_url
  end

  def callback
    @user = User.new
    client = WeiboOAuth2::Client.new
    access_token = client.auth_code.get_token(params[:code].to_s)
    cookies.permanent[:uid] = access_token.params["uid"]
    cookies.permanent[:token] = access_token.token
    cookies.permanent[:expires_at] = access_token.expires_at
    user = client.users.show_by_uid(access_token.params["uid"].to_i)
    unless User.find_by_token(cookies[:token]) # have logged in
      @user=User.find_by_name(user.screen_name) # however the token have expired
        if @user
          @user.token=access_token.token     #refresh the token in the database
        else
          @user.name=user.screen_name
          @user.token=access_token.token
          @user.password=access_token.token[0..20]
        end
        @user.save
    end
    redirect_to :root
  end
  def create_login_session
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      cookies.permanent[:token] = user.token
      redirect_to root_url, :notice => "login succeed"
    else
      flash[:error] = "no such password or username"
      redirect_to :login
    end
  end
  def logout
  	cookies.delete(:token)
    redirect_to root_url, :notice => "logout succeed"
  end
   def create
    @user = User.new(params[:user])
    if @user.save
      cookies.permanent[:token] = @user.token
      redirect_to :root, :notice => "signup succeed"
    else
      render :signup
    end
  end
end
