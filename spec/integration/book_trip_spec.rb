require 'spec_helper'
require 'rails_helper'



feature 'create customer' do
    background do
		@user = create(:user)
	end
	
	scenario "can book trip" do
		login(@user)
		visit'/bookings'
		expect(page).to have_content('Bookings')
		
		
		#visit '/customers/new'
        #expect(page).to have_content('Add a New Customer')
        
        #fill_in 'First name', :with=>'Sharon'
        #fill_in 'Last name', :with=>'Harrison'
        #fill_in 'Has good credit', :with=>1
        #click_button 'Create Customer'
        #expect(page).to have_content('First name: Sharon')
        #expect(page).to have_content('Last name: Harrison')
    end
end