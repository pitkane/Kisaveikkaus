# encoding: UTF-8

class EventsController < ApplicationController

  before_filter :authenticate_user!

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new

    @event = Event.new
    @sports = Sport.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create

    @sport = Sport.find(params[:select_sport])
    @event = @sport.events.create(params[:event])
    # @sport.save
    # @sport << @event
    @sport = Sport.find(params[:select_sport])
    #@sport.Events << @event

    #eventti = sportti.events.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to new_event_path, notice: 'Kilpailu lisätty!' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update

    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy

    if current_user.admin?

      @event = Event.find(params[:id])
      @event.destroy
      flash[:notice] = "Tapahtuma poistettu"

    else
      flash[:notice] = "Tarvii adminii"
    end

    
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
