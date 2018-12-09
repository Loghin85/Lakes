require 'spec_helper'

RSpec.describe TripsController, type: :controller do
	let!(:lake1) { create(:lake1) }
	let!(:user) { create(:user) }
	let!(:admin) { create(:admin) }
	let!(:trip1) { create(:trip1) }
	
	describe 'index filter' do
		
		it "sets filter default" do
			get :index
			expect(assigns(:Persons)).to eq(1)
			expect(assigns(:DateMin)).to eq(Date.today)
			expect(assigns(:DateMax)).to eq(Date.today+5.year)
		end
		
		it "updates filter values and data" do
			get :index, params: {Name: "Trip1", format: :json}
			expect(assigns(:trips)).to eq([trip1])
			
			get :index, params: {DateMin: Date.new(2018, 12, 9).to_s(:db) , DateMax: Date.new(2019, 12, 9).to_s(:db) , format: :json}
			expect(assigns(:trips)).to eq([trip1])
			expect(assigns(:DateMin)).to eq(Date.new(2018, 12, 9).to_s(:db) )
			expect(assigns(:DateMax)).to eq(Date.new(2019, 12, 9).to_s(:db) )
			get :index, params: {DateMin: Date.new(2019, 6, 9).to_s(:db) , DateMax: Date.new(2019, 12, 9).to_s(:db) , format: :json}
			expect(assigns(:trips)).to eq([])
			expect(assigns(:DateMin)).to eq(Date.new(2019, 6, 9).to_s(:db) )
			expect(assigns(:DateMax)).to eq(Date.new(2019, 12, 9).to_s(:db) )
			get :index, params: {DateMin: Date.new(2018, 12, 9).to_s(:db) , DateMax: Date.new(2019, 1, 9).to_s(:db) , format: :json}
			expect(assigns(:trips)).to eq([])
			expect(assigns(:DateMin)).to eq(Date.new(2018, 12, 9).to_s(:db) )
			expect(assigns(:DateMax)).to eq(Date.new(2019, 1, 9).to_s(:db) )
		end
	end
	
	describe 'GET index' do
		
		it '(not logged in)' do
			get :index
			expect(response).to have_http_status(200)
		end

		it '(user)' do
			login (user)
			get :index
			expect(response).to have_http_status(200)
		end
			
		it '(admin)' do
			login (admin)
			get :index
			expect(response).to have_http_status(200)
		end	
	end
	
	describe 'GET #show' do
		
		it '(not logged in)' do
			get :show, params: { id: trip1.id }
			expect(response).to have_http_status(200)
		end
		
		it '(user)' do
			login (user)
			get :show, params: { id: trip1.id }
			expect(response).to have_http_status(200)
		end
		
		it '(admin)' do
			login (admin)
			get :show, params: { id: trip1.id }
			expect(response).to have_http_status(200)
		end
	end
	
	describe 'GET #new' do
		
		it '(not logged in)' do
			get :new
			expect(response).to redirect_to login_url
		end
		
		it '(user)' do
			login (user)
			get :new
			expect(response).to redirect_to login_url
		end
		
		it '(admin)' do
			login (admin)
			get :new
			expect(response).to have_http_status(200)
		end
	end
	
	describe 'GET #edit' do
		
		it '(not logged in)' do
			get :edit, params: { id: trip1.id }
			expect(response).to redirect_to login_url
		end
		
		it '(user)' do
			login (user)
			get :edit, params: { id: trip1.id }
			expect(response).to redirect_to login_url
		end
		
		it '(admin)' do
			login (admin)
			get :edit, params: { id: trip1.id }
			expect(response).to have_http_status(200)
		end
	end
	
	describe 'DELETE #destroy' do
		
		it '(not logged in)' do
			delete :destroy, params: { id: trip1.id }
			expect(response).to redirect_to login_url
		end
		
		it 'user)' do
			login (user)
			delete :destroy, params: { id: trip1.id }
			expect(response).to redirect_to login_url
		end
		
		it '(admin)' do
			login (admin)
			delete :destroy, params: { id: trip1.id }
			expect(response).to redirect_to trips_url
		end
		
	end
	
	describe 'POST #create' do
		it '(not logged in)' do
			post :create, params: { trip: { AvailablePlaces: 20, Date: Date.new(2018, 12, 9).to_s(:db), lake_dests: [lake1.id], Name: "-" } }
			expect(response).to redirect_to login_url
		end
		
		it '(user)' do
			login (user)
			post :create, params: { trip: { AvailablePlaces: 20, Date: Date.new(2018, 12, 9).to_s(:db), lake_dests: [lake1.id], Name: "-"} }
			expect(response).to redirect_to login_url
		end
		
		it '(admin)' do
			login (admin)
			post :create, params: { trip: { AvailablePlaces: 20, Date: Date.new(2018, 12, 9).to_s(:db), lake_dests: [lake1.id], Name: "-" } }
			expect(response).to redirect_to '/trips/'+Trip.last.id.to_s
		end
	end
	
	describe 'PATCH #update' do
		it '(not logged in)' do
			patch :update, params: { id: trip1.id, trip: { AvailablePlaces: 25, Date: Date.new(2018, 11, 9).to_s(:db), lake_dests: [lake1.id], Name: "--" } }
			expect(response).to redirect_to login_url
		end
		
		it '(user)' do
			login (user)
			patch :update, params: { id: trip1.id, trip: { AvailablePlaces: 25, Date: Date.new(2018, 11, 9).to_s(:db), lake_dests: [lake1.id], Name: "--" } }
			expect(response).to redirect_to login_url
		end
		
		it '(admin)' do
			login (admin)
			patch :update, params: { id: trip1.id, trip: { AvailablePlaces: 25, Date: Date.new(2018, 11, 9).to_s(:db), lake_dests: [lake1.id], Name: "--" } }
			expect(response).to redirect_to '/trips/'+trip1.id.to_s
		end
	end
end