class Handle < ActiveRecord::Base
  acts_as_taggable
  has_many :posts, through: :post_handles
  has_many :post_handles

  validates_uniqueness_of :name

  after_create :get_twitter_stats

  scope :updated_more_than_a_day_ago, -> { where("updated_at < ?", 1.day.ago) }
  scope :updated_more_than_a_week_ago, -> { where("updated_at < ?", 1.week.ago) }

  def refresh_twitter_stats
    user = $twitter.user(self.name)
    # user = TwitterAdapter.new(self).user
    self.location = user.location
    self.profile_image_url = user.profile_image_url
    self.followers = user.followers_count
    self.tweets_count = user.tweets_count
    self.last_tweet_date = user.status.created_at
    self.profile_description = user.description
  rescue Twitter::Error::NotFound
    self.profile_description = "** Twitter user NOT FOUND **"
  end

  private

  def get_twitter_stats
    RefreshStats.perform_later(self)
  end

end