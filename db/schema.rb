# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_17_214607) do

  create_table "bookings", force: :cascade do |t|
    t.integer "UserId"
    t.string "NoOfPersons"
    t.integer "TripId"
    t.date "Date"
    t.decimal "Price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "number"
    t.string "exp_date"
    t.string "name_on_card"
    t.string "organisation"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "lake_dests", force: :cascade do |t|
    t.string "Name"
    t.decimal "Area"
    t.string "District"
    t.decimal "Lat"
    t.decimal "Long"
    t.string "River"
    t.string "Details_Url"
    t.string "Altitude"
    t.string "Alkalinity"
    t.string "Depth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.string "Name"
    t.string "Lakes"
    t.date "Date"
    t.decimal "Price"
    t.integer "AvailablePlaces"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "Fname"
    t.string "Lname"
    t.string "Email"
    t.string "Address"
    t.string "Postcode"
    t.string "City"
    t.string "Country"
    t.string "Phone"
    t.string "Privilege"
    t.string "CardRegistered"
    t.string "Password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end