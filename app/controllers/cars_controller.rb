class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_user, only: %i[new create]
  before_action :set_car, only: %i[show edit update destroy]

  def index
    if params[:query].nil?
      cars = policy_scope(Car)
    else
      cars = policy_scope(Car).search_by_model_and_car_type(params[:query])
    end
    @show_my_cars = current_user&.owner?
    @my_cars = cars.select { |c| c.user == current_user } if @show_my_cars
    @cars = cars.reject { |c| c.user == current_user }
    @markers = @cars.reject { |c| c.longitude.nil? }.map do |c|
      {
        lat: c.latitude,
        lng: c.longitude,
        info_window_html: render_to_string(partial: "cars/partial/card", locals: { car: c }),
        marker_html: render_to_string(partial: "cars/partial/marker", locals: { car: c }),
      }
    end
  end

  def new
    @car = Car.new
    authorize @car
  end

  def show
    @booking = Booking.new
    @markers = [{
      lat: @car.latitude,
      lng: @car.longitude,
      marker_html: render_to_string(partial: "cars/partial/marker", locals: { car: @car }),
    }]
    authorize @car
  end

  def create
    @car = Car.new(car_params)
    @car.user = @user
    authorize @car
    if @car.save
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessable_entity
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
    params.require(:car).permit(:price, :year, :kilometers, :seats, :car_type, :color, :model, :photo, :address)
  end
end
