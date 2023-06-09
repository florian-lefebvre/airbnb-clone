require "faker"
require "open-uri"

CITIES = ["Aberdeen", "Abilene", "Akron", "Albany", "Albuquerque", "Alexandria", "Allentown", "Amarillo", "Anaheim", "Anchorage", "Ann Arbor", "Antioch", "Apple Valley", "Appleton", "Arlington", "Arvada", "Asheville", "Athens", "Atlanta", "Atlantic City", "Augusta", "Aurora", "Austin", "Bakersfield", "Baltimore", "Barnstable", "Baton Rouge", "Beaumont", "Bel Air", "Bellevue", "Berkeley", "Bethlehem", "Billings", "Birmingham", "Bloomington", "Boise", "Boise City", "Bonita Springs", "Boston", "Boulder", "Bradenton", "Bremerton", "Bridgeport", "Brighton", "Brownsville", "Bryan", "Buffalo", "Burbank", "Burlington", "Cambridge", "Canton", "Cape Coral", "Carrollton", "Cary", "Cathedral City", "Cedar Rapids", "Champaign", "Chandler", "Charleston", "Charlotte", "Chattanooga", "Chesapeake", "Chicago", "Chula Vista", "Cincinnati", "Clarke County", "Clarksville", "Clearwater", "Cleveland", "College Station", "Colorado Springs", "Columbia", "Columbus", "Concord", "Coral Springs", "Corona", "Corpus Christi", "Costa Mesa", "Dallas", "Daly City", "Danbury", "Davenport", "Davidson County", "Dayton", "Daytona Beach", "Deltona", "Denton", "Denver", "Des Moines", "Detroit", "Downey", "Duluth", "Durham", "El Monte", "El Paso", "Elizabeth", "Elk Grove", "Elkhart", "Erie", "Escondido", "Eugene", "Evansville", "Fairfield", "Fargo", "Fayetteville", "Fitchburg", "Flint", "Fontana", "Fort Collins", "Fort Lauderdale", "Fort Smith", "Fort Walton Beach", "Fort Wayne", "Fort Worth", "Frederick", "Fremont", "Fresno", "Fullerton", "Gainesville", "Garden Grove", "Garland", "Gastonia", "Gilbert", "Glendale", "Grand Prairie", "Grand Rapids", "Grayslake", "Green Bay", "GreenBay", "Greensboro", "Greenville", "Gulfport-Biloxi", "Hagerstown", "Hampton", "Harlingen", "Harrisburg", "Hartford", "Havre de Grace", "Hayward", "Hemet", "Henderson", "Hesperia", "Hialeah", "Hickory", "High Point", "Hollywood", "Honolulu", "Houma", "Houston", "Howell", "Huntington", "Huntington Beach", "Huntsville", "Independence", "Indianapolis", "Inglewood", "Irvine", "Irving", "Jackson", "Jacksonville", "Jefferson", "Jersey City", "Johnson City", "Joliet", "Kailua", "Kalamazoo", "Kaneohe", "Kansas City", "Kennewick", "Kenosha", "Killeen", "Kissimmee", "Knoxville", "Lacey", "Lafayette", "Lake Charles", "Lakeland", "Lakewood", "Lancaster", "Lansing", "Laredo", "Las Cruces", "Las Vegas", "Layton", "Leominster", "Lewisville", "Lexington", "Lincoln", "Little Rock", "Long Beach", "Lorain", "Los Angeles", "Louisville", "Lowell", "Lubbock", "Macon", "Madison", "Manchester", "Marina", "Marysville", "McAllen", "McHenry", "Medford", "Melbourne", "Memphis", "Merced", "Mesa", "Mesquite", "Miami", "Milwaukee", "Minneapolis", "Miramar", "Mission Viejo", "Mobile", "Modesto", "Monroe", "Monterey", "Montgomery", "Moreno Valley", "Murfreesboro", "Murrieta", "Muskegon", "Myrtle Beach", "Naperville", "Naples", "Nashua", "Nashville", "New Bedford", "New Haven", "New London", "New Orleans", "New York", "New York City", "Newark", "Newburgh", "Newport News", "Norfolk", "Normal", "Norman", "North Charleston", "North Las Vegas", "North Port", "Norwalk", "Norwich", "Oakland", "Ocala", "Oceanside", "Odessa", "Ogden", "Oklahoma City", "Olathe", "Olympia", "Omaha", "Ontario", "Orange", "Orem", "Orlando", "Overland Park", "Oxnard", "Palm Bay", "Palm Springs", "Palmdale", "Panama City", "Pasadena", "Paterson", "Pembroke Pines", "Pensacola", "Peoria", "Philadelphia", "Phoenix", "Pittsburgh", "Plano", "Pomona", "Pompano Beach", "Port Arthur", "Port Orange", "Port Saint Lucie", "Port St. Lucie", "Portland", "Portsmouth", "Poughkeepsie", "Providence", "Provo", "Pueblo", "Punta Gorda", "Racine", "Raleigh", "Rancho Cucamonga", "Reading", "Redding", "Reno", "Richland", "Richmond", "Richmond County", "Riverside", "Roanoke", "Rochester", "Rockford", "Roseville", "Round Lake Beach", "Sacramento", "Saginaw", "Saint Louis", "Saint Paul", "Saint Petersburg", "Salem", "Salinas", "Salt Lake City", "San Antonio", "San Bernardino", "San Buenaventura", "San Diego", "San Francisco", "San Jose", "Santa Ana", "Santa Barbara", "Santa Clara", "Santa Clarita", "Santa Cruz", "Santa Maria", "Santa Rosa", "Sarasota", "Savannah", "Scottsdale", "Scranton", "Seaside", "Seattle", "Sebastian", "Shreveport", "Simi Valley", "Sioux City", "Sioux Falls", "South Bend", "South Lyon", "Spartanburg", "Spokane", "Springdale", "Springfield", "St. Louis", "St. Paul", "St. Petersburg", "Stamford", "Sterling Heights", "Stockton", "Sunnyvale", "Syracuse", "Tacoma", "Tallahassee", "Tampa", "Temecula", "Tempe", "Thornton", "Thousand Oaks", "Toledo", "Topeka", "Torrance", "Trenton", "Tucson", "Tulsa", "Tuscaloosa", "Tyler", "Utica", "Vallejo", "Vancouver", "Vero Beach", "Victorville", "Virginia Beach", "Visalia", "Waco", "Warren", "Washington", "Waterbury", "Waterloo", "West Covina", "West Valley City", "Westminster", "Wichita", "Wilmington", "Winston", "Winter Haven", "Worcester", "Yakima", "Yonkers", "York", "Youngstown"].freeze

USERS = [
  { email: "timika.mayer@hoppe.co", first_name: "Timika", last_name: "Mayer" },
  { email: "sipes_virgil@deckow-rohan.com", first_name: "Virgil", last_name: "Sipes" },
  { email: "macejkovic_scott@ohara.org", first_name: "Scott", last_name: "Macejkovic" },
  { email: "lucio_pagac@medhurst.org", first_name: "Lucio", last_name: "Pagac" },
  { email: "ferry_rodger@wolff.info", first_name: "Rodger", last_name: "Ferry" }
].freeze

cars = [
  {
    model: "Porsche 911 GT3",
    color: "Green",
    car_type: "Sport Car",
    file: "https://cdn.pixabay.com/photo/2022/11/29/08/54/race-car-7624025_1280.jpg"
  },
  {
    model: "Opel GT",
    color: "Red",
    car_type: "Sport Car",
    file: "https://cdn.pixabay.com/photo/2020/05/19/10/05/opel-5190050_1280.jpg"
  },
  {
    model: "Ford Mustang",
    color: "Black",
    car_type: "Sport Car",
    file: "https://cdn.pixabay.com/photo/2012/11/02/13/02/car-63930_1280.jpg"
  },
  {
    model: "Mercedes-Benz Classe C",
    color: "Silver",
    car_type: "Sport Car",
    file: "https://cdn.pixabay.com/photo/2017/03/27/14/56/auto-2179220_1280.jpg"
  },
  {
    model: "Audi A3",
    color: "Black",
    car_type: "Hatchback",
    file: "https://cdn.pixabay.com/photo/2015/01/19/13/51/car-604019_1280.jpg"
  },
  {
    model: "IFA F9",
    color: "Gray blue",
    car_type: "Cabriolet",
    file: "https://cdn.pixabay.com/photo/2016/09/11/16/47/car-1661767_1280.jpg"
  },
  {
    model: "Volkswagen Beetle",
    color: "Blue",
    car_type: "Hatchback",
    file: "https://cdn.pixabay.com/photo/2016/03/27/19/44/car-1283947_1280.jpg"
  },
  {
    model: "Audi A8",
    color: "Black",
    car_type: "Limousine",
    file: "https://cdn.pixabay.com/photo/2016/12/08/00/10/audi-1890687_1280.jpg"
  },
  {
    model: "Plymouth GTX",
    color: "Beige",
    car_type: "Cabriolet",
    file: "https://cdn.pixabay.com/photo/2015/06/03/13/38/plymouth-796441_1280.jpg"
  },
  {
    model: "Ford Hot Road 1932",
    color: "Yellow",
    car_type: "Classic car",
    file: "https://cdn.pixabay.com/photo/2016/01/09/17/33/classic-car-1130619_1280.jpg"
  },
  {
    model: "Piaggio Ape",
    color: "Blue",
    car_type: "Pick up",
    file: "https://cdn.pixabay.com/photo/2022/06/10/14/37/piaggio-ape-7254648_1280.jpg"
  },
  {
    model: "2015 Bentley Continental GT",
    color: "Blue",
    car_type: "Coupe",
    file: "https://cdn.pixabay.com/photo/2016/11/22/23/55/car-1851299_1280.jpg"
  },
  {
    model: "Volkswagen Bulli",
    color: "Teal",
    car_type: "Van",
    file: "https://cdn.pixabay.com/photo/2016/11/29/10/01/vw-bulli-1868890_1280.jpg"
  },
  {
    model: "Volkswagen Beetle",
    color: "Teal",
    car_type: "Hatchback",
    file: "https://images.unsplash.com/photo-1511125357779-27038c647d9d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDV8fGNhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60"
  },
  {
    model: "Land Rover Defender",
    color: "White",
    car_type: "SUV",
    file: "https://images.unsplash.com/photo-1502489597346-dad15683d4c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mzh8fGNhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60"
  },
  {
    model: "Volkswagen Polo",
    color: "Teal",
    car_type: "Hatchback",
    file: "https://images.unsplash.com/photo-1541899481282-d53bffe3c35d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzB8fGNhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60"
  },
  {
    model: "Nissan Navara",
    color: "Bronze",
    car_type: "Pickup",
    file: "https://cdn.pixabay.com/photo/2016/09/25/18/29/nissan-1694345_1280.jpg"
  },
  {
    model: "Toyota",
    color: "Red",
    car_type: "SUV",
    file: "https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fGNhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60"
  },
  {
    model: "Volkswagen Combi",
    color: "Teal",
    car_type: "Van",
    file: "https://cdn.pixabay.com/photo/2017/09/06/22/21/vw-2723353_1280.jpg"
  },
  {
    model: "Buick Special",
    color: "Blue",
    car_type: "Muscle car",
    file: "https://cdn.pixabay.com/photo/2016/05/18/10/52/buick-1400243_1280.jpg"
  },
  {
    model: "Ford GT",
    color: "Black & white",
    car_type: "Sport car",
    file: "https://cdn.pixabay.com/photo/2016/05/06/16/32/car-1376190_1280.jpg"
  },
  {
    model: "Chevrolet Corvette (C3)",
    color: "White",
    car_type: "Muscle car",
    file: "https://cdn.pixabay.com/photo/2013/08/11/03/40/car-171422_1280.jpg"
  },
  {
    model: "Ford Mustang",
    color: "Black",
    car_type: "Muscle car",
    file: "https://images.unsplash.com/photo-1494905998402-395d579af36f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
  },
  {
    model: "Volkswagen Beetle",
    color: "Orange",
    car_type: "Sedan",
    file: "https://images.unsplash.com/photo-1489824904134-891ab64532f1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=600&q=60"
  },
  {
    model: "BMW",
    color: "Silver",
    car_type: "Sedan",
    file: "https://images.unsplash.com/photo-1580273916550-e323be2ae537?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fGNhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60"
  }
].each { |car| car[:file] = URI.open(car[:file]) }

i = 0
USERS.each do |user_attrs|
  user = User.create(user_attrs.merge({ password: "123456" }))
  puts "Creating new user: #{user.full_name}"
  5.times do
    current_car = cars[i]
    attributes = {
      year: Faker::Vehicle.year,
      price: Faker::Commerce.price(range: 50..1000.0),
      kilometers: rand(10_000..300_000),
      seats: rand(4..5),
      address: CITIES.sample
    }.merge(current_car.except(:file))

    car = Car.new(attributes)
    car.user = user
    car.photo.attach(io: current_car[:file], filename: "#{current_car[:model]}.jpg", content_type: "image/jpeg")
    car.save

    i += 1
    puts "Creating #{user.full_name}'s car: #{car.model}"
  end
end
