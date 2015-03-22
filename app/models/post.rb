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

end
