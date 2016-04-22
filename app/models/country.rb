class Country < ActiveRecord::Base
  has_many :guesses
  has_many :results

  attr_accessible :iso_code, :name

  validates :name, :presence   => true,
            :uniqueness => { :case_sensitive => false }
  validates :iso_code, :presence   => true,
            :uniqueness => { :case_sensitive => false }
end
