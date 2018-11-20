class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  skip_before_action :logged_in_user, only: [:index, :create, :show, :new, :destroy]
  skip_before_action :admin_user, only: [:index, :create,:show, :new, :destroy]

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
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)

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

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
	if !logged_in? || (!admin? && !(current_user.id == @booking.user_id))
		naughty_user
	else
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
      params.require(:booking).permit(:UserId, :NoOfPersons, :TripId, :Date, :Price)
    end
end
