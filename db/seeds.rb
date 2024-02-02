# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
CUISINES = ["Italian dishes", "French cuisines", "Mexican foods", "Japanese sushis", "Indian curries", "Chinese meals", "Thai foods", "Spanish tapas", "Greek meals", "American burgers", "British roasts", "German sausages", "Brazilian barbecues", "Argentinian steaks", "Vietnamese phos", "Korean barbecues", "Turkish kebabs", "Lebanese mezzes", "Ethiopian injeras", "Moroccan tagines", "Russian pelmenis", "Polish pierogis", "Swedish meatballs", "Cuban sandwiches", "Jamaican jerk chickens", "Peruvian ceviches", "Canadian poutines", "Belgian waffles", "Dutch cheeses", "Australian barbecues", "New Zealand lamb dishes", "South African boboties", "Egyptian ful medames", "Israeli falafels", "Iranian kebabs", "Pakistani biryanis", "Bangladeshi pithas", "Nepalese momos", "Sri Lankan hoppers", "Indonesian satays"]

Booking.destroy_all
Review.destroy_all
Chef.destroy_all
User.destroy_all

User.create(
  email: "elliot@gmail.com",
  password: "password123",
  name: "Elliot Marret",
  profile_picture_url: "https://source.unsplash.com/random/",
  biography: Faker::TvShows::Friends.quote,
  chef: false,
  city: "Paris"
)

25.times do |i|
  # Faker::Config.locale = 'it'
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

Chef.create(
  name: "Raymond Blanc",
  specialty: "French cuisines",
  description: "Raymond Blanc is a French chef. He is one of Britain's most respected chefs. Blanc is the chef patron at Le Manoir aux Quat' Saisons, a hotel-restaurant in Great Milton, Oxfordshire, England. The restaurant has two Michelin stars and scored 9/10 in the Good Food Guide. He is entirely self-taught, but has himself taught or employed other chefs including Heston Blumenthal, John Burton and Marco Pierre White.",
  user_id: User.order(Arel.sql('RANDOM()')).first.id,
  price_per_day: 450.50,
  city: "Paris"
)

Chef.create(
  name: "Arnaud Lahaut",
  specialty: "Fusion Cuisine",
  description: "Arnaud Lahaut is a French chef. He is one of France's most respected chefs. Lahaut is the chef patron at Le Cinq, a hotel-restaurant in Paris, France. The restaurant has three Michelin stars and scored 10/10 in the Good Food Guide. He is entirely self-taught, but has himself taught or employed other chefs including Heston Blumenthal, John Burton and Marco Pierre White.",
  user_id: User.order(Arel.sql('RANDOM()')).first.id,
  price_per_day: 295.00,
  city: "Bordeaux"
)

25.times do
  # Faker::Config.locale = 'it'
  Chef.create(
    name: Faker::Name.name,
    specialty: CUISINES.sample,
    description: Faker::Quote.famous_last_words,
    user_id: User.order(Arel.sql('RANDOM()')).first.id,
    price_per_day: Faker::Number.between(from: 80.0, to: 200.0).round(2),
    city: Faker::Address.city
  )
end

50.times do
  Faker::Config.locale = 'fr'
  start_date = Faker::Date.forward(days: rand(1..23))
  end_date = start_date + rand(1..5) # end date should be a few days after start.
  Booking.create(
    start_date: start_date,
    end_date: end_date,
    status: ['pending', 'confirmed', 'cancelled'].sample, # we can change these later if need be
    user_id: User.order(Arel.sql('RANDOM()')).first.id,
    chef_id: Chef.order(Arel.sql('RANDOM()')).first.id,
    special_requests: Faker::Lorem.sentence(word_count: 5), # generates a random sentence with 5 words
    number_of_guests: Faker::Number.between(from: 1, to: 10), # generates a fake number between 1 and 20
    address: Faker::Address.full_address # generates a fake full address
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
