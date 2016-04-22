class Guess < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :country
  belongs_to :sport
  attr_accessible :rank, :event, :user, :country, :sport

  validates :rank, :presence   => true
  validates :event, :presence   => true
  validates :country, :presence   => true
  validates :sport, :presence   => true
  validates :user, :presence   => true
end
