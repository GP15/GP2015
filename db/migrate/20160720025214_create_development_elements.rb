class CreateDevelopmentElements < ActiveRecord::Migration
  def change
    create_table :development_elements do |t|
      t.string :title
      t.integer :point

      t.timestamps null: false
    end
  end
end
