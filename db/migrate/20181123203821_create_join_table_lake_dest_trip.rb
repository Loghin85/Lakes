class CreateJoinTableLakeDestTrip < ActiveRecord::Migration[5.2]
  def change
    execute 'DROP TABLE if exists lake_dests_trips;'
	create_join_table :lake_dests, :trips do |t|
      # t.index [:lake_dest_id, :trip_id]
      # t.index [:trip_id, :lake_dest_id]
    end
  end
end
