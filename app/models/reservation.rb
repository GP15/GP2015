class Reservation < ActiveRecord::Base

  belongs_to :child
  belongs_to :schedule, counter_cache: true
  belongs_to :user

  validates_presence_of :child_id

  scope :upcoming, -> { where('schedules.starts_at >= ?', Time.zone.now) }
  scope :in_the_past, -> { where('schedules.starts_at < ?', Time.zone.now) }

  scope :sort_by_datetime_asc,  -> { order('schedules.starts_at ASC,  schedules.ends_at ASC') }
  scope :sort_by_datetime_desc, -> { order('schedules.starts_at DESC, schedules.ends_at DESC') }

  # def self.created_between(start_time, end_time)
  #   where('schedules.starts_at >= ? AND schedules.starts_at < ?', start_time, end_time)
  # end

end
