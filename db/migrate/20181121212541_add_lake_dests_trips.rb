class AddLakeDestsTrips < ActiveRecord::Migration[5.2]
    def self.up
    create_table :lake_dests_trips, :id => false do |t|
      t.integer :lake_dest_id
      t.integer :trip_id
    end
  end

  def self.down
    drop_table :lake_dests_trips
  end
end

