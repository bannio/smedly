class RenameReportToTopic < ActiveRecord::Migration
  def change
    rename_table('reports', 'topics')
  end
end
