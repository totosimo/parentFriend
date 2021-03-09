class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  def index
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
