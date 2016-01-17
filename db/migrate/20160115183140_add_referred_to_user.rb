class AddReferredToUser < ActiveRecord::Migration
  def change
    add_column :users, :referred, :integer, :default => 0
  end
end
