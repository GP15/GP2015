class Reservation < ActiveRecord::Base

  belongs_to :child
  belongs_to :schedule
  belongs_to :user

  scope :upcoming, -> { where('schedules.starts_at >= ?', Time.zone.now) }

  scope :sort_by_datetime_asc,  -> { order('schedules.starts_at ASC,  schedules.ends_at ASC') }
  scope :sort_by_datetime_desc, -> { order('schedules.starts_at DESC, schedules.ends_at DESC') }

  def self.created_between(start_time, end_time)
    where('schedules.starts_at >= ? AND schedules.starts_at < ?', start_time, end_time)
  end

end
