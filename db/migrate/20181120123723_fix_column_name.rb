class FixColumnName < ActiveRecord::Migration[5.2]
  def change
	rename_column :bookings, :UserId, :user_id
	rename_column :bookings, :TripId, :trip_id
  end
end
