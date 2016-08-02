ActiveAdmin.register Schedule do

  menu :parent => "Activity Related"

  permit_params :quantity, :klass_id, :partner_id, :city_id, :activity_id, :starts_at, :ends_at, :archived, :recurrence, :gender

  index do
    selectable_column
    column :klass_id
    column :partner_id do |schedule|
      link_to schedule.partner.company, admin_partner_path(schedule.partner)
    end
    column :city_id
    column :activity_id
    column :starts_at
    column :ends_at
    column :archived
    column :reservations_count
    actions
  end

  filter :partner_id, as: :select, collection: proc { Partner.all.select(:id, :company).map { |p| [p.company, p.id] } }
  filter :klass_id, as: :select, collection: proc { Klass.all }
  filter :city_id, as: :select, collection: proc { City.all }
  filter :activity_id, as: :select, collection: proc { Activity.all }
  filter :starts_at
  filter :ends_at
  filter :archived
  filter :reservations_count

  form do |f|
    f.inputs "Schedule Details" do
      f.input :klass_id,        as: :select, collection: Klass.all
      f.input :partner_id,      as: :select, collection: Partner.all.map { |p| [p.company, p.id] }
      f.input :city_id,         as: :select, collection: City.all
      f.input :activity_id,     as: :select, collection: Activity.all
      f.input :starts_at
      f.input :ends_at
      f.input :reservations_count
      f.input :archived
      f.input :recurrence
      f.input :quantity
      f.input :gender
    end
    f.actions
  end


end
