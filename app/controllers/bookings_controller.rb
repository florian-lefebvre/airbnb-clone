class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]
  before_action :set_car, only: %i[create booking_params]
  before_action :set_user, only: %i[create booking_params]

  def index
    bookings = policy_scope(Booking)
    @show_requests = current_user.owner?
    @requests = bookings.select { |b| b.car.user == current_user }
    @bookings = bookings.select { |b| b.user == current_user }
  end

  def show
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.car = @car
    @booking.user = @user
    authorize @booking
    if @booking.save
      redirect_to bookings_path
    else
      render "cars/show", status: :unprocessable_entity
    end
  end

  def update
    authorize @booking
    if @booking.update(car_params)
      redirect_to car_path(@car)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to cars_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(policy(Booking.new(user: @user, car: @car)).permitted_attributes)
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
