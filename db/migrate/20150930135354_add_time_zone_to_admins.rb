class AddTimeZoneToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :time_zone, :string, default: 'Kuala Lumpur', null: false
  end
end
