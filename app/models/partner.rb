class Partner < ActiveRecord::Base

  belongs_to :city

  validates :company, :address, presence: true

  # A list of states & federal territories in Malaysia.
  STATES = ["Johor", "Kedah", "Kelantan", "Kuala Lumpur", "Labuan", "Melaka",
            "Negeri Sembilan", "Pahang", "Perak", "Perlis", "Penang", "Putrajaya",
            "Sabah", "Sarawak", "Selangor", "Terengganu"]

end
