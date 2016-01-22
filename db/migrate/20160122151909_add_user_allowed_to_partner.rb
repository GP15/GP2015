class AddUserAllowedToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :user_allowed, :integer, :default => 0
  end
end
