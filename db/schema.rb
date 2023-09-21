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

ActiveRecord::Schema.define(version: 2023_09_20_144211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "trophy_id"
    t.boolean "favorite", default: false
    t.boolean "achievement", default: false
    t.datetime "success_at"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trophy_id"], name: "index_achievements_on_trophy_id"
    t.index ["user_id"], name: "index_achievements_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.boolean "status", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.bigint "region_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["region_id"], name: "index_prefectures_on_region_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
  end

  create_table "trophies", force: :cascade do |t|
    t.bigint "category_id"
    t.string "title"
    t.text "description"
    t.bigint "create_user_id"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.bigint "country_id"
    t.bigint "region_id"
    t.bigint "prefecture_id"
    t.index ["category_id"], name: "index_trophies_on_category_id"
    t.index ["country_id"], name: "index_trophies_on_country_id"
    t.index ["create_user_id"], name: "index_trophies_on_create_user_id"
    t.index ["prefecture_id"], name: "index_trophies_on_prefecture_id"
    t.index ["region_id"], name: "index_trophies_on_region_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "activated", default: false, null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "refresh_jti"
  end

  add_foreign_key "achievements", "trophies"
  add_foreign_key "achievements", "users"
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "prefectures", "regions"
  add_foreign_key "regions", "countries"
  add_foreign_key "sub_categories", "categories"
  add_foreign_key "trophies", "countries"
  add_foreign_key "trophies", "prefectures"
  add_foreign_key "trophies", "regions"
  add_foreign_key "trophies", "sub_categories", column: "category_id"
  add_foreign_key "trophies", "users", column: "create_user_id"
end
