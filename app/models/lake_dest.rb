class LakeDest < ApplicationRecord
	has_and_belongs_to_many :trip, dependent: :delete_all
	validates :Name, :District, :River, :Details_Url, :Altitude, :Alkalinity, presence: true 
	validates :Area, presence: true, numericality: { greater_than: 0, less_than: 1000000 }
	validates :Lat, presence: true, numericality: { greater_than: -90, less_than: 90 }
	validates :Long, presence: true, numericality: { greater_than: -180, less_than: 180 }
end
