class StatisticsController < ApplicationController
	skip_before_action :admin_user
	def index
	@bookings = Booking.all
	@lake_dests = LakeDest.all
	@year2018 = [0,0,0,0,0,0,0,0,0,0,0,0]
	@year2019 = [0,0,0,0,0,0,0,0,0,0,0,0]
	@year2020 = [0,0,0,0,0,0,0,0,0,0,0,0]
	@year2021 = [0,0,0,0,0,0,0,0,0,0,0,0]
	@money2018 = [0,0,0,0,0,0,0,0,0,0,0,0]
	@money2019 = [0,0,0,0,0,0,0,0,0,0,0,0]
	@money2020 = [0,0,0,0,0,0,0,0,0,0,0,0]
	@money2021 = [0,0,0,0,0,0,0,0,0,0,0,0]
	@bookings.each do |booking|
		if booking.trip.Date.year == 2018
			@year2018[booking.trip.Date.month-1] += booking.NoOfPersons
			@money2018[booking.trip.Date.month-1] += booking.NoOfPersons * booking.trip.Price
		elsif booking.trip.Date.year == 2019
			@year2019[booking.trip.Date.month-1] += booking.NoOfPersons
			@money2019[booking.trip.Date.month-1] += booking.NoOfPersons * booking.trip.Price
		elsif booking.trip.Date.year == 2020
			@year2020[booking.trip.Date.month-1] += booking.NoOfPersons
			@money2020[booking.trip.Date.month-1] += booking.NoOfPersons * booking.trip.Price
		elsif booking.trip.Date.year == 2021
			@year2021[booking.trip.Date.month-1] += booking.NoOfPersons
			@money2021[booking.trip.Date.month-1] += booking.NoOfPersons * booking.trip.Price
		end
		
	end
	p @year2018
	end
end
