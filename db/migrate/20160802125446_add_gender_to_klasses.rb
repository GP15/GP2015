class AddGenderToKlasses < ActiveRecord::Migration
  def change
    add_column :klasses, :gender, :integer
  end
end
