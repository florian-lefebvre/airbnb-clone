class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @cars = Car.all
  end

  def new
  end

  def create
  end
end
