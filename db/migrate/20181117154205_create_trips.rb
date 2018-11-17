class CreateTrips < ActiveRecord::Migration[5.2]
  def change
	drop_table(:trips, if_exists: true)
    create_table :trips do |t|
      t.string :Name
      t.string :Lakes
      t.date :Date
      t.decimal :Price
      t.integer :AvailablePlaces

      t.timestamps
    end
  end
end
