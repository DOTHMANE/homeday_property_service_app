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

ActiveRecord::Schema[7.2].define(version: 2025_02_12_202941) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "cube"
  enable_extension "earthdistance"
  enable_extension "plpgsql"

  create_table "properties", force: :cascade do |t|
    t.string "house_number"
    t.string "street"
    t.string "city"
    t.integer "zip_code"
    t.string "state"
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "property_type", null: false
    t.string "marketing_type", null: false
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.column "earth_location", "earth", null: true
    t.index "ll_to_earth(latitude, longitude)", name: "index_properties_on_ll_to_earth_latitude_longitude", using: :gist
    t.index ["property_type", "marketing_type"], name: "index_properties_on_property_type_and_marketing_type"
    t.index ["price"], name: "index_properties_on_price"
  end
end
