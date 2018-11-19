class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  skip_before_action :logged_in_user, only: [:create, :show, :new, :destroy]
  skip_before_action :admin_user, only: [:create,:show, :new, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
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
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
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
	if !logged_in? || (!admin? && !(current_user.bookings.find(params[:id]).include? @booking))
		flash[:danger] = "You can't do that you naughty user..."
		redirect_to root_url
	else
		respond_to do |format|
		  if @booking.update(booking_params)
			format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
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
	if !logged_in? || (!admin? && !(current_user.bookings.find(params[:id]).include? @booking))
		flash[:danger] = "You can't do that you naughty user..."
		redirect_to root_url
	else
		@booking.destroy
		respond_to do |format|
		  format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
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
