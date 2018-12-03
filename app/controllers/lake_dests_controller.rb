class LakeDestsController < ApplicationController
  before_action :set_lake_dest, only: [:show, :edit, :update, :destroy]
  skip_before_action :logged_in_user, only: [:show, :index]
  skip_before_action :admin_user, only: [:show, :index]

  # GET /lake_dests
  # GET /lake_dests.json
  def index
	@districts = LakeDest.distinct.pluck(:District).compact.sort
	@altitudes = LakeDest.distinct.pluck(:Altitude).compact.sort
	@alkalinities = LakeDest.distinct.pluck(:Alkalinity).compact.sort
	@rivers = LakeDest.distinct.pluck(:River).compact.sort
	@depths = LakeDest.distinct.pluck(:Depth).compact.sort
	@selectedDistricts = []
	@selectedAltitudes = []
	@selectedAlkalinities = []
	@selectedDepths = []
	@Rivers = []
	@AreaMin = 0
	@AreaMax = 100
	@LatMin = -90
	@LatMax = 90
	@LongMin = -180
	@LongMax = 180
	@lake_dests = LakeDest.all
	if params[:Name]
		@lake_dests = @lake_dests.where('"lake_dests"."Name" LIKE ?', "%#{params[:Name]}%")
	end
	if params[:AreaMin] && params[:AreaMax]
		@lake_dests = @lake_dests.where(Area: params[:AreaMin]..params[:AreaMax])
		@AreaMin = params[:AreaMin]
		@AreaMax = params[:AreaMax]
	end
	if params[:District]
		@lake_dests = @lake_dests.where(District: params[:District])
		@selectedDistricts = params[:District]
	end
	if params[:LatMin] && params[:LatMax]
		@lake_dests = @lake_dests.where(Lat: params[:LatMin]..params[:LatMax])
		@LatMin = params[:LatMin]
		@LatMax = params[:LatMax]
	end
	if params[:LongMin] && params[:LongMax]
		@lake_dests = @lake_dests.where(Long: params[:LongMin]..params[:LongMax])
		@LongMin = params[:LongMin]
		@LongMax = params[:LongMax]
	end
	if params[:River]
		@lake_dests = @lake_dests.where(River: params[:River])
		@Rivers = params[:River]
	end
	if params[:Altitude]
		@lake_dests = @lake_dests.where(Altitude: params[:Altitude])
		@selectedAltitudes = params[:Altitude]
	end
	if params[:Alkalinity]
		@lake_dests = @lake_dests.where(Alkalinity: params[:Alkalinity])
		@selectedAlkalinities = params[:Alkalinity]
	end
	if params[:Depth]
		@lake_dests = @lake_dests.where(Depth: params[:Depth])
		@selectedDepths = params[:Depth]
	end
  end
  
  def resetFilter
	@selectedDistricts = []
	@selectedAltitudes = []
	@selectedAlkalinities = []
	@selectedDepths = []
	@Rivers = []
	@AreaMin = 0
	@AreaMax = 100
	@LatMin = -90
	@LatMax = 90
	@LongMin = -180
	@LongMax = 180
	@lake_dests = LakeDest.all
	redirect_to :index
  end

  # GET /lake_dests/1
  # GET /lake_dests/1.json
  def show
	@lake_dests = LakeDest.all
  end

  # GET /lake_dests/new
  def new
    @lake_dest = LakeDest.new
  end

  # GET /lake_dests/1/edit
  def edit
  end

  # POST /lake_dests
  # POST /lake_dests.json
  def create
	if admin?
		@lake_dest = LakeDest.new(lake_dest_params)

		respond_to do |format|
		  if @lake_dest.save
			format.html { redirect_to @lake_dest
						flash[:info] = 'Lake dest was successfully created.' }
			format.json { render :show, status: :created, location: @lake_dest }
		  else
			format.html { render :new }
			format.json { render json: @lake_dest.errors, status: :unprocessable_entity }
		  end
		end
	else
		naughty_user
	end
  end

  # PATCH/PUT /lake_dests/1
  # PATCH/PUT /lake_dests/1.json
  def update
	if admin?
		respond_to do |format|
		  if @lake_dest.update(lake_dest_params)
			format.html { redirect_to @lake_dest
						flash[:info] = 'Lake dest was successfully updated.' }
			format.json { render :show, status: :ok, location: @lake_dest }
		  else
			format.html { render :edit }
			format.json { render json: @lake_dest.errors, status: :unprocessable_entity }
		  end
		end
	else
		naughty_user
	end
  end

  # DELETE /lake_dests/1
  # DELETE /lake_dests/1.json
  def destroy
	if admin?
		@lake_dest.destroy
		respond_to do |format|
		  format.html { redirect_to lake_dests_url
						flash[:info] = 'Lake dest was successfully destroyed.' }
		  format.json { head :no_content }
		end
	else
		naughty_user
	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lake_dest
      @lake_dest = LakeDest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lake_dest_params
      params.require(:lake_dest).permit(:Name, :Area, :District, :Lat, :Long, :River, :Details_Url, :Altitude, :Alkalinity, :Depth)
    end
end
