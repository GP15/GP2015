class CreateRewardPoints < ActiveRecord::Migration
  def change
    create_table :reward_points do |t|
      t.integer :user_id
      t.integer :point

      t.timestamps null: false
    end
  end
end
