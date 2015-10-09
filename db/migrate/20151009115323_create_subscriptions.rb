class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :plan_id
      t.integer :user_id
      t.date :renewal_date
      t.boolean :status, default: true
      t.text :subscription_ids, array:true, default: []
      t.integer :quantity, default: 1
      t.timestamps null: false
    end
  end
end
