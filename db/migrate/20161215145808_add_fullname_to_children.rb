class AddFullnameToChildren < ActiveRecord::Migration
  def change
    add_column :children, :fullname, :string

    if Child.all.present?
      Child.all.each do |child|
        child.fullname = child.full_name
        child.save
      end
    end
  end
end
