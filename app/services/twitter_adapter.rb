class TwitterAdapter

  attr_reader :handle

  def initialize(handle)
    @handle = handle
  end

  def client
    client = Twitter::REST::Client.new(
    consumer_key: ENV['TW_CONSUMER_KEY'],
    consumer_secret: ENV['TW_CONSUMER_SECRET'],
    bearer_token: ENV['TW_BEARER_TOKEN'])
  end

  def user
    # rescue Twitter::Error::NotFound
    user ||= client.user(handle.name)
  end

  # def profile_image_url
  #   user.profile_image_uri.to_s
  # end

  # def location
  #   user.location
  # end

  # def followers
  #   user.followers_count
  # end

  # def profile_description
  #   user.description
  # end

  # def tweets_count
  #   user.tweets_count
  # end

  # def last_tweet_date
  #   user.status.created_at
  # end
end