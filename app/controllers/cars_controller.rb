class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @cars = Car.all
  end
end
