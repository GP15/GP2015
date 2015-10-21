class CreateReservationCancellations < ActiveRecord::Migration
  def change
    create_table :reservation_cancellations do |t|
      t.string :transaction_id
      t.float :amount, default: 0.0
      t.integer :reservation_id
      t.integer :user_id
      t.string :card_type
      t.string :last4
      t.integer :child_id

      t.timestamps null: false
    end
  end
end
