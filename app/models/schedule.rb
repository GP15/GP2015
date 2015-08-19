class Schedule < ActiveRecord::Base

  belongs_to :city
  belongs_to :partner
  belongs_to :activity
  belongs_to :klass
  has_many   :reservations
  has_many   :children, through: :reservations

  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }

  scope :sort_by_datetime_asc, -> { order(:starts_at, :ends_at) }
  scope :starting_today, -> { where('starts_at >= ?', Time.zone.today) }

  # Custom Ransack methods
  ransacker :start_date, type: :date do
    Arel.sql('starts_at::date')   # filter only the date from starts_at attribute
  end

  ransacker :start_time, type: :time do
    Arel.sql('starts_at::time')   # filter only the time from starts_at attribute
  end

  ransacker :end_time, type: :time do
    Arel.sql('ends_at::time')     # filter only the time from ends_at attribute
  end

end
