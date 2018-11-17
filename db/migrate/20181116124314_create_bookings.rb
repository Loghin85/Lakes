class CreateBookings < ActiveRecord::Migration[5.2]
  def change
	drop_table(:bookings, if_exists: true)
    create_table :bookings do |t|
      t.integer :UserId
      t.string :NoOfPersons
      t.integer :TripId
      t.date :Date
      t.decimal :Price

      t.timestamps
    end
  end
end
