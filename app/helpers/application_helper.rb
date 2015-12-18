module ApplicationHelper

  # Active top link css

  def current_path(path)
    "active" if current_page?(path)
  end


  # Returns the webpage's full title on a per-page basis.
  def full_title(page_title = '', options = {})
    if options == 'admin'
      base_title = "GeniusPass (Admin)"
    else
      base_title = "GeniusPass"
    end

    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # Change the logo link
  def logo_url
    if user_signed_in?
      current_user
    elsif admin_signed_in?
      current_admin
    else
      root_url
    end
  end

  # Used as CSS classes
  def primary_button_small
    "highlight-button-dark btn btn-small button"
  end

  def primary_button_small_round
    "highlight-button-dark btn btn-small btn-round button"
  end

  def secondary_button_small
    "btn-small-black-border-light btn btn-small button"
  end

  def primary_button_medium
    "highlight-button-dark btn btn-medium btn-round button"
  end

end
