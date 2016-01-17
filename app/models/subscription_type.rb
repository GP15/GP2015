class SubscriptionType < ActiveRecord::Base

  has_many :subscriptions

  scope :free, -> { where(:name => 'Free') }
  scope :paid, -> { where.not(:name => 'Free') }

  def free
    find_by_name('Free')
  end

  def pro
    find_by_name('Pro')
  end

  def amatuer
    find_by_name('Amatuer')
  end
  
end
