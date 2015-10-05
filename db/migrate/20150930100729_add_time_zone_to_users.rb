class AddTimeZoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string, default: 'Kuala Lumpur', null: false
  end
end
