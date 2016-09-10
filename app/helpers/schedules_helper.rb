module SchedulesHelper


  # date heading

  def date_header
    if params[ :start_date].present?
      Date.parse(params[ :start_date]).strftime("%A, %d %B %Y")
    else
      Time.zone.tomorrow.strftime("%A, %d %B %Y")
    end
  end


  # Hash of dates for filters
  def date_hash
    h = Hash.new
    #h["Today"] = Time.zone.today.strftime("%d-%m-%Y")
    h["Tomorrow"] = Time.zone.tomorrow.strftime("%d-%m-%Y")
    if Time.now.end_of_week.month != Time.now.month
      # remaining days + next month days
      remaining_days = (Time.now.end_of_month.to_date - Time.now.to_date).to_i
      next_month_days = (Time.now.next_month.end_of_month.to_date - Time.now.next_month.beginning_of_month.to_date).to_i + 1
      total_days = remaining_days + next_month_days

      (2...total_days).map{ |i| h[i.days.from_now.strftime("%d %b")] = i.days.from_now.strftime("%d-%m-%Y")}
    else
      left_days = (Time.now.end_of_month.to_date - Time.now.to_date).to_i + 1
      (2...left_days).map{ |i| h[i.days.from_now.strftime("%d %b")] = i.days.from_now.strftime("%d-%m-%Y")}
    end
    h
  end

  # Reserve buttons that appears in a schedule table.
  def reserve_button(schedule)
    if user_signed_in?
      link_to 'Reserve', new_schedule_reservation_path(schedule), class: "gp-button"
    else
      link_to 'Reserve', new_user_registration_path, class: "gp-button"
    end
  end

  # Link to new reservation page if signed in.
  def link_to_reservation_if(schedule)
    if user_signed_in?
      link_to schedule.klass.name, new_schedule_reservation_path(schedule)
    else
      link_to schedule.klass.name, schedule_path(schedule)
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
  def default_date_select
    if params["start_date"].present?
      params["start_date"]
    else
      ['Tomorrow', Time.zone.tomorrow]
    end
  end

end
