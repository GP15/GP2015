class ChangeSchedule < ActiveRecord::Migration
  def change
    change_table :schedules do |t|
      t.remove :date, :start_time, :end_time

      t.datetime :starts_at
      t.datetime :ends_at
    end

    add_index :schedules, [:starts_at, :ends_at]
  end
end
