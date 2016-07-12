class AddTimeZoneToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :time_zone, :string, default: 'Kuala Lumpur', null: false
  end
end
