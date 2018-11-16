require 'test_helper'

class LakeDestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lake_dest = lake_dests(:one)
  end

  test "should get index" do
    get lake_dests_url
    assert_response :success
  end

  test "should get new" do
    get new_lake_dest_url
    assert_response :success
  end

  test "should create lake_dest" do
    assert_difference('LakeDest.count') do
      post lake_dests_url, params: { lake_dest: { Alkalinity: @lake_dest.Alkalinity, Altitude: @lake_dest.Altitude, Area: @lake_dest.Area, Depth: @lake_dest.Depth, Details_Url: @lake_dest.Details_Url, District: @lake_dest.District, Lat: @lake_dest.Lat, Long: @lake_dest.Long, Name: @lake_dest.Name, River: @lake_dest.River } }
    end

    assert_redirected_to lake_dest_url(LakeDest.last)
  end

  test "should show lake_dest" do
    get lake_dest_url(@lake_dest)
    assert_response :success
  end

  test "should get edit" do
    get edit_lake_dest_url(@lake_dest)
    assert_response :success
  end

  test "should update lake_dest" do
    patch lake_dest_url(@lake_dest), params: { lake_dest: { Alkalinity: @lake_dest.Alkalinity, Altitude: @lake_dest.Altitude, Area: @lake_dest.Area, Depth: @lake_dest.Depth, Details_Url: @lake_dest.Details_Url, District: @lake_dest.District, Lat: @lake_dest.Lat, Long: @lake_dest.Long, Name: @lake_dest.Name, River: @lake_dest.River } }
    assert_redirected_to lake_dest_url(@lake_dest)
  end

  test "should destroy lake_dest" do
    assert_difference('LakeDest.count', -1) do
      delete lake_dest_url(@lake_dest)
    end

    assert_redirected_to lake_dests_url
  end
end
