class AddArchivedToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :archived, :boolean, null: false, default: false
  end
end
