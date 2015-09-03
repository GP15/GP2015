class AddReservationsCountToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :reservations_count, :integer, default: 0, null: false
  end
end
