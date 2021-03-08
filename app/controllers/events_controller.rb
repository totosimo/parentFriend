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

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    #link API for gecoding
    # @event.latitude =
    # @event.longitude =
    authorize @event
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end
  def edit

  end
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
    authorize @event
  end
  private

  def event_params
    params.require(:event).permit(:name, :description, :date_time_start, :date_time_end, :address, :event_type, :photo)
  end
  
end
