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

ActiveRecord::Schema[8.0].define(version: 2024_12_17_205158) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "collections", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "invalid_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sneakers", force: :cascade do |t|
    t.string "brand", null: false
    t.string "model", null: false
    t.float "size", null: false
    t.date "purchase_date"
    t.float "purchase_price"
    t.integer "condition", null: false
    t.float "estimated_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "collection_id", null: false
    t.text "description"
    t.index ["collection_id"], name: "index_sneakers_on_collection_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "sneaker_size", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "username", null: false
    t.string "gender", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
  end

  add_foreign_key "collections", "users"
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "sneakers", "collections"
end
