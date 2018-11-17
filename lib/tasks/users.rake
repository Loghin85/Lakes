namespace :users do
  desc "TODO"
  task seed_users: :environment do
	
	CreditCard.destroy_all
	User.destroy_all
	Trip.destroy_all
	Booking.destroy_all
	
	#create users
    20.times do |index|
      User.create!(
        Fname: Faker::Name.first_name,
        Lname: Faker::Name.last_name,
		Email: Faker::Internet.email,
        Address: Faker::Address.street_address,
		Postcode: Faker::Address.postcode,
		City: Faker::Address.city,
		Country: Faker::Address.country,
		Phone: Faker::PhoneNumber.phone_number,
		Privilege: "User"
      
      )
    end
  
   #give each user a credit card
    names = User.all
    names.each do | user|
      year = [2020, 2021, 2022, 2023]
      organisations = ["American Express", "MasterCard", "Visa"]
      CreditCard.create!(
        user_id: user.id,
        number: Faker::Number.number(12),
        exp_date: year.sample.to_s + "/" + Faker::Number.between(1,12).to_s,
        name_on_card: user.Fname + " " + user.Lname,
        organisation: organisations.sample.to_s
      )
    end
    p "users created"
	
	lakes = LakeDest.all
	lakes.each do |lake|
		Trip.create!(
			Name: "The " + lake.Name + " tour",
			Lakes: lake.Name,
			Date: Faker::Date.between(Date.today, 1.year.from_now),
			Price: (Geocoder::Calculations.distance_between([57.1497,-2.0943], [lake.Lat,lake.Long])*0.5 + 20).round,
			AvailablePlaces: 20
		)
	end
	10.times do |trip|
		lake1 = lakes.sample
		lake2 = lakes.sample
		while lake1 == lake2
			lake2 = lakes.sample
		end
		Trip.create!(
			Name: "The " + Faker::Food.dish + " tour",
			Lakes: lake1.Name + ", " + lake2.Name,
			Date: Faker::Date.between(Date.today, 1.year.from_now),
			Price: (Geocoder::Calculations.distance_between([57.1497,-2.0943], [lake1.Lat,lake1.Long])*0.5 
			Geocoder::Calculations.distance_between([lake1.Lat,lake1.Long],[lake2.Lat,lake2.Long])*0.5+ 40).round,
			AvailablePlaces: 20
		)
	end
	5.times do |trip|
		lake1 = lakes.sample
		lake2 = lakes.sample
		lake3 = lakes.sample
		while lake1 == lake2
			lake2 = lakes.sample
		end
		while lake1 == lake3 || lake2 == lake3
			lake3 = lakes.sample
		end
		Trip.create!(
			Name: "The " + Faker::Food.dish + " tour",
			Lakes: lake1.Name + ", " + lake2.Name + ", " + lake3.Name,
			Date: Faker::Date.between(Date.today, 1.year.from_now),
			Price: (Geocoder::Calculations.distance_between([57.1497,-2.0943], [lake1.Lat,lake1.Long])*0.5 
			Geocoder::Calculations.distance_between([lake1.Lat,lake1.Long],[lake2.Lat,lake2.Long])*0.5
			Geocoder::Calculations.distance_between([lake2.Lat,lake2.Long],[lake3.Lat,lake3.Long])*0.5+ 60).round,
			AvailablePlaces: 20
		)
	end
	p "trips created"
	
	users = User.all
	trips = Trip.all
	15.times do |booking|
		user = users.sample
		trip = trips.sample
		persons = Faker::Number.between(1, 10)
		Booking.create!(
			UserId: user.id,
			NoOfPersons: 2,
			TripId: trip.id,
			Date: trip.Date,
			Price: trip.Price*2
		)
	end
	p "bookings created"
	
  end

end
