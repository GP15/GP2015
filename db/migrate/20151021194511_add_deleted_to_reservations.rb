class AddDeletedToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :deleted, :boolean, default: false
    add_column :reservations, :deleted_at, :datetime
  end
end
