ActiveAdmin.register SubscriptionType do

  menu :parent => "Subscription Related"

  permit_params :name, :price, :activities_allowed, :featured, :discount_price, :on_discount, :two_child_onward_package

end
