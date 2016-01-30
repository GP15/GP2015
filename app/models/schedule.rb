class Schedule < ActiveRecord::Base

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
    where("recurrence = ? and archived = ? and starts_at BETWEEN ? and ?", 'Yearly', false, 1.year.from_now, (1.year.from_now + 5.minutes) )
  end

  def self.monthly_in_one_hour
    where("recurrence = ? and archived = ? and starts_at BETWEEN ? and ?", 'Monthly', false, 1.month.from_now, (1.month.from_now + 5.minutes) )
  end

  def self.daily_in_one_hour
    where("recurrence = ? and archived = ? and starts_at BETWEEN ? and ?", 'Daily', false, 1.day.from_now, (1.day.from_now + 5.minutes) )
  end

  def self.not_recuring_in_one_hour
    where("recurrence = ? and archived = ? and starts_at BETWEEN ? and ?", 'None', false, Time.now, (Time.now + 5.minutes) )
  end

  def self.in_one_hour
    yearly_in_one_hour + monthly_in_one_hour + daily_in_one_hour + not_recuring_in_one_hour
  end
end
