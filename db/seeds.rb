require "faker"
require "open-uri"

5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email(name: "#{first_name} #{last_name}")
  password = Faker::Internet.password(min_length: 6)
  user = User.create(email:, password:, first_name:, last_name:)
  puts user.full_name
  rand(1..5).times do
    year = Faker::Vehicle.year
    price = rand(50.0..1000.0)
    kilometers = rand(10_000..300_000)
    brand = Faker::Vehicle.make
    model = "#{brand} #{Faker::Vehicle.model(make_of_model: brand)}"
    seats = rand(4..5)
    color = Faker::Color.color_name
    car_type = Faker::Vehicle.car_type
    file = URI.open(Faker::LoremFlickr.image(size: "1200x800", search_terms: ["car"]))

    car = Car.new(year:, price:, kilometers:, model:, seats:, color:, car_type:, user:)
    car.photo.attach(io: file, filename: "#{model}.png", content_type: "image/jpeg")
    car.save

    puts car.model
  end
end
