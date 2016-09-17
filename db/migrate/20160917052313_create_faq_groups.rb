class CreateFaqGroups < ActiveRecord::Migration
  def change
    create_table :faq_groups do |t|
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
