class Schedule < ActiveRecord::Base
  RECURRENCES = [ "None", "Daily", "Monthly", "Yearly" ]

  belongs_to :city
  belongs_to :partner
  belongs_to :activity
  belongs_to :klass
  has_many   :reservations, dependent: :destroy
  has_many   :children, through: :reservations

  validates_presence_of :klass_id, :starts_at, :ends_at, :quantity
  validates_numericality_of :quantity, only_integer: true, greater_than: 0

  scope :sort_by_datetime_asc, -> { order(:starts_at, :ends_at) }
  scope :sort_by_datetime_desc, -> { order('starts_at DESC, ends_at DESC') }

  scope :in_the_past,        -> { where('ends_at < ?',    Time.zone.now) }
  scope :recent,             -> { where('ends_at >= ?',   Time.zone.now) }
  scope :six_hours_from_now, -> { where('starts_at >= ?', Time.zone.now + 6.hours) }

  scope :not_archived, -> { where.not('archived') }

  def self.only_tomorrow
    where('starts_at BETWEEN ? AND ?', Time.zone.tomorrow.beginning_of_day, Time.zone.tomorrow.end_of_day)
  end

  def self.yearly_in_one_hour
    where("recurrence = ? and archived = ?", "Yearly", false ).select{|schedule|
      schedule.starts_at.month == Time.now.month &&
      schedule.starts_at.day == Time.now.day &&
      time_in_minutes(schedule.starts_at) > time_in_minutes(1.hour.from_now) && 
      time_in_minutes(schedule.starts_at) < ( time_in_minutes(1.hour.from_now) + 5 ) 
    }
  end

  def self.monthly_in_one_hour
    where("recurrence = ? and archived = ?", "Monthly", false ).select{|schedule|
      schedule.starts_at.day == Time.now.day &&
      time_in_minutes(schedule.starts_at) > time_in_minutes(1.hour.from_now) && 
      time_in_minutes(schedule.starts_at) < ( time_in_minutes(1.hour.from_now) + 5 ) 
    }
  end

  def self.daily_in_one_hour
    where("recurrence = ? and archived = ?", "Daily", false ).select{|schedule| 
      time_in_minutes(schedule.starts_at) > time_in_minutes(1.hour.from_now) && 
      time_in_minutes(schedule.starts_at) < ( time_in_minutes(1.hour.from_now) + 5 ) 
    }
  end

  def self.not_recuring_in_one_hour
    where("recurrence = ? and archived = ? and starts_at BETWEEN ? and ?", 'None', false, Time.now, (Time.now + 5.minutes) )
  end

  def self.in_one_hour
    yearly_in_one_hour + monthly_in_one_hour + daily_in_one_hour + not_recuring_in_one_hour
  end

  def self.time_in_minutes full_time
    full_time.hour * 60 + full_time.min
  end
end
