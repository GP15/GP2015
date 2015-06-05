class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.string     :name
      t.text       :description
      t.references :partner,  index: true
      t.references :activity, index: true

      t.timestamps null: false
    end
  end
end
