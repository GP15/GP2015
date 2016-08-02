class AddActiveToZipcodes < ActiveRecord::Migration
  def change
    add_column :zipcodes, :active, :boolean, default: false
    add_column :zipcodes, :city_id, :integer
  end
end
