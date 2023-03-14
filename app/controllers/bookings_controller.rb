class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]
  before_action :set_car, only: %i[create]
  before_action :set_user, only: %i[create]

  def index
    @bookings = Booking.all
  end

  def show
  end
  
  def create
    @booking = Booking.new(booking_params)
    @booking.car = @car
    @booking.user = @user
    if @booking.save
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_user
    @user = current_user
  end

  def set_car
    @car = Car.find(params[:car_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
