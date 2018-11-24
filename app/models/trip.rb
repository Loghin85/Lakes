class Trip < ApplicationRecord
	has_many :booking, dependent: :delete_all
	has_and_belongs_to_many :lake_dest, dependent: :delete_all
	validates :Name, :Lakes, :Date, :Price, presence: true
end
