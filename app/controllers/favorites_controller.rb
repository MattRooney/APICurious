class FavoritesController < ApplicationController
  def create
    twitter_service.favorite(params[:tweet_id])
    redirect_to favorites_path
  end

  def index
    @favorites = twitter_service.favorites
  end
end
