class FavoritesController < ApplicationController
  def create
    current_client.favorite(params[:tweet_id])
    redirect_to favorites_path
  end

  def index
    @favorites = current_client.favorites
  end
end
