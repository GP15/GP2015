class AddGenderToChild < ActiveRecord::Migration
  def change
    add_column :children, :gender, :integer
  end
end
