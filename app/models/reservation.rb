class Reservation < ActiveRecord::Base
  default_scope { where(deleted: false) }

  belongs_to :child
  belongs_to :schedule, counter_cache: true
  belongs_to :user
  has_one    :reservation_cancellation

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
      token = user.customer.payment_methods.first.token
      result = Braintree::Transaction.sale(:amount => cancellation_charge.to_s, :payment_method_token => token, customer_id: user.customer_id)
      if result.success?
        mark_cancelled(result)
        true
      else
        false
      end
    end
  end

  def mark_cancelled(result)
    tran = result.transaction
    card = tran.credit_card_details
    self.create_reservation_cancellation(user_id: user_id, child_id: child_id, transaction_id: tran.id, last4: card.last_4, card_type: card.card_type, amount: tran.amount.to_f)
    self.update_attributes(deleted: true, deleted_at: DateTime.now)
  end
end
