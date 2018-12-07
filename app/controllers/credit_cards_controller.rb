class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: [:show, :edit, :update, :destroy]
  skip_before_action :admin_user, only: [:index, :create, :show, :new, :destroy, :edit, :update]

  # GET /credit_cards
  # GET /credit_cards.json
  def index
    if admin?
		@credit_cards = CreditCard.all
	else
		@credit_cards = CreditCard.where(["user_id = ?", current_user.id])
	end
	if @credit_cards.empty?
		flash.now[:info]='You have no credit cards yet'
	end
  end

  # GET /credit_cards/1
  # GET /credit_cards/1.json
  def show
	if !logged_in? || (!admin? && !(current_user.id == @credit_card.user_id))
		naughty_user
	end
  end

  # GET /credit_cards/new
  def new
    @credit_card = CreditCard.new
	if admin?
		@users = User.all
	end
  end

  # GET /credit_cards/1/edit
  def edit
	if admin?
		@users = User.all
	end
  end

  # POST /credit_cards
  # POST /credit_cards.json
  def create
    @credit_card = CreditCard.new(credit_card_params)
	@credit_card.exp_date = params[:exp_date][:year].to_s + "/" + params[:exp_date][:month].to_s
	User.find_by(id: params[:credit_card][:user_id]).update_attribute("CardRegistered", true)

    respond_to do |format|
      if @credit_card.save
        format.html { redirect_to @credit_card 
					flash[:success] = 'Credit card was successfully created.' }
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
	if !logged_in? || (!admin? && !(current_user.id == @credit_card.user_id))
		naughty_user
	else
		@credit_card.exp_date = params[:exp_date][:year].to_s + "/" + params[:exp_date][:month].to_s
		
		respond_to do |format|
		  if @credit_card.update(credit_card_params)
			format.html { redirect_to @credit_card
						flash[:info] = 'Credit card was successfully updated.' }
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
	if !logged_in? || (!admin? && !(current_user.id == @credit_card.user_id))
		naughty_user
	else
		user = User.find_by(id: @credit_card.user_id)
		if CreditCard.where(id: @credit_card.user_id).count == 1
			user.update_attribute("CardRegistered", false)
		end
		@credit_card.destroy
		respond_to do |format|
		  format.html { redirect_to credit_cards_url 
						flash[:info] = 'Credit card was successfully destroyed.' }
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
      params.require(:credit_card).permit(:number, :name_on_card, :organisation, :user_id, exp_date: [:year, :date, :month])
    end
end
