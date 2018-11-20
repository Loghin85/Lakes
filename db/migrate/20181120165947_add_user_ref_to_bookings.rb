class AddUserRefToBookings < ActiveRecord::Migration[5.2]
  def change
    add_index :bookings, :user_id
  end
end
