class AddReservationLimitToKlasses < ActiveRecord::Migration
  def change
    add_column :klasses, :reservation_limit, :integer, default: 0, null: false
  end
end
