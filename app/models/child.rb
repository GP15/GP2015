class Child < ActiveRecord::Base

  belongs_to :user
  has_many   :reservations, dependent: :destroy
  has_many   :schedules, through: :reservations

  validates_presence_of :first_name, :last_name

  scope :sort_by_age_name, -> { order('birth_year DESC', 'first_name ASC') }

  # A scope for ruling out children with reservations.
  def self.except_with(reservations)
    where.not(id: (reservations.map(&:child_id)))
  end

end
