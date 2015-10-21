class Child < ActiveRecord::Base

  ## Associations ##
  belongs_to :user
  has_many   :reservations, dependent: :destroy
  has_many   :schedules, through: :reservations
  has_many   :subscriptions, dependent: :destroy

  ## Validations ##
  validates_presence_of :first_name, :last_name, :birth_year

  ## Scopes ##
  scope :sort_by_age_name, -> { order('birth_year DESC', 'first_name ASC') }
  scope :without_subscriptions, -> { includes(:subscriptions).where( :subscriptions => { :child_id => nil } ) }

  ## Class Methods ##
  # A scope that checks for a class's age requirement.
  def self.age_between(klass)
    where(birth_year: (Date.current.year - klass.age_end)..(Date.current.year - klass.age_start))
  end

  # A scope for ruling out children with reservations.
  def self.without(reservations)
    where.not(id: (reservations.map(&:child_id)))
  end

  ## Instance Methods ##
  def full_name
    format("%s %s", first_name, last_name)
  end

  def age
    Date.current.year - birth_year
  end
end
