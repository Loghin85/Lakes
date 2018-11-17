class Booking < ApplicationRecord
	belongs_to :user
	has_many :trip
	validates :UserId :NoOfPersons :TripId :date :price
	
end
