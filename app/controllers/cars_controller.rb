class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_user, only: %i[new create]

  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
  end
  
  def show
    @car = Car.find(params[:id])
  end

  def create
    @car = Car.new(car_params)
    @car.user = @user
    @car.save
    redirect_to cars_path(@car)
  end

  private

  def set_user
    @user = current_user
  end

  def car_params
    params.require(:car).permit(:price, :year)
  end
end
