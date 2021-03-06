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

ActiveRecord::Schema.define(version: 2018_12_02_144916) do

  create_table "bookings", force: :cascade do |t|
    t.integer "NoOfPersons"
    t.boolean "Paid", default: false
    t.integer "user_id"
    t.integer "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_bookings_on_trip_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
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

  create_table "lake_dests_trips", id: false, force: :cascade do |t|
    t.integer "lake_dest_id", null: false
    t.integer "trip_id", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "trips", force: :cascade do |t|
    t.string "Name"
    t.string "Lakes"
    t.date "Date"
    t.decimal "Price"
    t.integer "AvailablePlaces"
    t.integer "lake_dests_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lake_dests_id"], name: "index_trips_on_lake_dests_id"
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
    t.string "Privilege", default: "User"
    t.boolean "CardRegistered", default: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["Email"], name: "index_users_on_email", unique: true
  end

end
