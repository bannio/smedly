class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :platform

  enum status: [:draft, :final, :posted]

  validates_presence_of :topic_id

end
