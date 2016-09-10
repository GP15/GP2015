class CreatePartnershipSignUps < ActiveRecord::Migration
  def change
    create_table :partnership_sign_ups do |t|
      t.string :city
      t.string :company_name
      t.string :website
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.text :comments

      t.timestamps null: false
    end
  end
end
