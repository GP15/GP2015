module SchedulesHelper

  def reserve_button(schedule)
    if user_signed_in?
      link_to 'Reserve', new_schedule_reservation_path(schedule), class: primary_button_small
    else
      link_to 'Reserve', invite_path, class: primary_button_small
    end
  end

end
