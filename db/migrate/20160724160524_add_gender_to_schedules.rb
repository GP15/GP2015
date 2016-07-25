class AddGenderToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :gender, :integer
  end
end
