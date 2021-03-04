class EventsController < ApplicationController

  def index
    @events = policy_scope(Event)
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { event: event })
      }
    end
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
  end


end
