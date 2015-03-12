class Report < ActiveRecord::Base

  enum status: [ :active, :archived ]

end
