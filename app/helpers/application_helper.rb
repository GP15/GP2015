module ApplicationHelper

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
