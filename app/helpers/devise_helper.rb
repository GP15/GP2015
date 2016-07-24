# Copied from https://github.com/plataformatec/devise/blob/master/app/helpers/devise_helper.rb
# so we can style Devise error messages.
module DeviseHelper
  # def devise_error_messages!
  #   return "" if resource.errors.empty?

  #   messages = resource.errors.full_messages.map { |msg| content_tag(:span, msg) }.join

  #   html = <<-HTML
  #   <div class="alert-style7 alert-danger" role="alert">
  #     #{messages}
  #   </div>
  #   HTML

  #   html.html_safe
  # end

  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    error_title = pluralize(resource.errors.size, 'error') + " needed to be fixed"

    html = <<-HTML
    <div class="panel panel-danger">
      <div class="panel-heading">
        <h3 class="panel-title">#{error_title}</h3>
      </div>
      <div class="panel-body">
        #{messages}
      </div>
    </div>
    HTML

    html.html_safe
  end
end
