require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Address", with: @user.Address
    fill_in "Cardregistered", with: @user.CardRegistered
    fill_in "City", with: @user.City
    fill_in "Country", with: @user.Country
    fill_in "Email", with: @user.Email
    fill_in "Fname", with: @user.Fname
    fill_in "Lname", with: @user.Lname
    fill_in "Password", with: @user.Password
    fill_in "Phone", with: @user.Phone
    fill_in "Postcode", with: @user.Postcode
    fill_in "Privilege", with: @user.Privilege
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Address", with: @user.Address
    fill_in "Cardregistered", with: @user.CardRegistered
    fill_in "City", with: @user.City
    fill_in "Country", with: @user.Country
    fill_in "Email", with: @user.Email
    fill_in "Fname", with: @user.Fname
    fill_in "Lname", with: @user.Lname
    fill_in "Password", with: @user.Password
    fill_in "Phone", with: @user.Phone
    fill_in "Postcode", with: @user.Postcode
    fill_in "Privilege", with: @user.Privilege
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
