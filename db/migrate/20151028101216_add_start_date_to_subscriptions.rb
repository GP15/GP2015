class AddStartDateToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :start_date, :datetime
  end
end
