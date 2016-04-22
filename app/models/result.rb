class Result < ActiveRecord::Base

  belongs_to :event, :class_name => "Event", :foreign_key => "event_id"

  belongs_to :country, :class_name => "Country", :foreign_key => "country_id"

  attr_accessible :rank, :event, :country, :sport_id, :event_id, :country_id

  validates :rank, :country, :event, :presence   => true

end
