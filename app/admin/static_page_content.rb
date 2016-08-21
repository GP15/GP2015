ActiveAdmin.register StaticPageContent do

  menu :parent => "General"

  permit_params :key, :value

  form do |f|
    f.inputs "Schedule Details" do
      f.input :key
      f.input :value, as: :html_editor
    end
    f.actions
  end
end
