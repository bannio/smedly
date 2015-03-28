class Handle < ActiveRecord::Base
  acts_as_taggable
  has_many :posts, through: :post_handles
  has_many :post_handles

end
