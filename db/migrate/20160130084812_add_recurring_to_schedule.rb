class AddRecurringToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :recurrence, :string
  end
end
