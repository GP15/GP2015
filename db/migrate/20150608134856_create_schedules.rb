class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date       :date
      t.time       :start_time
      t.time       :end_time
      t.integer    :quantity
      t.references :klass,   index: true
      t.references :partner, index: true

      t.timestamps null: false
    end

    add_index :schedules, [:date, :start_time, :end_time]
  end
end
