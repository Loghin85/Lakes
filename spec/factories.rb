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
  
end