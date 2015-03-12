class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.text :summary
      t.date :publish_date
      t.string :status

      t.timestamps null: false
    end
  end
end
