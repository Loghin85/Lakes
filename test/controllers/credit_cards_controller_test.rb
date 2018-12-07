require 'test_helper'

class CreditCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @credit_card = credit_cards(:one)
    @user = users(:user)
	@admin = users(:admin)
	@credit_card.user_id = @user.id
	@credit_card.save
	@date = {year: "2018", month: "12", day: "1"}
  end
  
  test "should not get index(not logged in)" do
	get credit_cards_url
    assert_redirected_to login_url
  end
  
  test "should not get index(user)" do
	log_in_as @user
	get credit_cards_url
    assert_response :success
  end
  
  test "should get index(admin)" do
	log_in_as @admin
	get credit_cards_url
    assert_response :success
  end
  
  test "should not get new(not logged in)" do
    get new_credit_card_url
    assert_redirected_to login_url
  end
  
  test "should get new(user)" do
	log_in_as @user
    get new_credit_card_url
    assert_response :success
	assert_no_match ">User<", response.body
  end
  
  test "should get new(admin)" do
	log_in_as @admin
	get new_credit_card_url
    assert_response :success
	assert_match ">User<", response.body
  end

  test "should not create credit_card(not logged in)" do
	assert_difference('CreditCard.count', 0) do
      post credit_cards_url, params: { credit_card: { user_id: @credit_card.user_id, name_on_card: @credit_card.name_on_card, number: @credit_card.number, organisation: @credit_card.organisation }, exp_date: @date }
    end
    assert_redirected_to login_url
  end
  
  test "should create credit_card(user)" do
	log_in_as @user
	assert_difference('CreditCard.count') do
      post credit_cards_url, params: { credit_card: { user_id: @credit_card.user_id, name_on_card: @credit_card.name_on_card, number: @credit_card.number, organisation: @credit_card.organisation }, exp_date: @date }
    end
    assert_redirected_to credit_card_url(CreditCard.last)
  end
  
  test "should create credit_card(admin)" do
	log_in_as @admin
    assert_difference('CreditCard.count') do
      post credit_cards_url, params: { credit_card: { user_id: @credit_card.user_id, name_on_card: @credit_card.name_on_card, number: @credit_card.number, organisation: @credit_card.organisation }, exp_date: @date }
    end
    assert_redirected_to credit_card_url(CreditCard.last)
  end

  test "should not show credit_card(not logged in)" do
    get credit_card_url(@credit_card)
    assert_redirected_to login_url
  end
  
  test "should show credit_card(user)" do
    log_in_as @user
	get credit_card_url(@credit_card)
    assert_response :success
  end
  
  test "should show credit_card(admin)" do
    log_in_as @admin
	get credit_card_url(@credit_card)
    assert_response :success
  end

  test "should not get edit(not logged in)" do
    get edit_credit_card_url(@credit_card)
    assert_redirected_to login_url
  end
  
  test "should get edit(user)" do
	log_in_as @user
    get edit_credit_card_url(@credit_card)
    assert_response :success
  end
  
  test "should get edit(admin)" do
	log_in_as @admin
    get edit_credit_card_url(@credit_card)
    assert_response :success
  end

  test "should not update credit_card(not logged in)" do
    patch credit_card_url(@credit_card), params: { credit_card: { user_id: @credit_card.user_id, name_on_card: @credit_card.name_on_card, number: @credit_card.number, organisation: @credit_card.organisation }, exp_date: @date }
    assert_redirected_to login_url
  end
  
  test "should update credit_card(user" do
	log_in_as @user
    patch credit_card_url(@credit_card), params: { credit_card: { user_id: @credit_card.user_id, name_on_card: @credit_card.name_on_card, number: @credit_card.number, organisation: @credit_card.organisation }, exp_date: @date }
    assert_redirected_to credit_card_url(@credit_card)
  end
  
  test "should update credit_card(admin)" do
	log_in_as @admin
    patch credit_card_url(@credit_card), params: { credit_card: { user_id: @credit_card.user_id, name_on_card: @credit_card.name_on_card, number: @credit_card.number, organisation: @credit_card.organisation }, exp_date: @date }
    assert_redirected_to credit_card_url(@credit_card)
  end

  test "should not destroy credit_card(not logged in)" do
    assert_difference('CreditCard.count', 0) do
      delete credit_card_url(@credit_card)
    end

    assert_redirected_to login_url
  end
  
  test "should destroy credit_card(user)" do
	log_in_as @user
    assert_difference('CreditCard.count', -1) do
      delete credit_card_url(@credit_card)
    end

    assert_redirected_to credit_cards_url
  end
  
  test "should destroy credit_card(admin)" do
	log_in_as @admin
    assert_difference('CreditCard.count', -1) do
      delete credit_card_url(@credit_card)
    end

    assert_redirected_to credit_cards_url
  end
end
