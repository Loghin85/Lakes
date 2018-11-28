class LakesController < ApplicationController
  skip_before_action :logged_in_user
  skip_before_action :admin_user
  def index
	@trips =Trip.all
	@names = []
	@places = []
	@id = []
	@trips.each do |trip|
		@names << trip.Name
		@places << trip.AvailablePlaces
		@id << trip.id
	end
  end
end
