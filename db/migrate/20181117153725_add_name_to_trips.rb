class AddNameToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :Name, :string
  end
end
