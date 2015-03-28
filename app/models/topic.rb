class Topic < ActiveRecord::Base

  has_many :posts

  validates_presence_of :name
  enum status: [ :active, :archived ]

  def handles
    # return an array of unique handle names used in this topic's posts
    handles = Handle.joins(:posts).
      where('posts.topic_id = ?', self.id).
      uniq.order(name: :asc) #.
      # map(&:name)
  end

end
