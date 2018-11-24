namespace :users do
  desc "TODO"
  task seed_users: :environment do
	
	CreditCard.destroy_all
	User.destroy_all
	Trip.destroy_all
	Booking.destroy_all
	
	#create admin
		User.create!(
			Fname: "Admin",
			Lname: "1",
			Email: "admin@abdn.ac.uk",
			password: 'Pass#123',
			password_confirmation: 'Pass#123',
			Address: "-",
			Postcode: "-",
			City: "-",
			Country: "-",
			Phone: "-",
			Privilege: "Admin",
			activated: true,
            activated_at: Time.zone.now
		)
	#create user
		User.create!(
			Fname: "User",
			Lname: "1",
			Email: "user@abdn.ac.uk",
			password: 'Pass#123',
			password_confirmation: 'Pass#123',
			Address: "-",
			Postcode: "-",
			City: "-",
			Country: "-",
			Phone: "-",
			Privilege: "User",
			activated: true,
            activated_at: Time.zone.now
		)
	
	#create users
    20.times do |index|
		password = Faker::Internet.password(10, 20, true, true)
      User.create!(
        Fname: Faker::Name.first_name,
        Lname: Faker::Name.last_name,
		Email: Faker::Internet.free_email,
        Address: Faker::Address.street_address,
		Postcode: Faker::Address.postcode,
		City: Faker::Address.city,
		Country: Faker::Address.country,
		Phone: Faker::PhoneNumber.phone_number,
		CardRegistered: true,
		password: password,
		password_confirmation: password,
		activated: true,
		activated_at: Time.zone.now

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
	
	#create trips
	lakes = LakeDest.all
	lakes.each do |lake|
		trip = Trip.create!(
			Name: "The " + lake.Name + " tour",
			Lakes: lake.Name,
			Date: Faker::Date.between(Date.today, 1.year.from_now),
			Price: (Geocoder::Calculations.distance_between([57.1497,-2.0943], [lake.Lat,lake.Long])*0.5 + 20).round,
			AvailablePlaces: 20
		)
		trip.lake_dest << lake
	end
	10.times do |trip|
		lake1 = lakes.sample
		lake2 = lakes.sample
		while lake1 == lake2
			lake2 = lakes.sample
		end
		trip = Trip.create!(
			Name: "The " + Faker::Food.dish + " tour",
			Lakes: lake1.Name + ", " + lake2.Name,
			Date: Faker::Date.between(Date.today, 1.year.from_now),
			Price: (Geocoder::Calculations.distance_between([57.1497,-2.0943], [lake1.Lat,lake1.Long])*0.5 +
			Geocoder::Calculations.distance_between([lake1.Lat,lake1.Long],[lake2.Lat,lake2.Long])*0.5+ 40).round,
			AvailablePlaces: 20
		)
		trip.lake_dest << lake1
		trip.lake_dest << lake2
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
		trip = Trip.create!(
			Name: "The " + Faker::Food.dish + " tour",
			Lakes: lake1.Name + ", " + lake2.Name + ", " + lake3.Name,
			Date: Faker::Date.between(Date.today, 1.year.from_now),
			Price: (Geocoder::Calculations.distance_between([57.1497,-2.0943], [lake1.Lat,lake1.Long])*0.5 +
			Geocoder::Calculations.distance_between([lake1.Lat,lake1.Long],[lake2.Lat,lake2.Long])*0.5 +
			Geocoder::Calculations.distance_between([lake2.Lat,lake2.Long],[lake3.Lat,lake3.Long])*0.5+ 60).round,
			AvailablePlaces: 20
		)
		trip.lake_dest << lake1
		trip.lake_dest << lake2
		trip.lake_dest << lake3
	end
	p "trips created"
	
	#create bookings
	users = User.all
	trips = Trip.all
	40.times do |booking|
		user = users.sample
		trip = trips.sample
		persons = rand(1..10)
		while trip.AvailablePlaces<persons
			persons = rand(1..10)
		end
		trip.AvailablePlaces -= persons
		trip.save!
		Booking.create!(
			user_id: user.id,
			NoOfPersons: persons,
			trip_id: trip.id
		)
	end
	p "bookings created"
	
  end

end
