class CreateLakeDests < ActiveRecord::Migration[5.2]
  def change
    create_table :lake_dests do |t|
      t.string :Name
      t.decimal :Area
      t.string :District
      t.decimal :Lat
      t.decimal :Long
      t.string :River
      t.string :Details_Url
      t.string :Altitude
      t.string :Alkalinity
      t.string :Depth

      t.timestamps
    end
  end
end
