module SchedulesHelper

  # Reserve buttons that appears in a schedule table.
  def reserve_button(schedule)
    if user_signed_in?
      link_to 'Reserve', new_schedule_reservation_path(schedule), class: primary_button_small_round
    else
      link_to 'Reserve', invite_path, class: primary_button_small_round
    end
  end

  # Link to new reservation page if signed in.
  def link_to_reservation_if(schedule)
    if user_signed_in?
      link_to schedule.klass.name, new_schedule_reservation_path(schedule), class: "underline"
    else
      link_to schedule.klass.name, schedule_path(schedule), class: "underline"
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

  # Show number of attendees.
  def attendees(total_reservations, class_size)
    if total_reservations < class_size
      "Attendees : #{total_reservations} / #{class_size}"
    else
      "This class is fully booked."
    end
  end

  # Show selected date for Schedule's date filter.
  def default_date_select(q)
    if params[:q][:start_date_eq].present?
      q.start_date_eq
    else
      ['Tomorrow', Time.zone.tomorrow]
    end
  end

end
