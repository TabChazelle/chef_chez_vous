# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

100.times do |i|
  User.create(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 10),
    name: Faker::Name.name,
    profile_picture_url: "https://source.unsplash.com/random/#{i}",
    biography: Faker::Lorem.paragraph,
    chef: false
  )
end

100.times do
  Chef.create(
    name: Faker::Name.name,
    specialty: Faker::Food.dish,
    description: Faker::Lorem.paragraph,
    user_id: User.order(Arel.sql('RANDOM()')).first.id
  )
end

100.times do
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
