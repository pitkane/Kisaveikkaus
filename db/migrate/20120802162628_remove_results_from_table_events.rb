class RemoveResultsFromTableEvents < ActiveRecord::Migration
  def up
    remove_column :events, :first_id
    remove_column :events, :second_id
    remove_column :events, :third_id
  end

  def down
    add_column :events, :third_id, :integer
    add_column :events, :second_id, :integer
    add_column :events, :first_id, :integer
  end
end
