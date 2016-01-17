class CreateSubscriptionTypes < ActiveRecord::Migration
  def change
    create_table :subscription_types do |t|
      t.string :name
      t.string :price
      t.string :activities_allowed

      t.timestamps null: false
    end
  end
end
