class TweetsController < ApplicationController
  def new
  end

  def create
    twitter_service.update(params[:tweet][:text])
    redirect_to current_user
  end

  def index
    @tweets = twitter_service.user_timeline
  end
end
