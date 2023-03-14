class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]

  def index
    @bookings = Booking.all
  end

  def show
  end

  private

  def update_params
    params.require(:booking).permit(:accepted)
  end

  def renter_booking_params
    params.require(:booking).permit(:from, :to)
  end

  def set_user
    @user = current_user
    # @user = User.find(params[:user_id])
  end

  def set_car
    @car = Car.find(params[:car_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
