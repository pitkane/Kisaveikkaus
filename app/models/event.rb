class Event < ActiveRecord::Base

  has_many :guesses
  has_many :results

  #has_many :first, :class_name => "Result", :foreign_key => "result_first_id"
  #has_many :second, :class_name => "Result", :foreign_key => "result_second_id"
  ##has_many :third, :class_name => "Result", :foreign_key => "result_third_id"

  belongs_to :sport, :class_name => 'Sport', :foreign_key => "sport_id"

  attr_accessible :name, :sport, :first, :second, :third, :series


  validates :name, :presence   => true #:uniqueness => { :case_sensitive => false }
  validates :sport, :presence   => true
  validates :series, :presence   => true

end
