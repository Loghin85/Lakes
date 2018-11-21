class Trip < ApplicationRecord
	has_many :booking
	has_and_belongs_to_many :lake_dest
	validates :Name, :Lakes, :Date, :Price, presence: true
end
