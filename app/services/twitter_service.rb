class TwitterService
  attr_reader :client, :user

  def initialize(user)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_api_key"]
      config.consumer_secret     = ENV["twitter_api_secret"]
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def full_name
    client.user.name
  end

  def profile_img
    client.user.profile_image_url
  end

  def screen_name
    client.user.screen_name
  end

  def tweet_count
    client.user.tweets_count
  end

  def friend_count
    client.user.friends_count
  end

  def follower_count
    client.user.followers_count
  end

  def feed
    client.home_timeline
  end

  def my_tweets
    client.user_timeline
  end

  def tweet(params)
    client.update(params)
  end

  def add_favorite(params)
    client.favorite(params)
  end

  def unfavorite(params)
    client.unfavorite(params)
  end
  
  def all_favorites
    client.favorites
  end
end
