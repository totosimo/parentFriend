class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home

  end

  def main
  end

  def meet
      # each user updates and saves their current location in the DB with watchCurrentLocation
      # current_user does the same streaming of their own location, and uses .near or similar method of Mapbox to 
      # filter other nearby users' location as described in this method
      # markers are generated and placed on the map
      # uses popups on the user markers on the map to allow to see bio and initiate chat with users
      # DONE: use geocoded by :lat and long
      @users = User.all
      @markersUsers = @users.geocoded.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude,
          infoWindow: render_to_string(partial: "info_window_user", locals: { user: user })
        }
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
