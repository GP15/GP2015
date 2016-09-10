class AddRewardPointsAndClaimedPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reward_points, :integer, default: 0
    add_column :users, :claimed_points, :integer, default: 0
  end
end
