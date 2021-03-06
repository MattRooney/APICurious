require 'test_helper'

class TwitterServiceTest < ActiveSupport::TestCase
  attr_reader :service, :test_user

  def create_user
    @test_user = User.new({id: 1,
                      name: "Matt Rooney",
                      screen_name: "Roondoggle",
                      oauth_token: ENV["oauth_token"],
                      oauth_token_secret: ENV["oauth_token_secret"]
                      })
  end

  def setup
    create_user
    @service = TwitterService.new(test_user).client
  end

  test "#user" do
    VCR.use_cassette("twitter_service#user") do
      assert service.user
      assert_equal "Roondoggle", service.user.screen_name
    end
  end

  test "#user.name" do
    VCR.use_cassette("twitter_service#user") do
      assert service.user
      assert_equal "Matt Rooney", service.user.name
    end
  end

  test "#user.profile_image_url" do
    VCR.use_cassette("twitter_service#user") do
      assert service.user.profile_image_url
    end
  end

  test "#followers_count" do
    VCR.use_cassette("twitter_service#user") do

      assert_equal 93, service.user.followers_count
    end
  end

  test "#friends_count" do
    VCR.use_cassette("twitter_service#user") do

      assert_equal 330, service.user.friends_count
    end
  end
  test "#tweets_count" do
    VCR.use_cassette("twitter_service#user") do

      assert_equal 129, service.user.tweets_count
    end
  end

  test "#user posts tweet" do
    service.stubs(:update).returns(Twitter::Tweet.new(id: 123))
    VCR.use_cassette("twitter_service#update") do

      assert_equal Twitter::Tweet, service.update("Tweet Test").class
    end
  end

  test "#user adds favorite" do
    service.stubs(:favorite).returns(Twitter::Tweet.new(id: 123))
    VCR.use_cassette("twitter_service#favorite") do

      assert_equal Twitter::Tweet, service.favorite("Test Tweet").class
    end
  end

end
