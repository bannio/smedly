class CreatePostHandles < ActiveRecord::Migration
  def change
    create_table :post_handles do |t|
      t.belongs_to :post, index: true
      t.belongs_to :handle, index: true

      t.timestamps null: false
    end
    add_foreign_key :post_handles, :posts
    add_foreign_key :post_handles, :handles
  end
end
