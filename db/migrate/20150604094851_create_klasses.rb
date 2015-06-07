class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.string     :name
      t.string     :level,        index: true
      t.integer    :age_start
      t.integer    :age_end
      t.text       :description
      t.references :activity,     index: true
      t.references :partner,      index: true

      t.timestamps null: false
    end

    add_index :klasses, [:age_start, :age_end]
  end
end
