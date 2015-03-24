class Post < ActiveRecord::Base

  belongs_to :topic
  belongs_to :platform
  has_many :post_handles
  has_many :handles, through: :post_handles

  enum status: [:draft, :final, :posted]

  validates_presence_of :topic_id, :content

  def handles_in_post
    self.content.split(' ').select{ |w| w =~ /\A@./ }
  end

  def self.to_csv(options = {}, posts)
    CSV.generate(options) do |csv|
      posts.each do |post|
        row = [hoot_date_format(post.posted_on), post.content, post.url]
        csv << row
      end
    end
  end

  def self.hoot_date_format(date)
    date.strftime("%m/%d/%Y %H:%M")
  end

  def set_status_to_posted
    self.status = Post.statuses[:posted]
  end

  def set_status_to_final
    self.status = Post.statuses[:final]
  end
end
