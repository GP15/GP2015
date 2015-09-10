module ApplicationHelper

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

  # Changes the logo link. If user is signed in, redirect to user dashboard.
  # Otherwise clicking the logo will redirect to homepage.
  def logo_url
    user_signed_in? ? current_user : root_url
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
