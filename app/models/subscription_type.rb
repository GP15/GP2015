class SubscriptionType < ActiveRecord::Base

  has_many :subscriptions

  scope :paid, -> { where.not(:name => 'Free') }


  def free?
    price.to_i == 0
  end

  def pro?
    self == SubscriptionType.pro
  end

  def self.free
    find_by_name('Free')
  end

  def self.pro
    find_by_name('Pro')
  end

  def self.amateur
    find_by_name('Amateur')
  end

end
