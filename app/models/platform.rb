class Platform < ActiveRecord::Base

  has_many :posts

  default_scope { order(:name) }
end
