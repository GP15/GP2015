class Reservation < ActiveRecord::Base
  default_scope { where(deleted: false) }

  belongs_to :child
  belongs_to :schedule, counter_cache: true
  belongs_to :user
  has_one    :reservation_cancellation

  validates_presence_of :child_id

  scope :upcoming, -> { where('schedules.starts_at >= ?', Time.zone.now) }
  scope :in_the_past, -> { where('schedules.starts_at < ?', Time.zone.now) }

  scope :sort_by_datetime_asc,  -> { order('schedules.starts_at ASC,  schedules.ends_at ASC') }
  scope :sort_by_datetime_desc, -> { order('schedules.starts_at DESC, schedules.ends_at DESC') }

  # def self.created_between(start_time, end_time)
  #   where('schedules.starts_at >= ? AND schedules.starts_at < ?', start_time, end_time)
  # end

  def can_be_cancelled?
    schedule.starts_at.day > Date.today.day
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
