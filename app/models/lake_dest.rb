class LakeDest < ApplicationRecord
	has_and_belongs_to_many :trip, dependent: :delete_all
end
