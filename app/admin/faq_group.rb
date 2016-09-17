ActiveAdmin.register FaqGroup do

  menu :parent => "General"

  permit_params :name, :content

  form do |f|
    f.inputs "Faq" do
      f.input :name
      f.input :content, as: :html_editor
    end
    f.actions
  end
end
