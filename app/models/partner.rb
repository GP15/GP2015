class Partner < ActiveRecord::Base

  belongs_to :city
  has_many   :klasses,   dependent: :destroy
  has_many   :schedules, dependent: :destroy
  has_many   :activities, through: :klasses

  validates_presence_of :company, :address, :city_id

  # A list of states & federal territories in Malaysia.
  STATES = ["Johor", "Kedah", "Kelantan", "Melaka", "Negeri Sembilan", "Pahang",
            "Perak", "Perlis", "Penang", "Sabah", "Sarawak", "Selangor",
            "Terengganu", "W.P. Kuala Lumpur", "W.P. Labuan", "W.P. Putrajaya"]

end
