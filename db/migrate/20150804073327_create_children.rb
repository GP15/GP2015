class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string     :first_name
      t.string     :last_name
      t.integer    :birth_year, index: true
      t.references :user,       index: true

      t.timestamps null: false
    end
  end
end
