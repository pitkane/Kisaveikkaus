class CreateResults < ActiveRecord::Migration
  def up
  	create_table :results do |t|
      t.references :event
      t.references :country
      t.integer :rank

      t.timestamps
    end
  end

  def down
  	drop_table :results
  end
end
