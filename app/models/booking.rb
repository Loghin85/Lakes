class Booking < ApplicationRecord
	belongs_to :user
	has_many :trip
	validates :UserId, :NoOfPersons, :TripId, :Date, :Price, presence: true
	
end
