class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :child
      t.references :schedule, index: true
      t.references :user,     index: true

      t.timestamps null: false
    end

    add_index :reservations, [:child_id, :schedule_id]
  end
end
