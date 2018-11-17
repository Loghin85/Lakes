namespace :users do
  desc "TODO"
  task seed_users: :environment do
	
	CreditCard.destroy_all
	User.destroy_all
	
	#create users
    20.times do |index |
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
  
   #give each user an addresses and credit card
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
  end

end
