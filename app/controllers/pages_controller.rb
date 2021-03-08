class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home

  end

  def main
  end

  def meet
    @user_long = []
    @user_lat = []
    User.all.each do |user|
      @user_long = user.longitude
      @user_lat = user.latitude
      # each user updates and saves their current location in the DB with watchCurrentLocation
      # current_user does the same streaming of their own location, and uses .near or similar method of Mapbox to 
      # filter other nearby users' location as described in this method
      # markers are generated and placed on the map
      # uses popups on the user markers on the map to allow to see bio and initiate  chat with users
    end
  end

  def update_location
    current_user.update(longitude: params[:longitude], latitude: params[:latitude])
    render json: current_user.to_json(only: [:latitude, :longitude])
  end

  private

  def location_params
    params.permit(:latitude, :longitude)
  end
end
