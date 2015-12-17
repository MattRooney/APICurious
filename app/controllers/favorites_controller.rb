class FavoritesController < ApplicationController
  def index
    @favorites = twitter_service.all_favorites
  end

  def create
    twitter_service.add_favorite(params[:tweet_id])
    redirect_to favorites_path
  end

  # def destroy
  #   twitter_service.unfavorite(params[:tweet_id])
  #   redirect_to favorites_path
  # end

end
