class CreateHandles < ActiveRecord::Migration
  def change
    create_table :handles do |t|
      t.string :name
      t.text :notes
      t.integer :followers
      t.boolean :following

      t.timestamps null: false
    end
  end
end
