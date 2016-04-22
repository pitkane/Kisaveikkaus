class CountriesController < ApplicationController
  def index
    @countries = Country.all
  end

  def get_iso_code
    country = params[:country_name]
    iso_code = Country.find_by_name(country).iso_code
    render :text => iso_code, :status => '200'
  end

  def get_flags
    @html = ""
    @fetched_countries = Country.all( :conditions => "name like '#{params[:first_letter]}%'")
    i = 1
    @html = "<div class='row country-row'>"
    @fetched_countries.each do |country|
      if i % 5 == 0
        @html += "<div class='row country-row'>"
        i = 1
      end

      @html += "<div class='span3 '>"
      @html += "<div class='country-name'>#{country.name}</div>"
      @html += "<div class='country-image thumbnail'><img  alt='#{country.id.to_s}' src='/assets/countries/x100/#{country.id.to_s}.png' /></div></div>"
      if i % 4 == 0
        @html += "</div>"
      end
      i = i + 1

    end
    render :text => @html

  end

end
