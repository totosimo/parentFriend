class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  def index
    @bookings = policy_scope(Booking).order(created_at: :desc)
  end

  def show
  end

  def destroy
  end

  def update
  end

  def edit
  end

  def new
  end

  def create
  end

  private

  def set_booking
    @booking = Booking.where(user: current_user).find(params[:id])
  end
end
