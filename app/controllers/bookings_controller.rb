class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]
  before_action :set_car, only: %i[create update]
  before_action :set_user, only: %i[create update]

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

  def edit
    authorize @booking
  end

  def update
    authorize @booking
    owner_editing = @booking.car.user == current_user
    valid = @booking.update(owner_editing ? booking_params : booking_params.reverse_merge!({ status: "pending" }))
    if valid
      redirect_to bookings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(policy(Booking.new(user: @user, car: @car)).permitted_attributes)
  end

  def set_user
    @user = current_user
  end

  def set_car
    @car = @booking&.car || Car.find(params[:car_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
