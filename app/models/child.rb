class Child < ActiveRecord::Base

  ## Associations ##
  belongs_to :user
  has_many   :reservations, dependent: :destroy
  has_many   :schedules, through: :reservations
  has_one    :subscription, dependent: :destroy

  ## Validations ##
  validates_presence_of :first_name, :last_name, :birth_year

  ## Scopes ##
  scope :sort_by_age_name, -> { order('birth_year DESC', 'first_name ASC') }
  #scope :valid_children_wrt_subscriptions, -> { eager_load(:subscription, :reservations).where("DATE(subscriptions.start_date) <= ? AND DATE(subscriptions.renewal_date) >= ?", Date.today, Date.today).group("subscriptions.plan_id, children.id, subscriptions.id, reservations.id").having("(subscriptions.plan_id IN (?) AND COUNT(reservations.child_id) < 4) OR (subscriptions.plan_id IN (?))", ['RM49', 'RM39'], ['RM99', 'RM79']) }

  #scope :valid_children_wrt_subscriptions, -> (user){ where.not(id: user.children.joins(:subscription, :reservations).select("COUNT(reservations.child_id) as counts, subscriptions.plan_id, children.id").group("subscriptions.plan_id, children.id, reservations.child_id").having("reservations.child_id > 4 AND subscriptions.plan_id IN (?)", ['RM49','RM39']).ids) }

  scope :valid_children_wrt_subscriptions, -> (user){ where.not(id: user.reservations.eager_load(child: :subscription).where(subscriptions: {plan_id: ['RM49', 'RM39']}).where("DATE(subscriptions.start_date) <= ? AND DATE(subscriptions.renewal_date) >= ?", Date.today, Date.today).group('reservations.child_id').count.collect{|k,v| k if v >= 4 }) }
  ## Class Methods ##
  # A scope that checks for a class's age requirement.
  def self.age_between(klass)
    where(birth_year: (Date.current.year - klass.age_end)..(Date.current.year - klass.age_start))
  end

  def self.without_subscriptions
    subscriptions = Arel::Table.new(:subscriptions)
    eager_load(:subscription).where(subscriptions[:child_id].eq(nil).or(subscriptions[:status].eq(false)))
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
