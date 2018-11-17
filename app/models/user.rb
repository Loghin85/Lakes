class User < ApplicationRecord
	has_many :booking
	has_many :credit_card
	validates :Fname, :Lname, :Email, :Address, :Postcode, :City, :Country, :Phone, :Privilege, presence: true
end
