class Klass < ActiveRecord::Base

  belongs_to :partner
  belongs_to :activity
  belongs_to :city

  has_many   :schedules

  has_many :klass_elements
  has_many :development_elements, through: :klass_elements

  accepts_nested_attributes_for :klass_elements, allow_destroy: true

  enum gender: [:male, :female, :unisex]

  validates_presence_of :name, :activity_id, :age_start, :age_end, :reservation_limit, :level
  validates_numericality_of :reservation_limit, only_integer: true, greater_than_or_equal_to: 0

  scope :non_archived_schedules, -> { includes(:schedules).where(schedules: { archived: false }) }

  # A class difficulty levels.
  LEVEL = ["Beginner", "Intermediate", "Advanced", "Multilevel"]

  def schedules_starts_at
    schedules.not_archived.order('starts_at ASC').pluck(:starts_at).first
  end

  def schedules_ends_at
    schedules.not_archived.order('ends_at DESC').pluck(:ends_at).first
  end


  # def self.filter_curation(klasses, remain_klasses, count)
  #   filter_klasses = klasses

  #   klasses.each do |klass|

  #     if #hehe
  #       filter_klasses.push(klass)
  #     else
  #       remain_klasses.push(klass)
  #     end
  #   end

  #   if filter_klasses <= count && remain_klasses > 0
  #     return Klass.filter(result_klasses, remain_klasses, count)
  #   else
  #     return filter_klasses
  #   end
  # end

end
