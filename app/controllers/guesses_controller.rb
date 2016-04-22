# encoding: UTF-8

class GuessesController < ApplicationController

  before_filter :authenticate_user!

  before_filter :check_time, :only => [:index]

  def check_time
    t1 = Time.new
    t2 = Time.new(2012,7,27,21,0,0)
    difference = (t2 - t1)

    if difference < 0
      flash.now[:notice] = "Kisat ovat alkaneet, muutoksien tekeminen ei ole enään mahdollista!"
    end

  end


  def index

    @guesses = Guess.all
    @user_guesses = current_user.guesses
    @sports = Sport.all
    @countries = Country.all

    @page_title = "Kisaveikkaus 2012 - Omat arvaukset"
    respond_to do |format|
      format.html
    end
  end

  # GET /events/1
  # GET /events/1.json
  #def show
  #  @guesses = Event.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #  end
  #end

  # GET /events/new
  # GET /events/new.json
  def new
    # authenticate ? return : ""

    @guess = Guess.new

    respond_to do |format|
      format.html
    end
  end

  # GET /events/1/edit
  # def edit
  #   @event = Event.find(params[:id])
  # end

  # POST /events
  # POST /events.json
  def create
    # authenticate ? return : ""

    para = params

    #us = current_user
    #us1 = current_user.id
    user = current_user
    country = Country.find_by_name(params[:guess][:country])

    if country
      event = Event.find(params[:guess][:event])
      rank = params[:guess][:rank]
      sport = Sport.find(event.sport_id)
      updating = user.guesses.find_by_event_id_and_rank(event.id, rank)

      if updating
        updating.country = country
        updating.save
        render :text => "Created", :status => '200'
      else
        @guess = Guess.create(:country => country, :user => user, :event => event, :rank => rank, :sport => sport)
        render :text => "Created", :status => '204'
      end
    else
      render :text => "Not found", :status => '404'

    end

  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    # authenticate ? return : ""

    #@event = Guess.find(params[:id])
    #
    #respond_to do |format|
    #  if @event.update_attributes(params[:event])
    #    format.html { redirect_to @event, notice: 'Event was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @event.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /guesses
  # DELETE /guesses
  def destroy
    # authenticate ? return : ""

    user = current_user

    @guess = user.guesses.find_by_event_id_and_rank(params[:guess][:event], params[:guess][:rank])

    if @guess
      @guess.destroy
      render :text => "Success", :status => '200'
    else
      render :text => "Not found", :status => '404'
    end

  end

  def get_user_guesses
    user_id = current_user.id #params[:user_id]
    @user_guesses_json = User.find(user_id).guesses
    #render :text => user_id, status => '200'
    respond_to do |format|
      format.json { render json: @user_guesses_json }
    end
  end

  def sport_guesses
    @html = ""

    all_events = Sport.find(params[:sport_id]).events
    all_user_guesses = Guess.find_all_by_user_id(current_user.id)

    all_events.each do |event|
      @html += "<div class='accordion-inner'>"
      @html += "<div class='row'>"
      @html += "<div class='span2 place-holder'>#{event.name} (#{ get_series(event.series) })</div>"

      (1..3).each do |i|
        @html += "<div class='span2' style='width: 210px; margin-left: 15px;'>"

        @html += "<div class='flag-holder' id='flag_#{event.id.to_s}_#{i.to_s}'> </div>"
        @html += "<div id='status_#{event.id.to_s}_#{i.to_s}' class='control-group' style='margin-bottom: 0px'>"
        #@html += "<input event_id='#{event.id.to_s}' rank='#{i.to_s}' class='data_input' id='input_#{event.id.to_s}_#{i.to_s}' style='width: 120px; margin-bottom: 3px;' type='text' data-items='4' data-provide='typeahead' data-source='#{ get_countries }'>"

        @html += "<input event_id='#{event.id.to_s}' rank='#{i.to_s}' class='data_input' id='input_#{event.id.to_s}_#{i.to_s}' style='width: 120px; margin-bottom: 3px;' type='text' '>"

        @html += "<a class='remove-guess' event_id='#{event.id.to_s}' rank='#{i.to_s}' style='text-decoration: none; padding-left: 5px;'><i class='icon-remove'></i></a>"
        # @html += "<a class='add-guess' event_id='#{event.id.to_s}' rank='#{i.to_s}' style='text-decoration: none; padding-left: 5px;'><i class='icon-ok'></i></a>"
        @html += "</div>"

        @html += "</div>"
      end

      @html += "</div></div>"
    end


    render :text => @html

  end

  def gen_pdf

    pdf = Prawn::Document.new
    pdf.text "Hello World!"
    send_data pdf.render, filename: "kisaveikkaus.pdf",
                          type: "application/pdf"

  end

end



