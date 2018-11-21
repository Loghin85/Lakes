class Trip < ApplicationRecord
	belongs_to :booking
	has_many :lake_dest
	validates :Name, :Lakes, :Date, :Price, presence: true
end
