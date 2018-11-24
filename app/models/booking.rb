class Booking < ApplicationRecord
	belongs_to :user
	belongs_to :trip
	validates :user_id, :NoOfPersons, :trip_id, presence: true
	
end
