class AddColumnsToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :url, :string
    add_column :topics, :author, :string
  end
end
