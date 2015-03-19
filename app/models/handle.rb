class Handle < ActiveRecord::Base

  has_many :posts, through: post_handles

end
