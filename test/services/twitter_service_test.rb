require 'test_helper'

class TwitterServiceTest < ActiveSupport::TestCase
  attr_reader :service, :user

  def create_user
    @user = User.new({id: 1,
                      name: "Matt Rooney",
                      screen_name: "Roondoggle",
                      oauth_token: ENV["oauth_token"],
                      oauth_token_secret: ENV["oauth_token_secret"]
                      })
  end

  def setup
    create_user
    @service ||= TwitterService.new(user).client
  end

  test "#user" do
    VCR.use_cassette("twitter_service#user") do

      assert service.user
      assert_equal "Roondoggle", service.user.screen_name
    end
  end

  test "#user[:screen_name]" do
    VCR.use_cassette("twitter_service#user") do

      assert_equal "Roondoggle", service.user["screen_name"]
    end
  end

end
