class AddSportToGuesses < ActiveRecord::Migration
  def self.up
    add_column :guesses, :sport_id, :integer

    all_guesses = Guess.all()
    all_guesses.each do |guess|
    	eventti = Event.find(guess.event_id)
    	guess.sport_id = eventti.sport_id
    	guess.save
    end

  end
  def self.down
  	remove_column :guesses, :sport_id  	
  end
end