require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user)
	@admin = users(:admin)
	@booking = bookings(:one)
	@trip = trips(:one)
	@dest = lake_dests(:one)
	@trip.lake_dest << @dest
	@booking.user_id = @user.id
	@booking.trip_id = @trip.id
	@trip.save
	@booking.save
  end
  
  test "should not get index(not logged in)" do
	get bookings_url
    assert_redirected_to login_url
  end
  
  test "should get index(user)" do
	log_in_as @user
	get bookings_url
    assert_response :success
  end
  
  test "should get index(admin)" do
	log_in_as @admin
	get bookings_url
    assert_response :success
  end
  
  test "should not get new(not logged in)" do
    get new_booking_url
    assert_redirected_to login_url
  end
  
  test "should get new(user)" do
	log_in_as @user
    get new_booking_url, params: { trip_id: @trip.id }
    assert_response :success
	assert_no_match ">User<", response.body
  end
  
  test "should get new(admin)" do
	log_in_as @admin
	get new_booking_url
    assert_response :success
	assert_match ">User<", response.body
  end

  test "should not create booking(not logged in)" do
    assert_difference('Booking.count', 0) do
      post bookings_url, params: { booking: {NoOfPersons: @booking.NoOfPersons, trip_id: @booking.trip_id, user_id: @booking.user_id } }
    end

    assert_redirected_to login_url
  end
  
  test "should create booking(user)" do
	log_in_as @user
    assert_difference('Booking.count') do
      post bookings_url, params: { booking: {NoOfPersons: @booking.NoOfPersons, trip_id: @booking.trip_id, user_id: @booking.user_id } }
    end

    assert_redirected_to booking_url(Booking.last)
  end
  
  test "should create booking(admin)" do
	log_in_as @admin
    assert_difference('Booking.count') do
      post bookings_url, params: { booking: {NoOfPersons: @booking.NoOfPersons, trip_id: @booking.trip_id, user_id: @booking.user_id } }
    end

    assert_redirected_to booking_url(Booking.last)
  end
  
  test "should not show booking(not logged in)" do
    get booking_url(@booking)
    assert_redirected_to login_url
  end
  
  test "should show booking(user)" do
    log_in_as @user
	get booking_url(@booking)
    assert_response :success
  end
  
  test "should show booking(admin)" do
    log_in_as @admin
	get booking_url(@booking)
    assert_response :success
  end
  
  test "should not get edit(not logged in)" do
    get edit_booking_url(@booking)
    assert_redirected_to login_url
  end
  
  test "should get edit(user)" do
	log_in_as @user
    get edit_booking_url(@booking)
    assert_response :success
  end
  
  test "should get edit(admin)" do
	log_in_as @admin
    get edit_booking_url(@booking)
    assert_response :success
  end

  test "should not update booking(not logged in)" do
    patch booking_url(@booking), params: { booking: {NoOfPersons: @booking.NoOfPersons, trip_id: @booking.trip_id, user_id: @booking.user_id } }
    assert_redirected_to login_url
  end
  
  test "should update booking(user)" do
	log_in_as @user
    patch booking_url(@booking), params: { booking: {NoOfPersons: @booking.NoOfPersons, trip_id: @booking.trip_id, user_id: @booking.user_id } }
    assert_redirected_to booking_url(@booking)
  end
  
  test "should update booking(admin)" do
	log_in_as @admin
    patch booking_url(@booking), params: { booking: {NoOfPersons: @booking.NoOfPersons, trip_id: @booking.trip_id, user_id: @booking.user_id } }
    assert_redirected_to booking_url(@booking)
  end

  test "should not destroy booking(not logger in)" do
    assert_difference('Booking.count', 0) do
      delete booking_url(@booking)
    end

    assert_redirected_to login_url
  end
  
  test "should destroy booking(user)" do
	log_in_as @user
    assert_difference('Booking.count', -1) do
      delete booking_url(@booking)
    end

    assert_redirected_to root_url
  end
  
  test "should destroy booking(admin)" do
	log_in_as @admin
    assert_difference('Booking.count', -1) do
      delete booking_url(@booking)
    end

    assert_redirected_to bookings_url
  end
  
end
