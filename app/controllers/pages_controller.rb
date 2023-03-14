CARDS = [
  {
    image: "white_car.jpg",
    title: "Look for speed",
    description: "Cancel or change most reservations for free up to 48 hours before pick-up."
  },
  {
    image: "comfort_car.jpg",
    title: "Look for comfort",
    description: "Clean cars. Flexible bookings. Rental counters that observe social distance."
  },
  {
    image: "security_car.jpg",
    title: "Look for security",
    description: "We are working with our partners to give you the security you need in your rental."
  },
  {
    image: "family_car.jpg",
    title: "Look for economy",
    description: "Found the same offer at a lower price? We match the price."
  }
]

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @cards = CARDS
  end
end
