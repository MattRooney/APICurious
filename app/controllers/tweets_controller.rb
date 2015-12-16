class TweetsController < ApplicationController
  def new
  end

  def create
    current_client.update(params[:tweet][:text])
    redirect_to current_user
  end
end
