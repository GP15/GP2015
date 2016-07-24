class CreateKlassElements < ActiveRecord::Migration
  def change
    create_table :klass_elements do |t|
      t.integer :development_element_id
      t.integer :klass_id

      t.timestamps null: false

    end
    add_index :klass_elements, [:development_element_id, :klass_id]
  end
end
