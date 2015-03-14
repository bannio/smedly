class Topic < ActiveRecord::Base

  has_many :posts

  validates_presence_of :name
  enum status: [ :active, :archived ]


end
