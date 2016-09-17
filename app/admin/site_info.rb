ActiveAdmin.register SiteInfo do

  menu :parent => "General"

  permit_params :support_email, :partner_email, :facebook, :twitter, :instagram, :reward_section

end
