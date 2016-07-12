ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end



# ActiveAdmin.register Post do

# permit_params :user_id, :category_id, :title, :status,
#                :post_category, :cover_image, :cover_video, :cover_link, :cover_quote,
#                :meta_description, :meta_image, :scheduled_date, :content,
#                 post_pictures_attributes: [:id, :image, :cover, :_destroy], taggings_attributes: [:id, :tag_id, :_destroy]

#   config.filters = false

#   index do
#     id_column
#     column :title
#     actions
#   end

#  controller do
#     def scoped_collection
#       Post.includes(:tags)
#     end
#   end

#   show do
#     attributes_table do
#       row :title
#       row :published_at
#     end
#     active_admin_comments
#   end

#   form html: { multipart: true } do |f|
#     if f.object.errors.size > 0
#       f.inputs "Errors need to fixed" do
#         content_tag(:li, f.object.errors.full_messages.join('<br/>').html_safe)
#       end
#     end

#     f.inputs 'Header' do
#       f.input :title
#       f.input :user, as: :select, collection: User.all.map{|u| ["#{u.email}", u.id]}
#     end

#     unless f.object.new_record?
#       f.inputs 'Content' do
#         f.input :content, input_html: { class: 'editor' }
#       end

#       f.inputs 'Pictures' do
#         f.has_many :post_pictures do |pf|
#           pf.input :image, as: :file, label: "Picture", hint: pf.object.image.nil? ? pf.template.content_tag(:span, "No Image") : pf.template.image_tag(pf.object.image.url(:thumb)) + pf.template.content_tag(:div, "#{pf.object.image.url}")
#           pf.input :_destroy, as: :boolean
#         end
#       end

#       f.inputs 'Metas' do
#         f.input :meta_description
#         f.input :meta_image
#       end
#     end


#     f.inputs 'Taggings' do
#       f.input :category, label: "General Cateogy", as: :select, collection: Category.all.map{|c| ["#{c.name}", c.id]}
#       f.has_many :taggings do |pf|
#         if !pf.object.nil?
#           pf.input :_destroy, :as => :boolean, :label => "Destroy?"
#         end
#         pf.input :tag
#       end
#     end

#     f.inputs 'Post Category' do
#       f.input :post_category, input_html: { value: :image_cover }, as: :hidden
#       f.input :cover_image, as: :file, label: "Cover Picture", hint: f.object.cover_image.nil? ? f.template.content_tag(:span, "No Image") : f.template.image_tag(f.object.cover_image.url(:thumb))
#       # f.input :cover_video
#       # f.input :cover_link
#       # f.input :cover_quote
#     end

#     unless f.object.new_record?
#       f.inputs 'Activate' do
#         f.input :status, as: :select, collection: Post.statuses.keys
#         f.input :scheduled_date,   as: :date_time_picker
#       end
#     end

#     f.actions
#   end


#   controller do

#     def create
#       @resource = Post.new(permitted_params[:post])
#       if @resource.save
#         redirect_to edit_admin_post_path(@resource), notice: 'Successfully created a new post!'
#       else
#         render 'new'
#       end
#     end

#   end



# end
