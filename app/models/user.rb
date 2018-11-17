class User < ApplicationRecord
	has_many :booking
	has_many :credit_card
	validates :Fname :Lname :Email :Adress :Postcode :City :Country :Phone :Privilege
end
