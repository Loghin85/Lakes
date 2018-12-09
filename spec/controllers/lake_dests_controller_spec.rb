require 'spec_helper'

RSpec.describe LakeDestsController, type: :controller do
	let!(:lake1) { create(:lake1) }
	let!(:user) { create(:user) }
	let!(:admin) { create(:admin) }
	
	
	describe 'index filter' do
		
		it "sets filter default" do
			district = "District1"
			altitude = "Altitude1"
			alkalinity = "Alkalinity1"
			river = "River1"
			depth = "Depth1"
			get :index
			expect(assigns(:districts)).to eq([district])
			expect(assigns(:altitudes)).to eq([altitude])
			expect(assigns(:alkalinities)).to eq([alkalinity])
			expect(assigns(:rivers)).to eq([river])
			expect(assigns(:depths)).to eq([depth])
			expect(assigns(:selectedDistricts)).to eq([])
			expect(assigns(:selectedAltitudes)).to eq([])
			expect(assigns(:selectedAlkalinities)).to eq([])
			expect(assigns(:Rivers)).to eq([])
			expect(assigns(:AreaMin)).to eq(0)
			expect(assigns(:AreaMax)).to eq(100)
			expect(assigns(:LatMin)).to eq(-90)
			expect(assigns(:LatMax)).to eq(90)
			expect(assigns(:LongMin)).to eq(-180)
			expect(assigns(:LongMax)).to eq(180)
		end
		
		it "updates filter values and data" do
			get :index, params: {Name: "Lake1", format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])

			get :index, params: {AreaMin: 5, AreaMax: 20, format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:AreaMin)).to eq("5")
			expect(assigns(:AreaMax)).to eq("20")
			get :index, params: {AreaMin: 15, AreaMax: 20, format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:AreaMin)).to eq("15")
			expect(assigns(:AreaMax)).to eq("20")
			get :index, params: {AreaMin: 1, AreaMax: 5, format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:AreaMin)).to eq("1")
			expect(assigns(:AreaMax)).to eq("5")
			get :index, params: {AreaMin: 1, AreaMax: 15, format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:AreaMin)).to eq("1")
			expect(assigns(:AreaMax)).to eq("15")
			
			get :index, params: {LatMin: 5, LatMax: 20, format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:LatMin)).to eq("5")
			expect(assigns(:LatMax)).to eq("20")
			get :index, params: {LatMin: 15, LatMax: 20, format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:LatMin)).to eq("15")
			expect(assigns(:LatMax)).to eq("20")
			get :index, params: {LatMin: 1, LatMax: 5, format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:LatMin)).to eq("1")
			expect(assigns(:LatMax)).to eq("5")
			get :index, params: {LatMin: 1, LatMax: 15, format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:LatMin)).to eq("1")
			expect(assigns(:LatMax)).to eq("15")
			
			get :index, params: {LongMin: 5, LongMax: 20, format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:LongMin)).to eq("5")
			expect(assigns(:LongMax)).to eq("20")
			get :index, params: {LongMin: 15, LongMax: 20, format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:LongMin)).to eq("15")
			expect(assigns(:LongMax)).to eq("20")
			get :index, params: {LongMin: 1, LongMax: 5, format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:LongMin)).to eq("1")
			expect(assigns(:LongMax)).to eq("5")
			get :index, params: {LongMin: 1, LongMax: 15, format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:LongMin)).to eq("1")
			expect(assigns(:LongMax)).to eq("15")
			
			get :index, params: {District: "District1", format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:selectedDistricts)).to eq("District1")
			get :index, params: {District: "WrongDistrict", format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:selectedDistricts)).to eq("WrongDistrict")
			
			get :index, params: {River: "River1", format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:Rivers)).to eq("River1")
			get :index, params: {River: "WrongRiver", format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:Rivers)).to eq("WrongRiver")
			
			get :index, params: {Altitude: "Altitude1", format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:selectedAltitudes)).to eq("Altitude1")
			get :index, params: {Altitude: "WrongAltitude", format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:selectedAltitudes)).to eq("WrongAltitude")
			
			get :index, params: {Alkalinity: "Alkalinity1", format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:selectedAlkalinities)).to eq("Alkalinity1")
			get :index, params: {Alkalinity: "WrongAlkalinity", format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:selectedAlkalinities)).to eq("WrongAlkalinity")
			
			get :index, params: {Depth: "Depth1", format: :json}
			expect(assigns(:lake_dests)).to eq([lake1])
			expect(assigns(:selectedDepths)).to eq("Depth1")
			get :index, params: {Depth: "WrongDepth", format: :json}
			expect(assigns(:lake_dests)).to eq([])
			expect(assigns(:selectedDepths)).to eq("WrongDepth")
			
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
			get :show, params: { id: lake1.id }
			expect(response).to have_http_status(200)
		end
		
		it '(user)' do
			login (user)
			get :show, params: { id: lake1.id }
			expect(response).to have_http_status(200)
		end
		
		it '(admin)' do
			login (admin)
			get :show, params: { id: lake1.id }
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
			get :edit, params: { id: lake1.id }
			expect(response).to redirect_to login_url
		end
		
		it '(user)' do
			login (user)
			get :edit, params: { id: lake1.id }
			expect(response).to redirect_to login_url
		end
		
		it '(admin)' do
			login (admin)
			get :edit, params: { id: lake1.id }
			expect(response).to have_http_status(200)
		end
	end
	
	describe 'DELETE #destroy' do
		
		it '(not logged in)' do
			delete :destroy, params: { id: lake1.id }
			expect(response).to redirect_to login_url
		end
		
		it 'user)' do
			login (user)
			delete :destroy, params: { id: lake1.id }
			expect(response).to redirect_to login_url
		end
		
		it '(admin)' do
			login (admin)
			delete :destroy, params: { id: lake1.id }
			expect(response).to redirect_to lake_dests_url
		end
		
	end
	
	describe 'POST #create' do
		it '(not logged in)' do
			post :create, params: { lake_dest: { Alkalinity: "-", Altitude: "-", Area: 5, Depth: "-", Details_Url: "-", District: "-", Lat: 50, Long: 30, Name: "-", River: "-" } }
			expect(response).to redirect_to login_url
		end
		
		it '(user)' do
			login (user)
			post :create, params: { lake_dest: { Alkalinity: "-", Altitude: "-", Area: 5, Depth: "-", Details_Url: "-", District: "-", Lat: 50, Long: 30, Name: "-", River: "-" } }
			expect(response).to redirect_to login_url
		end
		
		it '(admin)' do
			login (admin)
			post :create, params: { lake_dest: { Alkalinity: "-", Altitude: "-", Area: 5, Depth: "-", Details_Url: "-", District: "-", Lat: 50, Long: 30, Name: "-", River: "-" } }
			expect(response).to redirect_to '/lake_dests/'+User.last.id.to_s
		end
	end
	
	describe 'PATCH #update' do
		it '(not logged in)' do
			patch :update, params: { id: lake1.id, lake_dest: { Alkalinity: "--", Altitude: "--", Area: 10, Depth: "--", Details_Url: "--", District: "--", Lat: 30, Long: 50, Name: "--", River: "--" } }
			expect(response).to redirect_to login_url
		end
		
		it '(user)' do
			login (user)
			patch :update, params: { id: lake1.id, lake_dest: { Alkalinity: "--", Altitude: "--", Area: 10, Depth: "--", Details_Url: "--", District: "--", Lat: 30, Long: 50, Name: "--", River: "--" } }
			expect(response).to redirect_to login_url
		end
		
		it '(admin)' do
			login (admin)
			patch :update, params: { id: lake1.id, lake_dest: { Alkalinity: "--", Altitude: "--", Area: 10, Depth: "--", Details_Url: "--", District: "--", Lat: 30, Long: 50, Name: "--", River: "--" } }
			expect(response).to redirect_to '/lake_dests/'+lake1.id.to_s
		end
	end
end