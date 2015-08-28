# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Admins
Admin.create!(email: "admin@example.com", password: "123456")

# Cities
cities = ["Klang", "Shah Alam", "Subang", "Petaling Jaya", "Puchong", "Kuala Lumpur"]

cities.each do |city|
  City.create!(name: city)
end

# Activities
activities = ["Yoga", "Tennis", "Taekwondo", "Drumming", "Arithmetic", "Rock Climbing"]

activities.each do |activity|
  Activity.create!(name: activity)
end

# Partners
states = ["Johor", "Kedah", "Kelantan", "Melaka", "Negeri Sembilan", "Pahang",
          "Perak", "Perlis", "Penang", "Sabah", "Sarawak", "Selangor",
          "Terengganu", "W.P. Kuala Lumpur", "W.P. Labuan", "W.P. Putrajaya"]

s3_test_url    = "https://s3-ap-southeast-1.amazonaws.com/geniuspass/test/"
partner_images = (1..5).map { |n| "#{s3_test_url}partner#{n}.jpg" }

20.times do |n|
  street_address    = Faker::Address.street_address
  secondary_address = Faker::Address.secondary_address
  postcode          = Faker::Address.postcode
  address           = "#{street_address}, #{secondary_address}, #{postcode}"

  Partner.create!(
    company: Faker::Company.name,
    phone:   Faker::PhoneNumber.cell_phone,
    address: address,
    state:   states.sample,
    img_url: partner_images.sample,
    city_id: rand(1..6)
  )
end

# Klasses
partners = Partner.all
levels   = ["", "Beginner", "Intermediate", "Advanced", "Multilevel"]

partners.each do |partner|
  rand(0..6).times do |n|
    klass_name = [activities.sample, Faker::Team.creature.capitalize].join(" ")
    partner.klasses.create!(
      name: klass_name,
      level: levels.sample,
      age_start: rand(4..12),
      age_end: rand(12..17),
      description: Faker::Lorem.paragraph,
      activity_id: rand(1..6)
    )
  end
end

# Schedules
partners.each do |partner|
  if partner.klasses.count > 0
    klass_id = partner.klasses.pluck(:id)
    year     = Date.current.year
    month    = Date.current.month

    rand(0..10).times do
      klass = Klass.find(klass_id.sample)

      day          = rand(1..28)
      start_hour   = rand(8..13)
      start_minute = rand(0..59)
      end_hour     = rand(13..19)
      end_minute   = rand(0..59)

      starts_at = DateTime.civil(year, month, day, start_hour, start_minute)
      ends_at   = DateTime.civil(year, month, day, end_hour, end_minute)

      partner.schedules.create!(
        klass_id:    klass.id,
        quantity:    rand(5..25),
        starts_at:   starts_at,
        ends_at:     ends_at,
        city_id:     partner.city_id,
        activity_id: klass.activity_id
      )
    end
  end
end
