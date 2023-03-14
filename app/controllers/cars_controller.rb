class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_user, only: %i[new create]
  before_action :set_car, only: %i[show edit update destroy]

  def index
    cars = policy_scope(Car)
    @show_my_cars = current_user.owner?
    @my_cars = cars.select { |c| c.user == current_user } if @show_my_cars
    @cars = cars.reject { |c| c.user == current_user }
  end

  def new
    @car = Car.new
    authorize @car
  end

  def show
    authorize @car
  end

  def create
    @car = Car.new(car_params)
    @car.user = @user
    authorize @car
    if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  def edit
    authorize @car
  end

  def update
    authorize @car
    if @car.update(car_params)
      redirect_to car_path(@car)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @car
    @car.destroy
    redirect_to cars_path, status: :see_other
  end

  private

  def set_user
    @user = current_user
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:price, :year)
  end
end
