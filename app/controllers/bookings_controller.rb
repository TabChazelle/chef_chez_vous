class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_booking, only: %i[update show edit destroy]
  before_action :set_user, only: [:create]

  def new
    @booking = Booking.new(chef_id: params[:chef_id])
  end

  def create
    @chef = Chef.find(params[:booking][:chef_id])
    @booking = @chef.bookings.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path, notice: "Booking was successful!👍"
    else
      render :new
    end
  end

  def index
    @bookings = Booking.where(user_id: current_user)
  end

  def show
  end

  def edit
    @chef = @booking.chef
  end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_path(@booking), notice: "Booking was successfully updated!👍"
    else
      render :edit
    end
  end

  def destroy
    if @booking.destroy
      redirect_to bookings_path, notice: "Booking has been cancelled ❌"
    else
      flash[:error] = "Error: Booking could not be cancelled."
      redirect_to bookings_path
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_chef
    @chef = User.find(params[:user_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :chef_id)
  end

  def set_user
    @user = current_user
  end
end
