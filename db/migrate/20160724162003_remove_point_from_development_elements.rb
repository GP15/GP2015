class RemovePointFromDevelopmentElements < ActiveRecord::Migration
  def change
    remove_column :development_elements, :point, :integer
  end
end
