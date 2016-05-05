class CreateContactRequests < ActiveRecord::Migration
  def change
    create_table :contact_requests do |t|
      t.string :email
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
