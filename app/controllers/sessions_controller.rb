class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],
                      :uid      => auth['uid']).first || User.create_with_omniauth(auth)

    session[:user_id] = user.id

    redirect_to root_url
  end

  def new
    redirect_to '/auth/twitter'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Farewell'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
end
