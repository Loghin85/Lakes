class Booking < ApplicationRecord
	belongs_to :user
	has_one :trip
	validates :user_id, :NoOfPersons, :trip_id, :Date, :Price, presence: true
	
end
