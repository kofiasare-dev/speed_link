# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_10_20_074918) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "accounts", force: :cascade do |t|
    t.string "phone", null: false
    t.citext "email", null: false
    t.string "password_digest", null: false
    t.string "aasm_state", default: "active", null: false
    t.datetime "verified_at"
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_accounts_on_email"
    t.index ["phone"], name: "index_accounts_on_phone", unique: true, where: "((aasm_state)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[]))"
  end

  create_table "cabs", force: :cascade do |t|
    t.bigint "driver_id", null: false
    t.string "make", null: false
    t.string "model", null: false
    t.integer "year", null: false
    t.string "license_plate", null: false
    t.integer "seats", default: 4, null: false
    t.string "color", null: false
    t.boolean "approved", default: false
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id", "license_plate"], name: "index_cabs_on_driver_id_and_license_plate", unique: true
    t.index ["driver_id"], name: "index_cabs_on_driver_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "locateable_type"
    t.bigint "locateable_id"
    t.geography "latlon", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.jsonb "metadata", default: {}, null: false
    t.integer "position"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["locateable_type", "locateable_id"], name: "index_locations_on_locateable"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "firstname", null: false
    t.string "othernames", null: false
    t.text "avatar_data"
    t.bigint "account_id"
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_profiles_on_account_id"
  end

  create_table "service_configs", force: :cascade do |t|
    t.bigint "service_id"
    t.boolean "active", default: false, null: false
    t.integer "basic_fare_cents", default: 0, null: false
    t.integer "price_per_km_cents", default: 0, null: false
    t.integer "price_per_min_cents", default: 0, null: false
    t.integer "commission_cents", default: 1000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_service_configs_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: false, null: false
    t.integer "person_capacity", default: 1, null: false
    t.text "logo_data"
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_services_on_name", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "driver_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id", "service_id"], name: "index_subscriptions_on_driver_id_and_service_id", unique: true
    t.index ["driver_id"], name: "index_subscriptions_on_driver_id"
    t.index ["service_id"], name: "index_subscriptions_on_service_id"
  end

  create_table "trip", force: :cascade do |t|
    t.string "name"
    t.bigint "rider_id", null: false
    t.bigint "driver_id", null: false
    t.bigint "cab_id", null: false
    t.bigint "service_id", null: false
    t.string "aasm_state", default: "pending", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "started_at", null: false
    t.datetime "cancelled_at"
    t.datetime "ended_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cab_id"], name: "index_trip_on_cab_id"
    t.index ["driver_id"], name: "index_trip_on_driver_id"
    t.index ["rider_id"], name: "index_trip_on_rider_id"
    t.index ["service_id"], name: "index_trip_on_service_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "type", null: false
    t.bigint "account_id"
    t.string "aasm_state"
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "type"], name: "index_users_on_account_id_and_type", unique: true
    t.index ["account_id"], name: "index_users_on_account_id"
  end

  add_foreign_key "cabs", "users", column: "driver_id"
  add_foreign_key "profiles", "accounts"
  add_foreign_key "service_configs", "services"
  add_foreign_key "subscriptions", "services"
  add_foreign_key "subscriptions", "users", column: "driver_id"
  add_foreign_key "trip", "cabs"
  add_foreign_key "trip", "services"
  add_foreign_key "trip", "users", column: "driver_id"
  add_foreign_key "trip", "users", column: "rider_id"
  add_foreign_key "users", "accounts"
end
