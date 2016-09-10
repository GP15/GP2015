ActiveAdmin.register User do

  permit_params :email, :name, :location, :customer_id,
                :promo_code, :referred, :phone_no

  index do
    selectable_column
    column :email
    column :created_at
    column :name
    column :location
    column :customer_id
    column :promo_code
    column :referred
    column :phone_no
    column :reward_points
    column :claimed_points
    column :phone_no
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :name
      f.input :location
      f.input :customer_id
      f.input :promo_code
      f.input :phone_no
    end
    f.actions
  end

end
