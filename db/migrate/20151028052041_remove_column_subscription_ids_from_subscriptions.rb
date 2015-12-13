class RemoveColumnSubscriptionIdsFromSubscriptions < ActiveRecord::Migration
  def self.up
    remove_column :subscriptions, :subscription_ids
    add_column :subscriptions, :subscription_id, :string
  end

  def self.down
    add_column :subscriptions, :subscription_ids, :text, array: true
    remove_column :subscriptions, :subscription_id, :string
  end
end
