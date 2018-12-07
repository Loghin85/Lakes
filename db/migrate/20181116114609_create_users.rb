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
      t.string :Privilege, default: "User"
      t.boolean :CardRegistered, default: false
	  t.string :password_digest
      t.timestamps
    end
	add_index :users, :email,                unique: true
  end
end
