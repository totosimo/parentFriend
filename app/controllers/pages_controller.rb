class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home

  end

  def main
  end

  def update_location
    current_user.update(longitude: params[:longitude], latitude: params[:latitude])
    # render json: current_user.to_json(only: [:latitude, :longitude])
  end

  private

  def location_params
    params.permit(:latitude, :longitude)
  end
end
