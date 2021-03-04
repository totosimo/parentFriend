class EventsController < ApplicationController

  def index
    @events = policy_scope(Event)
  end

  def show
    @event = Event.find(params[:id])
  end


end
