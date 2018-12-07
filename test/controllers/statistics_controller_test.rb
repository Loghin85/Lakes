require 'test_helper'

class StatisticsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user)
	@admin = users(:admin)
	@booking = bookings(:one)
	@trip = trips(:one)
	@dest = lake_dests(:one)
	@trip.lake_dest << @dest
	@booking.user = @user
	@booking.trip = @trip
	@trip.save
	@booking.save
  end

  test "should not get index(not logged in)" do
	get statistics_url
    assert_redirected_to login_url
  end
  
  test "should not get index(user)" do
	log_in_as @user
	get statistics_url
    assert_redirected_to login_url
  end
  
  test "should get index(admin)" do
	log_in_as @admin
	get statistics_url
    assert_response :success
  end
  
end
