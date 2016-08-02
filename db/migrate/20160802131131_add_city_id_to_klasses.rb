class AddCityIdToKlasses < ActiveRecord::Migration
  def change
    add_column :klasses, :city_id, :integer
  end
end
