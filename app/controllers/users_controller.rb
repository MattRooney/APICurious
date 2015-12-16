class UsersController < ApplicationController
  def show
    @user = current_client.user
  end
end
