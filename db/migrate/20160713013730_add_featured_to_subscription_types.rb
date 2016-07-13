class AddFeaturedToSubscriptionTypes < ActiveRecord::Migration
  def change
    add_column :subscription_types, :featured, :boolean, default: false
  end
end
