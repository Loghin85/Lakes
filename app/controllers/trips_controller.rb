class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  skip_before_action :logged_in_user, only: [:show, :index]
  skip_before_action :admin_user, only: [:show, :index]

  # GET /trips
  # GET /trips.json
  def index
	@Persons = 1
	@DateMin = Date.today
	@DateMax = @DateMin+5.year
    @trips = Trip.all
	if params[:Name]
		@trips = @trips.where('"trips"."Name" LIKE ? OR "trips"."Lakes" LIKE ?', "%#{params[:Name]}%", "%#{params[:Name]}%")
	end
	if params[:DateMin] && params[:DateMax]
		@trips = @trips.where(Date: params[:DateMin]..params[:DateMax])
		@DateMin = params[:DateMin]
		@DateMax = params[:DateMax]
	end
	if params[:Persons]
		@trips = @trips.where('"trips"."AvailablePlaces" >= ?', params[:Persons])
		@Persons = params[:Persons]
	end
	@names = []
	@places = []
	@id = []
	@trips.each do |trip|
		@names << trip.Name
		@places << trip.AvailablePlaces
		@id << trip.id
	end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new
	@lakes = LakeDest.all
  end

  # GET /trips/1/edit
  def edit
	@lakes = LakeDest.all
  end

  # POST /trips
  # POST /trips.json
  def create
    @lakes = LakeDest.all
	if params[:trip][:lake_dests]
		lakes = ""
		lake_b = nil
		price = 0
		params[:trip][:lake_dests].each do |id|
			lake = LakeDest.find_by(id: id)
			lakes += lake.Name + " "
			if lake_b == nil
				price += Geocoder::Calculations.distance_between([57.1497,-2.0943], [lake.Lat,lake.Long])*0.5 + 20
			else
				price += Geocoder::Calculations.distance_between([lake.Lat,lake.Long], [lake_b.Lat,lake_b.Long])*0.5 + 20
			end
			lake_b = lake
		end
		price = price.round
	end
	
	@trip = Trip.new(trip_params.merge(Lakes: lakes, Price: price))
	
	if params[:trip][:lake_dests]
		params[:trip][:lake_dests].each do |id|
			lake = LakeDest.find_by(id: id)
			@trip.lake_dest << lake
		end
	end
	
    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip
					flash[:info] = 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
  
	if params[:trip][:lake_dests]
		lakes = ""
		lake_b = nil
		price = 0
		params[:trip][:lake_dests].each do |id|
			lake = LakeDest.find_by(id: id)
			lakes += lake.Name + ", "
			if lake_b == nil
				price += Geocoder::Calculations.distance_between([57.1497,-2.0943], [lake.Lat,lake.Long])*0.5 + 20
			else
				price += Geocoder::Calculations.distance_between([lake.Lat,lake.Long], [lake_b.Lat,lake_b.Long])*0.5 + 20
			end
			lake_b = lake
		end
		lakes = lakes[0...-2]
		price = price.round
	end
	
	if lakes != @trip.Lakes
		@trip.Lakes.split(", ").each do |name|
			lake = LakeDest.find_by(Name: name)
			@trip.lake_dest.destroy(lake)
		end
		
		params[:trip][:lake_dests].each do |id|
			lake = LakeDest.find_by(id: id)
			@trip.lake_dest << lake
		end
	end
	
    respond_to do |format|
      if @trip.update(trip_params.merge(Lakes: lakes, Price: price))
        format.html { redirect_to @trip
					flash[:info] = 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url
					flash[:info] = 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:Name, :Lakes, :Date, :Price, :AvailablePlaces)
    end
end
