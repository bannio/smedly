class ChangePostedOnToDatetime < ActiveRecord::Migration
  def change
    change_column(:posts, :posted_on, :datetime)
  end
end
