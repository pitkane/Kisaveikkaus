class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.references :event
      t.references :user
      t.references :country
      t.integer :rank

      t.timestamps
    end
    add_index :guesses, :event_id
    add_index :guesses, :user_id
    add_index :guesses, :country_id
  end
end
