class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :Lakes
      t.string :Distance
      t.string :Duration
      t.decimal :Price
      t.string :AvalablePlaces

      t.timestamps
    end
  end
end
