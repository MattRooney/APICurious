class TweetsController < ApplicationController
  def new
  end

  def create
    twitter_service.tweet(params[:tweet][:text])
    redirect_to current_user
  end

  def index
    @tweets = twitter_service.my_tweets
  end
end
