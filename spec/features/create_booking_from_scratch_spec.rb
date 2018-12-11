require 'spec_helper'
require 'capybara/rspec'

feature "Create a booking use case" do
	let!(:trip1) { create(:trip1) }
	let!(:user) { create(:user) }
	scenario 'gets to index' do
		visit(root_url)
		expect(page).to have_content('Sign up')
		click_link 'Sign up'
		expect(page).to have_content('New User')
		click_button 'Submit'
		expect(page).to have_content("Fname can't be blank")
		fill_in 'First Name', :with=>'Sharon'
		click_button 'Submit'
		expect(page).to have_content("Lname can't be blank")
        fill_in 'Last Name', :with=>'Harrison'
		fill_in 'Email', :with=>'email1@email.com'
		click_button 'Submit'
		expect(page).to have_content("Address can't be blank")
		fill_in 'Address', :with=>'12003 High Street'
		click_button 'Submit'
		expect(page).to have_content("Postcode can't be blank")
		fill_in 'Postcode', :with=>'BD3 43Y'
		click_button 'Submit'
		expect(page).to have_content("Country can't be blank")
		fill_in 'Country', :with=>'Canada'
		click_button 'Submit'
		expect(page).to have_content("City can't be blank")
		fill_in 'City', :with=>'Vancouver'
		click_button 'Submit'
		expect(page).to have_content("Phone can't be blank")
		fill_in 'Phone', :with=>'+448367268937'
		click_button 'Submit'
		expect(page).to have_content("Password can't be blank")
		fill_in 'Password', :with=>'Password'
		click_button 'Submit'
		expect(page).to have_content("Password confirmation can't be blank")
		fill_in 'Password', :with=>'Password'
		fill_in 'Password confirmation', :with=>'Password1'
		click_button 'Submit'
		fill_in 'Password', :with=>'Password'
		fill_in 'Password confirmation', :with=>'Password'
		click_button 'Submit'
		expect(page).to have_content("Please check your email to activate your account.")
	end
	
	scenario 'Log in User' do
		visit(root_url)
		expect(page).to have_content('Login')
		click_link 'Login'
		fill_in 'Email', :with=>'email@email.com'
		fill_in 'Password', :with=>'Pass123'
		click_button 'Log in'
		expect(page).to have_content("Logged in successfully")
	end
	
	scenario 'Book&pay Trip' do
		visit (root_url)
		expect(page).to have_content('Login')
		click_link 'Login'
		fill_in 'Email', :with=>'email@email.com'
		fill_in 'Password', :with=>'Pass123'
		click_button 'Log in'
		expect(page).to have_content("Logged in successfully")
		click_link 'Hi'
		click_link 'My Cards'
		click_button 'New Credit Card'
		expect(page).to have_content('New Credit Card')
		select('Visa', :from => 'Organisation')
		fill_in 'Number', :with=>'4638 3642 2424 2366'
		page.find('#exp_date_year').set("2019")
		page.find('#exp_date_month').set("6")
		fill_in 'Name on card', :with=>'Jon Doe'
		click_button 'Create Credit card'
		expect(page).to have_content('Trips')
		click_link 'Trips'
		expect(page).to have_content('Trip1')
		expect(page).to have_content('Book')
		click_link 'Book'
		expect(page).to have_content('New Booking')
		fill_in 'Number of persons', :with=>21
		click_button 'Create Booking'
		expect(page).to have_content('Not enough places available')
		fill_in 'Number of persons', :with=>5
		click_button 'Create Booking'
		expect(page).to have_content('Booking was successfully created.')
		click_link 'Hi'
		click_link 'My Bookings'
		expect(page).to have_content('Pay')
		click_link 'Pay'
		expect(page).to have_content('Pay for booking')
		expect(page).to have_content('Pay cash on the day')
		choose 'booking_Paid_true'
		click_button 'Confirm payment method'
		expect(page).to have_content('Booking was successfully updated.')
	end
	
end