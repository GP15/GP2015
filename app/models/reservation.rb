class Reservation < ActiveRecord::Base

  belongs_to :child
  belongs_to :schedule, counter_cache: true
  belongs_to :user

  validates_presence_of :child_id

  scope :upcoming,    -> { where('schedules.ends_at >= ?', Time.zone.now) }
  scope :in_the_past, -> { where('schedules.ends_at < ?',  Time.zone.now) }

  scope :sort_by_datetime_asc,  -> { order('schedules.starts_at ASC,  schedules.ends_at ASC') }
  scope :sort_by_datetime_desc, -> { order('schedules.starts_at DESC, schedules.ends_at DESC') }

  # https://github.com/robinbortlik/validates_overlap
  # Prevent user from reserving overlapping schedules.
  validates "schedules.starts_at", "schedules.ends_at",
    overlap: {
      query_options: { includes: :schedule },
      exclude_edges: ["starts_at", "ends_at"],
      scope: { "reservations.child_id" => proc { |reservation| reservation.child_id } },
      message_content: "This child already has other reservation(s) that overlaps this schedule.
                        Please choose another schedule."
    }

end
