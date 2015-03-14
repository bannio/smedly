class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :topic, index: true
      t.text :content
      t.date :posted_on
      t.integer :status, default: 0

      t.timestamps null: false
    end
    add_foreign_key :posts, :topics
  end
end
