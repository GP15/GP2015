class AddCancelledOnToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :cancelled_on, :datetime
  end
end
