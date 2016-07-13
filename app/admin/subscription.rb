ActiveAdmin.register Subscription do

  menu :parent => "Subscription Related"

  permit_params :plan_id, :user_id, :renewal_date, :status, :quantity, :child_id,
                :cancelled_on, :subscription_id, :start_date, :subscription_type_id, :promo_code

  form do |f|
    f.inputs "Subscription Details" do
      f.input :plan_id
      f.input :user_id,     as: :select, collection: User.all
      f.input :child_id,    as: :select, collection: Child.all
      f.input :subscription_id
      f.input :subscription_type_id
      f.input :quantity
      f.input :promo_code

      f.input :renewal_date
      f.input :cancelled_on
      f.input :start_date
      f.input :status
    end
    f.actions
  end

end
