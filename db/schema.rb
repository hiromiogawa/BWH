# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_19_140925) do

  create_table "cars", force: :cascade do |t|
    t.string "name"
    t.string "img"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "circuits", force: :cascade do |t|
    t.string "name"
    t.string "img"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "datalists", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_datalists_on_event_id"
    t.index ["user_id"], name: "index_datalists_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.date "day"
    t.integer "circuit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["circuit_id"], name: "index_events_on_circuit_id"
  end

  create_table "heats", force: :cascade do |t|
    t.integer "number"
    t.string "tirename"
    t.string "weather"
    t.float "temp"
    t.string "roadcondition"
    t.float "roadtemp"
    t.integer "datalist_id", null: false
    t.integer "car_id", null: false
    t.integer "circuit_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_heats_on_car_id"
    t.index ["circuit_id"], name: "index_heats_on_circuit_id"
    t.index ["datalist_id"], name: "index_heats_on_datalist_id"
    t.index ["user_id"], name: "index_heats_on_user_id"
  end

  create_table "joins", force: :cascade do |t|
    t.string "type"
    t.integer "user_id", null: false
    t.integer "circuit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["circuit_id"], name: "index_joins_on_circuit_id"
    t.index ["user_id", "circuit_id", "type"], name: "index_joins_on_user_id_and_circuit_id_and_type", unique: true
    t.index ["user_id"], name: "index_joins_on_user_id"
  end

  create_table "laptimes", force: :cascade do |t|
    t.float "sec1"
    t.float "sec2"
    t.float "sec3"
    t.float "total"
    t.integer "heat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["heat_id"], name: "index_laptimes_on_heat_id"
  end

  create_table "ownerships", force: :cascade do |t|
    t.string "type"
    t.integer "user_id", null: false
    t.integer "car_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_ownerships_on_car_id"
    t.index ["user_id", "car_id", "type"], name: "index_ownerships_on_user_id_and_car_id_and_type", unique: true
    t.index ["user_id"], name: "index_ownerships_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.integer "ftirewidth"
    t.integer "rtirewidth"
    t.float "flpress"
    t.float "frpress"
    t.float "rlpress"
    t.float "rrpress"
    t.integer "fdecay"
    t.integer "rdecay"
    t.string "remarks"
    t.integer "heat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["heat_id"], name: "index_settings_on_heat_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "img"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "datalists", "events"
  add_foreign_key "datalists", "users"
  add_foreign_key "events", "circuits"
  add_foreign_key "heats", "cars"
  add_foreign_key "heats", "circuits"
  add_foreign_key "heats", "datalists"
  add_foreign_key "heats", "users"
  add_foreign_key "joins", "circuits"
  add_foreign_key "joins", "users"
  add_foreign_key "laptimes", "heats"
  add_foreign_key "ownerships", "cars"
  add_foreign_key "ownerships", "users"
  add_foreign_key "settings", "heats"
end
