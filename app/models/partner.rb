class Partner < ActiveRecord::Base

  belongs_to :city
  has_many   :klasses,   dependent: :destroy
  has_many   :schedules, dependent: :destroy
  has_many   :activities, through: :klasses

  mount_uploader :logo, LogoUploader

  validates_presence_of :company, :address, :city_id#, :logo
  validate   :featured_limit

  scope :featured_partners, -> { where( :featured => true )}

  geocoded_by :full_street_address   # can also be an IP address
  before_save :geocode          # auto-fetch coordinates


  def full_street_address
    "#{address}, #{city.name}, #{state}"
  end

  # A list of states & federal territories in Malaysia.
  STATES = ["Johor", "Kedah", "Kelantan", "Melaka", "Negeri Sembilan", "Pahang",
            "Perak", "Perlis", "Penang", "Sabah", "Sarawak", "Selangor",
            "Terengganu", "W.P. Kuala Lumpur", "W.P. Labuan", "W.P. Putrajaya"]



  def featured_limit
    errors.add( :featured, "can not be greater than 5.") if Partner.featured_partners.count >= 5
    return false
	end

end
