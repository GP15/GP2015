class AddLatToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :latitude, :float
    add_column :partners, :longitude, :float
  end
end
