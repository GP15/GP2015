class AlterSubscriptionTypes < ActiveRecord::Migration

  def change
    change_column :subscription_types, :price, 'integer USING CAST(price AS integer)'
    add_column :subscription_types, :discount_price, :integer
    add_column :subscription_types, :on_discount, :boolean
    add_column :subscription_types, :two_child_onward_package, :boolean
  end

end
