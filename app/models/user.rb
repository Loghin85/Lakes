class User < ApplicationRecord
	has_many :booking
	has_many :credit_card
	
	validates :Fname, :Lname, :Address, :Postcode, :City, :Country, :Phone, :Privilege, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :Email, presence: true, length: { maximum: 75 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
end
