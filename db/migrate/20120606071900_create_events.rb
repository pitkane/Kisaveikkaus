class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name

      t.references :sport

      t.integer :first_id
      t.integer :second_id
      t.integer :third_id
      t.integer :series

      t.timestamps
    end
  end
end
