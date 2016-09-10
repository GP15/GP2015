class AddReservationIdToRewardPoints < ActiveRecord::Migration
  def change
    add_column :reward_points, :reservation_id, :integer
  end
end
