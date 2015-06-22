class AddRefsToSchedules < ActiveRecord::Migration
  def change
    add_reference :schedules, :city,     index: true
    add_reference :schedules, :activity, index: true
  end
end
