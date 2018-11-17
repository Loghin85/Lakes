class Trip < ApplicationRecord
	has_many :lake_dest
	validates :Lakes, :Distance, :Duration, :Price, presence: true
end
