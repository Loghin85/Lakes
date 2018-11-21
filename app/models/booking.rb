class Booking < ApplicationRecord
	belongs_to :user
	belongs_to :trip
	validates :user_id, :NoOfPersons, :trip_id, :Date, :Price, presence: true
	
end
