class AddPointsEarnedToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :points_earned, :boolean, default: false
  end
end
