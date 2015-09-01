module ReservationsHelper

  # Show reservation count in a table
  def reservation_count(count)
    count == 0 ? "" : count
  end

end
