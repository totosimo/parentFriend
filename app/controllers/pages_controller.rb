class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home

  end

  def main
  end

  def meet
      @users = User.near(current_user, 3)
      @markersUsers = @users.geocoded.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude,
          infoWindow: render_to_string(partial: "info_window_user", locals: { user: user }),
          image_url: helpers.asset_url('user.webp')
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
