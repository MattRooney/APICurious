class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
    end
    redirect_to current_user
  end

  def destroy
    session.clear
    redirect_to "/"
  end
end
