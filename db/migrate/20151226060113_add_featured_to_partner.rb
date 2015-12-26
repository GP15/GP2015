class AddFeaturedToPartner < ActiveRecord::Migration
  def change
    add_column :partners, :featured, :boolean, :default => false
  end
end
