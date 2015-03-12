class ChangeReportStatus < ActiveRecord::Migration
  def up
    remove_column :reports, :status
    add_column :reports, :status, :integer, default: 0
  end
  def down
    remove_column :reports, :status
    add_column :reports, :status, :string
  end
end
