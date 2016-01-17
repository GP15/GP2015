class CreateReferals < ActiveRecord::Migration
  def change
    create_table :referals do |t|
      t.integer :user_id
      t.integer :referred_to_id
      t.boolean :rewards_used

      t.timestamps null: false
    end
  end
end
