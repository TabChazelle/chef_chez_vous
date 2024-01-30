class BookingsController < ApplicationController
  before_action :set_booking, only: [:update, :destroy]
  before_action :set_user, only: [:create]

  def new
  end

  def create
    @booking = @chef.bookings.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path, notice: "Booking was successfull!👍"
    else
      render :new
    end
  end

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.new
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_path, notice: "Booking was successfully updated!👍"
    else
      render :new
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: "Booking has been cancelled ❌"
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_chef
    @chef = User.find(params[:user_id])
  end

  def booking_params
    params.require(:booking).permit(:date, :time, :number_of_guests, :special_requests)
  end
end
