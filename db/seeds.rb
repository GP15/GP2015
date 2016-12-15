# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Admins
AdminUser.create!(email: "admin@example.com", password: "12345678")
AdminUser.create!(email: "admin@geniuspass.com", password: "12345678")

# Time Zone
Time.zone = "Kuala Lumpur"

# Cities
cities = ["Klang", "Shah Alam", "Subang", "Petaling Jaya", "Puchong", "Kuala Lumpur"]

cities.each do |city|
  City.create!(name: city)
end

# Subscription Plans

SubscriptionType.create( :name => "Free", :price => "0", :activities_allowed => "1")
SubscriptionType.create( :name => "Amateur", :price => "59", :activities_allowed => "4")
SubscriptionType.create( :name => "Pro", :price => "99", :activities_allowed => "Unlimited")



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

20.times do
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
    city_id: rand(1..6),
    user_allowed: 1
  )
end

# Klasses
partners = Partner.all
activities = Activity.all
levels   = ["", "Beginner", "Intermediate", "Advanced", "Multilevel"]

partners.each do |partner|
  rand(0..6).times do
    activity = activities.sample
    klass_name = [activity.name, Faker::Team.creature.capitalize].join(" ")
    partner.klasses.create!(
      name: klass_name,
      level: levels.sample,
      age_start: rand(4..12),
      age_end: rand(12..17),
      reservation_limit: rand(0..11),
      description: Faker::Lorem.paragraph,
      activity_id: activity.id
    )
  end
end

# Schedules
partners.each do |partner|
  if partner.klasses.count > 0
    klass_id = partner.klasses.pluck(:id)
    year     = Date.current.year
    months   = [Date.current.month, Date.current.month + 1]
    minute   = [0, 15, 30, 45]

    rand(0..10).times do
      klass = Klass.find(klass_id.sample)

      month        = months.sample
      day          = rand(1..28)
      start_hour   = rand(8..13)
      start_minute = minute.sample
      end_hour     = rand(13..22)
      end_minute   = minute.sample

      starts_at = Time.zone.local(year, month, day, start_hour, start_minute)
      ends_at   = Time.zone.local(year, month, day, end_hour, end_minute)

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

# Users
User.create!(email: "user1@example.com", password: "123456", name: Faker::Name.name, location: Faker::Address.street_address)

2.upto(9) do |n|
  User.create!(email: "user#{n}@example.com", password: "123456", name: Faker::Name.name, location: Faker::Address.street_address)
end

# Children
def create_children(user, first_name, last_name, age)
  user.children.create!(
    first_name: first_name,
    last_name:  last_name,
    fullname: "#{first_name} #{last_name}",
    birth_year: age,
    gender: rand(2)
  )
end

# create children for first user
first_user = User.first
last_name = "von Anon"

create_children(first_user, "Alice",   last_name, (Date.current.year - 4))
create_children(first_user, "Bob",     last_name, (Date.current.year - 7))
create_children(first_user, "Charlie", last_name, (Date.current.year - 13))
create_children(first_user, "Dave",    last_name, (Date.current.year - 16))

# create children for the rest
users = User.where.not(id: 1)

users.each do |user|
  last_name = Faker::Name.last_name

  rand(0..4).times do
    first_name = Faker::Name.fullname
    random_age = rand((Date.current.year - 17)..(Date.current.year - 4))

    create_children(user, first_name, last_name, random_age)
  end
end

# Klass.all.each do |x|
#   development_ids = DevelopmentElement.pluck(:id)

#   (1..3).each do |time|
#     sample = development_ids.sample
#     x.klass_elements << KlassElement.create(development_element_id: sample, klass_id: x.id, points: rand(10))
#     development_ids.delete(sample)
#   end
# end