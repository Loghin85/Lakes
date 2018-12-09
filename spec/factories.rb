FactoryBot.define do
  factory :user do
    Fname { "John" }
    Lname  { "Doe" }
	Email  { "email@email.com" }
	Address  { "12 High street" }
	Postcode  { "362858" }
	City  { "Aloha" }
	Country  { "Greece" }
	Phone  { "7836628263892" }
	Privilege  { "User" }
	password { "Pass123" }
	password_confirmation { "Pass123" }
	activated { true }
	activated_at { Time.now }
  end
  
  factory :admin, class: User do
	Fname { "Admin" }
    Lname  { "1" }
	Email  { "admin@email.com" }
	Address  { "12 High street" }
	Postcode  { "362858" }
	City  { "Aloha" }
	Country  { "Greece" }
	Phone  { "7836628263892" }
	Privilege  { "Admin" }
	password { "Pass123" }
	password_confirmation { "Pass123" }
	activated { true }
	activated_at { Time.now }
  end
  
  factory :lake1, class: LakeDest do
	Name { "Lake1" }
	Area { 10 }
	District { "District1" }
	Lat { 10 }
	Long { 10 }
	River { "River1" }
	Details_Url { "Url1" }
	Altitude { "Altitude1" }
	Alkalinity { "Alkalinity1" }
	Depth { "Depth1" }
  end
  
  factory :trip1, class: Trip do
	Name { "Trip1" }
	Lakes { "Lake1" }
	Date { Date.today.change(year: 2019, month: 1, day: 17) }
	Price { 50 }
	AvailablePlaces { 20 }
  end
  
end