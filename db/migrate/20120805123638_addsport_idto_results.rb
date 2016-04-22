class AddsportIdtoResults < ActiveRecord::Migration
 def up
    add_column :results, :sport_id, :integer

    Result.all.each do |res|
    	res.update_attributes!( :sport_id => res.event.sport.id )
    end

  end
 
  def down
    remove_column :results, :sport_id
  end
end
