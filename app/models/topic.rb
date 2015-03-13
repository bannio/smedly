class Topic < ActiveRecord::Base

  validates_presence_of :name
  enum status: [ :active, :archived ]


end
