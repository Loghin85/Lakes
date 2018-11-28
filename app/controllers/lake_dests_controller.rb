class LakeDestsController < ApplicationController
  before_action :set_lake_dest, only: [:show, :edit, :update, :destroy]
  skip_before_action :logged_in_user, only: [:show, :index]
  skip_before_action :admin_user, only: [:show, :index]

  # GET /lake_dests
  # GET /lake_dests.json
  def index
    @lake_dests = LakeDest.all
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
  end

  # PATCH/PUT /lake_dests/1
  # PATCH/PUT /lake_dests/1.json
  def update
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
  end

  # DELETE /lake_dests/1
  # DELETE /lake_dests/1.json
  def destroy
    @lake_dest.destroy
    respond_to do |format|
      format.html { redirect_to lake_dests_url
					flash[:info] = 'Lake dest was successfully destroyed.' }
      format.json { head :no_content }
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
