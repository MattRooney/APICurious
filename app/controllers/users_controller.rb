class UsersController < ApplicationController
  def show
    @client ||= TwitterService.new(current_user).client
    @user = @client.user
    binding.pry
  end
end
