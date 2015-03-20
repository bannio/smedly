class Handle < ActiveRecord::Base

  has_many :posts, through: :post_handles
  has_many :post_handles

end
