# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Booking.destroy_all
Review.destroy_all
Chef.destroy_all
User.destroy_all

25.times do |i|
  Faker::Config.locale = 'it'
  User.create(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 10),
    name: Faker::Name.name,
    profile_picture_url: "https://source.unsplash.com/random/#{i}",
    biography: Faker::TvShows::Friends.quote,
    chef: false,
    city: Faker::Address.city
  )
end

25.times do
  Faker::Config.locale = 'it'
  Chef.create(
    name: Faker::Name.name,
    specialty: Faker::Address.country,
    description: Faker::Quote.famous_last_words,
    user_id: User.order(Arel.sql('RANDOM()')).first.id,
    price_per_day: Faker::Number.between(from: 80.0, to: 200.0).round(2),
    city: Faker::Address.city
  )
end

50.times do
  start_date = Faker::Date.forward(days: rand(1..23))
  end_date = start_date + rand(1..5) # end date should be a few days after start.
  Booking.create(
    start_date: start_date,
    end_date: end_date,
    status: ['pending', 'confirmed', 'cancelled'].sample, # we can change these later if need be
    user_id: User.order(Arel.sql('RANDOM()')).first.id,
    chef_id: Chef.order(Arel.sql('RANDOM()')).first.id
  )
end

Chef.all.each do |chef|
  rand(1..10).times do
    Review.create(
      chef_id: chef.id,
      user_id: User.order(Arel.sql('RANDOM()')).first.id,
      content: Faker::Restaurant.review
    )
  end
end
