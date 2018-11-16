class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :UserId
      t.string :NoOfPersons
      t.string :TripId
      t.date :Date
      t.decimal :Price

      t.timestamps
    end
  end
end
