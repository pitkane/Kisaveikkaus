class Sport < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  attr_accessible :name

  accepts_nested_attributes_for :events

  validates :name, :presence   => true,
            :uniqueness => { :case_sensitive => false }

end
