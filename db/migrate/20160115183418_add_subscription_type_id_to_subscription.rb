class AddSubscriptionTypeIdToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscription_type_id, :integer
    add_column :subscriptions, :promo_code, :string
  end
end
