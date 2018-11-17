class Trip < ApplicationRecord
	belongs_to :booking
	has_many :lake_dest
	validates :Lakes :Distance :Duration :Price
end
