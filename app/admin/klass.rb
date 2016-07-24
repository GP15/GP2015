ActiveAdmin.register Klass do

  menu :parent => "Activity Related"

  permit_params :name, :level, :age_start, :age_end, :description, :activity_id, :partner_id, :reservation_limit,
                klass_elements_attributes: [:id, :development_element_id, :_destroy]

  index do
    selectable_column
    column :name
    column :level
    column :age_start
    column :age_end
    column :activity_id
    column :partner_id do |schedule|
      link_to schedule.partner.company, admin_partner_path(schedule.partner)
    end
    column :reservation_limit
    actions
  end

  filter :partner_id, as: :select, collection: proc { Partner.all.select(:id, :company).map { |p| [p.company, p.id] } }
  filter :name
  filter :level, as: :select, collection: Klass::LEVEL
  filter :age_start
  filter :age_end
  filter :activity_id
  filter :reservation_limit

  form do |f|
    f.inputs "Klass Details" do
      f.input :partner_id,      as: :select, collection: Partner.all.map { |p| [p.company, p.id] }
      f.input :activity_id,     as: :select, collection: Activity.all
      f.input :name
      f.input :level,           as: :select, collection: Klass::LEVEL
      f.input :age_start
      f.input :age_end
      f.input :description
      f.input :reservation_limit

      f.inputs 'Development Elements' do
        f.has_many :klass_elements do |pf|
          if !pf.object.nil?
            pf.input :_destroy, :as => :boolean, :label => "Destroy?"
          end
          pf.input :development_element_id, as: :select, collection: DevelopmentElement.all.map{|c| ["#{c.title}", c.id]}
        end
      end

    end
    f.actions
  end

end
