class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :company
      t.string :phone
      t.string :address
      t.string :state
      t.string :img_url
      t.references :city, index: true

      t.timestamps null: false
    end
  end
end
