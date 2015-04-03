class AddColumnsToHandle < ActiveRecord::Migration
  def change
    add_column :handles, :tweets_count, :integer
    add_column :handles, :last_tweet_date, :date
    add_column :handles, :profile_description, :text
    add_column :handles, :location, :string
    add_column :handles, :profile_image_url, :string
  end
end
