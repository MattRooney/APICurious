require 'test_helper'

class UserTest < ActiveSupport::TestCase
  attr_reader :user
  def create_user
    @user = User.new( { id: 1,
                        name: "Matt Rooney",
                        screen_name: "Roondoggle",
                        oauth_token: ENV["oauth_token"],
                        oauth_token_secret: ENV["oauth_token_secret"] } )
  end

  test "user is valid" do
    create_user

    assert user.valid?
  end

  test "user has a name" do
    create_user

    assert_equal "Matt Rooney", user.name
  end

  test "user has a screen name" do
    create_user

    assert_equal "Roondoggle", user.screen_name
  end
end
