class AddChildIdToRewardPoints < ActiveRecord::Migration
  def change
    add_column :reward_points, :child_id, :integer
  end
end
