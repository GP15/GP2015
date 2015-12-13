class AddPromoCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :promo_code, :string, limit: 10
  end
end
