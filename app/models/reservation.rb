class Reservation < ActiveRecord::Base
  default_scope { where(deleted: false) }

  belongs_to :child
  belongs_to :schedule, counter_cache: true
  belongs_to :user
  has_one    :reservation_cancellation

  validates_presence_of :child_id

  scope :child, ->(child_id) { where(child_id: child_id) }
  scope :upcoming,    -> { where('schedules.ends_at >= ?', Time.zone.now) }
  scope :in_the_past, -> { where('schedules.ends_at < ?',  Time.zone.now) }
  scope :this_month,  -> { where("created_at > ? AND created_at < ?",
                                  Time.now.beginning_of_month,
                                  Time.now.end_of_month) }
  scope :sort_by_datetime_asc,  -> { order('schedules.starts_at ASC,  schedules.ends_at ASC') }
  scope :sort_by_datetime_desc, -> { order('schedules.starts_at DESC, schedules.ends_at DESC') }

  scope :expired_hours, ->(hours) { joins(:schedule).where('schedules.ends_at < ?', Time.zone.now + hours.to_i.send(:hours)) }
  scope :check_point_earned, -> { where(points_earned: false) }

  before_create :check_authorization_for_reservation
  after_create :send_reservation_notification

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

  def can_be_cancelled?
    (schedule.starts_at - DateTime.now).round >= 1
  end

  def cancellation_charge
    10
  end

  def cancel_reservation?
    if !can_be_cancelled?
      return false
    else
      if Time.now >= schedule.starts_at.beginning_of_day
        if user.customer.payment_methods.first
          token = user.customer.payment_methods.first.token
          result = Braintree::Transaction.sale(:amount => cancellation_charge.to_s, :payment_method_token => token, customer_id: user.customer_id)
          if result.success?
            mark_cancelled(result)
            true
          else
            false
          end
        else
          mark_cancelled(nil)
          true
        end
      else
        mark_cancelled(nil)
        true
      end
    end
  end

  def mark_cancelled(result)
    if result
      tran = result.transaction
      card = tran.credit_card_details
      self.create_reservation_cancellation(user_id: user_id, child_id: child_id, transaction_id: tran.id, last4: card.last_4, card_type: card.card_type, amount: tran.amount.to_f)
    end
    self.update_attributes(deleted: true, deleted_at: DateTime.now)
    ReservationMailer.cancelation(self).deliver_now
  end

  def earned_points
    # keep track why user earn this points
    total_point_earned = self.schedule.klass.klass_elements.map(&:points).inject(:+)
    user.points.create(reservation: self, point: total_point_earned, child: self.child)
    # increase user reward points
    user.increase_reward_points(total_point_earned)
    # Check the record as points earned reservation
    self.points_earned = true
    save!
  end

  private
  def send_reservation_notification
    ClassBookingMailer.notification(self).deliver
  end

  def check_authorization_for_reservation
    if child.subscription.blank?
      errors.add(:base, "<a href='#{Rails.application.routes.url_helpers.new_child_subscription_path(child)}'>Register Your Child With GeniusPass Membership</a>")
      return false
    else
      if !child.subscription.subscription_type.pro?
        if child.reservations.count > child.subscription.subscription_type.activities_allowed.to_i
          errors.add(:base, "Plan limit reached. Please buy a subscription.")
          return false
        end
      end
    end
  end

end
