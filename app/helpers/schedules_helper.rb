module SchedulesHelper

  # Shows either a single date or a date range.
  def compare_date(start_date, end_date)
    if start_date.strftime("%d %b %Y") == end_date.strftime("%d %b %Y")
      "#{start_date.strftime("%d %b %Y")}"
    else
      "#{start_date.strftime("%d")} - #{end_date.strftime("%d %b %Y")}"
    end
  end

  # Reserve buttons that appears in a schedule table.
  def reserve_button(schedule)
    if user_signed_in?
      link_to 'Reserve', new_schedule_reservation_path(schedule), class: primary_button_small
    else
      link_to 'Reserve', invite_path, class: primary_button_small
    end
  end

  # Check if schedule is archived and display appropriate symbol.
  def archived?(schedule)
    schedule == true ? "✓" : ""
  end

  # Change text color to gray if schedule is archived.
  def neutralize_color_if(archived)
    archived ?  "dark-gray-text" : "green-text"
  end

end
