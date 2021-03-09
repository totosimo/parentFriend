class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]
  def index
    @bookings = policy_scope(Booking).order(created_at: :desc)
  end

  def show
    authorize @booking
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to bookings_path
  end

  def create
    @event = Event.find(params[:event_id])
    @booking = Booking.new
    @booking.user = current_user
    @booking.event = @event
    authorize @booking
    if booking.save!
      redirect_to booking_path(@booking)
    else
      render event_path(@event)
    end
  end

  private

  def set_booking
    @booking = Booking.where(user: current_user).find(params[:id])
  end
end
