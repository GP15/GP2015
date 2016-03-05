class CreateStaticPageContents < ActiveRecord::Migration
  def change
    create_table :static_page_contents do |t|
      t.string :key
      t.text :value

      t.timestamps null: false
    end
  end
end
