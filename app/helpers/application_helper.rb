module ApplicationHelper

  # Change the logo link if user is signed in
  def logo_url
    user_signed_in? ? current_user : root_url
  end

  # TODO: Refactor these 2 methods.

  # Returns the full title on a per-page basis
  def full_title(page_title = '')
    base_title = "GeniusPass"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # Returns the full title for admin pages on a per-page basis
  def admin_full_title(page_title = '')
    base_title = "GeniusPass (Admin)"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

end
