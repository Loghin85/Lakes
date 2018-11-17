class Trip < ApplicationRecord
	has_many :lake_dest
	validates :Name, :Lakes, :Date, :Price, presence: true
end
