class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: [:show, :edit, :update, :destroy]
  skip_before_action :logged_in_user, only: [:create, :show, :new, :destroy]
  skip_before_action :admin_user, only: [:create,:show, :new, :destroy]

  # GET /credit_cards
  # GET /credit_cards.json
  def index
    @credit_cards = CreditCard.all
  end

  # GET /credit_cards/1
  # GET /credit_cards/1.json
  def show
  end

  # GET /credit_cards/new
  def new
    @credit_card = CreditCard.new
	@users = User.all
  end

  # GET /credit_cards/1/edit
  def edit
  end

  # POST /credit_cards
  # POST /credit_cards.json
  def create
    @credit_card = CreditCard.new(credit_card_params)
	@credit_card.exp_date = params[:exp_date][:year].to_s + "/" + params[:exp_date][:month].to_s

    respond_to do |format|
      if @credit_card.save
        format.html { redirect_to @credit_card, notice: 'Credit card was successfully created.' }
        format.json { render :show, status: :created, location: @credit_card }
      else
        format.html { render :new }
        format.json { render json: @credit_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credit_cards/1
  # PATCH/PUT /credit_cards/1.json
  def update
	if !logged_in? || (!admin? && !(current_user.CreditCard.find(params[:id]).include? @credit_card))
		flash[:danger] = "You can't do that you naughty user..."
		redirect_to root_url
	else
		@credit_card.exp_date = params[:exp_date][:year].to_s + "/" + params[:exp_date][:month].to_s
		
		respond_to do |format|
		  if @credit_card.update(credit_card_params)
			format.html { redirect_to @credit_card, notice: 'Credit card was successfully updated.' }
			format.json { render :show, status: :ok, location: @credit_card }
		  else
			format.html { render :edit }
			format.json { render json: @credit_card.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

  # DELETE /credit_cards/1
  # DELETE /credit_cards/1.json
  def destroy
	if !logged_in? || (!admin? && !(current_user.CreditCard.find(params[:id]).include? @credit_card))
		flash[:danger] = "You can't do that you naughty user..."
		redirect_to root_url
	else
		@credit_card.destroy
		respond_to do |format|
		  if admin?
			format.html { redirect_to credit_cards_url, notice: 'Credit card was successfully destroyed.' }
		  else
			format.html { redirect_to root_url, notice: 'Credit card was successfully destroyed.' }
		  end
		  format.json { head :no_content }
		end
	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card
      @credit_card = CreditCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_card_params
      params.require(:credit_card).permit(:number, :exp_date, :name_on_card, :organisation, :user_id)
    end
end
