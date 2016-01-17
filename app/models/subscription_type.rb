class SubscriptionType < ActiveRecord::Base

  has_many :subscriptions

  scope :paid, -> { where.not(:name => 'Free') }

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
