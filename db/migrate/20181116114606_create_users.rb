class CreateUsers < ActiveRecord::Migration[5.2]
  def change
	execute 'DROP TABLE if exists users;'
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
      t.string :Password_digest
      t.timestamps
    end
	add_index :users, :Email, unique: true
  end
end
