class AddChildIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :child_id, :integer
  end
end
