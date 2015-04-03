class Handle < ActiveRecord::Base
  acts_as_taggable
  has_many :posts, through: :post_handles
  has_many :post_handles

  def refresh_twitter_stats
    adapter = TwitterAdapter.new(self)
    self.location = adapter.location
    self.profile_image_url = adapter.profile_image_url
    self.followers = adapter.followers
    self.tweets_count = adapter.tweets_count
    self.last_tweet_date = adapter.last_tweet_date
    self.profile_description = adapter.profile_description
  end

end
