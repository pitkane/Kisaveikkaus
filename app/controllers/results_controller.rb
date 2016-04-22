# encoding: UTF-8

# results_controller.rb

class ResultsController < ApplicationController

  before_filter :authenticate_user!

  def index

    @users = User.all
    @sports = Sport.all
    @events = Event.all
    @results = Result.all

  end


	def new
	
		@result = Result.new
		@sports = Sport.all

    respond_to do |format|
      format.html
    end
  end


  def get_events
    sport_id = params[:sport_id]
    sport = Sport.find(sport_id)
    @events_json = sport.events.all
    
    respond_to do |format|
      format.json { render json: @events_json }
    end
  end

  def sport_results
    @html = ""

    all_events = Sport.find(params[:sport_id]).events
    all_results_for_sport = Result.find_all_by_sport_id( params[:sport_id] )

    all_events.each do |event|
      @html += "<div class='accordion-inner'>"
      @html += "<div class='row'>"
      @html += "<div class='span2 place-holder'>#{event.name} (#{ get_series(event.series) })</div>"

      (1..3).each do |i|
        @html += "<div class='span2' style='width: 210px; margin-left: 15px;'>"

        @html += "<div class='flag-holder' id='flag_#{event.id.to_s}_#{i.to_s}'> </div>"
        @html += "<div id='status_#{event.id.to_s}_#{i.to_s}' class='control-group' style='margin-bottom: 0px'>"
        @html += "<input event_id='#{event.id.to_s}' rank='#{i.to_s}' class='data_input' id='input_#{event.id.to_s}_#{i.to_s}' style='width: 120px; margin-bottom: 3px;' type='text' data-items='4' data-provide='typeahead' data-source='#{ get_countries }'>"

        #@html += "<input event_id='#{event.id.to_s}' rank='#{i.to_s}' class='data_input' id='input_#{event.id.to_s}_#{i.to_s}' style='width: 120px; margin-bottom: 3px;' type='text' '>"

        @html += "<a class='remove-result' event_id='#{event.id.to_s}' rank='#{i.to_s}' style='text-decoration: none; padding-left: 5px;'><i class='icon-remove'></i></a>"
        # @html += "<a class='add-guess' event_id='#{event.id.to_s}' rank='#{i.to_s}' style='text-decoration: none; padding-left: 5px;'><i class='icon-ok'></i></a>"
        @html += "</div>"

        @html += "</div>"
      end

      @html += "</div></div>"
    end


    render :text => @html

  end

  def get_sport_results
    asdf = params[:sport_id]
    sport_results = Result.where("sport_id = ?", params[:sport_id])
    #user_id = current_user.id #params[:user_id]
    #@user_guesses_json = User.find(user_id).guesses
    #render :text => user_id, status => '200'
    respond_to do |format|
      format.json { render json: sport_results }
    end
  end

  def destroy

    res = Result.find_by_event_id_and_rank(params[:result][:event], params[:result][:rank])
    
    if res
      
      allguesses = Guess.where( "event_id = ? AND country_id = ? AND rank = ?", res.event.id, res.country.id, res.rank ) 
      allguesses.each do |gu|
        juuseri = User.find_by_id( gu.user_id )
       juuseri.update_attribute("points", juuseri.points - 1)
      end

      res.destroy
      render :text => "Success", :status => '200'
    else
      render :text => "Not found", :status => '404'
    end

  end

  def create

    new_country = Country.find_by_name(params[:result][:country])

    if new_country
      event = Event.find(params[:result][:event])
      rank = params[:result][:rank]
      sport = Sport.find(event.sport_id)
      updating = Result.find_by_event_id_and_rank(event.id, rank)

      if updating
        temp_rank = updating.rank
        temp_countryid = new_country.id
        temp_eventid = updating.event_id
        temp_sportid = updating.sport_id

        updating.destroy

        User.all.each do |user|
          wtf = Guess.where("event_id = ? AND user_id = ? AND country_id = ? AND rank = ?", temp_eventid, user.id, updating.country_id, temp_rank).empty?
          if wtf == false
            user.update_attribute("points", user.points - 1 )
          end
        end

        res = Result.create(:country_id => temp_countryid, :event_id => temp_eventid, :rank => temp_rank, :sport_id => temp_sportid)
        User.all.each do |user|
          wtf = Guess.where("event_id = ? AND user_id = ? AND country_id = ? AND rank = ?", temp_eventid, user.id, temp_countryid, temp_rank).empty?
          if wtf == false
            user.update_attribute("points", user.points + 1)
          end
        end
        render :text => "Created", :status => '200'
      else
        res = Result.create(:country => new_country, :event => event, :rank => rank, :sport_id => sport.id)

        User.all.each do |user|
          wtf = Guess.where("event_id = ? AND user_id = ? AND country_id = ? AND rank = ?", event.id, user.id, new_country.id, rank).empty?
          if wtf == false
            user.update_attribute("points", user.points + 1)
          end
        end

        render :text => "Created", :status => '204'
      end
    else
      render :text => "Not found", :status => '404'

    end

  end

  def recalculate
    User.all.each do |user|
      user.points = 0
      user.save
    end

    Result.all.each do |res|

      User.all.each do |user|
        wtf = Guess.where("event_id = ? AND user_id = ? AND country_id = ? AND rank = ?", res.event.id, user.id, res.country.id, res.rank).empty?
        if wtf == false
          user.update_attribute("points", user.points + 1)
        end
      end
      
    end

    redirect_to(users_path)

  end


end
