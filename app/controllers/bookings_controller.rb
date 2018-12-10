class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  skip_before_action :admin_user, only: [:index, :create, :show, :edit, :update, :new, :destroy, :pay]

  # GET /bookings
  # GET /bookings.json
  def index
	if admin?
		@bookings = Booking.all
	else
		@bookings = Booking.where(["user_id = ?", current_user.id])
	end
	if @bookings.empty?
		flash.now[:info]='You have no bookings yet'
	end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
	if !logged_in? || (!admin? && !(current_user.id == @booking.user_id))
		naughty_user
	end
	@trips = Trip.all
	if admin?
		@users = User.all
	end
	@date = Trip.find(@booking.trip_id).Date
	@price = Trip.find(@booking.trip_id).Price * @booking.NoOfPersons
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
	if admin?
		@users = User.all
		@trips = Trip.all
	else
		if Trip.ids.include?(params[:trip_id].to_i)
			@trip = Trip.find_by(id: params[:trip_id])
		end
	end
  end

  # GET /bookings/1/edit
  def edit
	@trips = Trip.all
	@trip = Trip.find_by(id: @booking.trip_id)
	if admin?
		@users = User.all
	end
  end

  def pay
	if Trip.ids.include?(params[:id].to_i)
		@booking = Booking.find_by(id: params[:id])
	end
	@trip = Trip.find_by(id: @booking.trip_id)
	@cards = CreditCard.where(user_id: current_user.id)
  end
  
  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
	@trip = Trip.find_by(id: @booking.trip_id)
	@user = User.find_by(id: @booking.user_id)
	if @booking.NoOfPersons>@trip.AvailablePlaces
		flash[:warning] = 'Not enough places available'
		render 'new'
	else
		@trip.AvailablePlaces -= @booking.NoOfPersons
		@booking.trip_id = @trip.id
		@booking.user_id = @user.id
		@trip.save
	
    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking
					flash[:info] = 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
	end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
	@trip = Trip.find_by(id: @booking.trip_id)
	if !logged_in? || (!admin? && !(current_user.id == @booking.user_id))
		naughty_user
	else
		if params[:booking][:NoOfPersons].to_i-@booking.NoOfPersons>@trip.AvailablePlaces
			flash[:warning] = 'Not enough places available'
			render 'edit'
		else
			@trip.AvailablePlaces += @booking.NoOfPersons
			@trip.AvailablePlaces -= params[:booking][:NoOfPersons].to_i
			@trip.save
		
		respond_to do |format|
		  if @booking.update(booking_params)
			format.html { redirect_to @booking
						flash[:info] = 'Booking was successfully updated.' }
			format.json { render :show, status: :ok, location: @booking }
		  else
			format.html { render :edit }
			format.json { render json: @booking.errors, status: :unprocessable_entity }
		  end
		end
		end
	end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
	if !logged_in? || (!admin? && !(current_user.id == @booking.user_id))
		naughty_user
	else
		@booking.destroy
		respond_to do |format|
		  if admin?
			format.html { redirect_to bookings_url
						flash[:info] = 'Booking was successfully destroyed.' }
		  else
			format.html { redirect_to root_url, notice: 'Booking was successfully destroyed.' }
		  end
		  format.json { head :no_content }
		end
	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:user_id, :NoOfPersons, :trip_id, :Paid)
    end
end
