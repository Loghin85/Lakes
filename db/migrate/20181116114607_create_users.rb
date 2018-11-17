class CreateUsers < ActiveRecord::Migration[5.2]
  def change
	execute 'DROP TABLE if exists users cascade;'
    create_table :users do |t|
      t.string :Fname
      t.string :Lname
      t.string :Email
      t.string :Address
      t.string :Postcode
      t.string :City
      t.string :Country
      t.string :Phone
      t.string :Privilege
      t.string :CardRegistered
      t.string :Password

      t.timestamps
    end
  end
end
