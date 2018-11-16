require "application_system_test_case"

class LakeDestsTest < ApplicationSystemTestCase
  setup do
    @lake_dest = lake_dests(:one)
  end

  test "visiting the index" do
    visit lake_dests_url
    assert_selector "h1", text: "Lake Dests"
  end

  test "creating a Lake dest" do
    visit lake_dests_url
    click_on "New Lake Dest"

    fill_in "Alkalinity", with: @lake_dest.Alkalinity
    fill_in "Altitude", with: @lake_dest.Altitude
    fill_in "Area", with: @lake_dest.Area
    fill_in "Depth", with: @lake_dest.Depth
    fill_in "Details Url", with: @lake_dest.Details_Url
    fill_in "District", with: @lake_dest.District
    fill_in "Lat", with: @lake_dest.Lat
    fill_in "Long", with: @lake_dest.Long
    fill_in "Name", with: @lake_dest.Name
    fill_in "River", with: @lake_dest.River
    click_on "Create Lake dest"

    assert_text "Lake dest was successfully created"
    click_on "Back"
  end

  test "updating a Lake dest" do
    visit lake_dests_url
    click_on "Edit", match: :first

    fill_in "Alkalinity", with: @lake_dest.Alkalinity
    fill_in "Altitude", with: @lake_dest.Altitude
    fill_in "Area", with: @lake_dest.Area
    fill_in "Depth", with: @lake_dest.Depth
    fill_in "Details Url", with: @lake_dest.Details_Url
    fill_in "District", with: @lake_dest.District
    fill_in "Lat", with: @lake_dest.Lat
    fill_in "Long", with: @lake_dest.Long
    fill_in "Name", with: @lake_dest.Name
    fill_in "River", with: @lake_dest.River
    click_on "Update Lake dest"

    assert_text "Lake dest was successfully updated"
    click_on "Back"
  end

  test "destroying a Lake dest" do
    visit lake_dests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lake dest was successfully destroyed"
  end
end
