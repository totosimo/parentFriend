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
    authorize @booking
    if event_booked?(@event) == 0
      @booking.user = current_user
      @booking.event = @event
      if @booking.save!
        redirect_to booking_path(@booking), notice: "Your booking has been successfully created"
      else
        redirect_to event_path(@event), notice: "Booking aborted, the event has been cancelled by the host"
      end
    else
      redirect_to event_path(@event), notice: "You are already attending this event!"
    end
  end

  private

  def set_booking
    @booking = Booking.where(user: current_user).find(params[:id])
  end

  def event_booked?(ev)
    found = 0
    ev.bookings.each do |booking|
      found = 1 if booking.user == current_user
    end
    return found
  end
end
