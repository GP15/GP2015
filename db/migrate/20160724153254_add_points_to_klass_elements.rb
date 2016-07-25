class AddPointsToKlassElements < ActiveRecord::Migration
  def change
    add_column :klass_elements, :points, :integer
  end
end
