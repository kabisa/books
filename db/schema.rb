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

ActiveRecord::Schema.define(version: 2019_09_25_081242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.string "link", limit: 2048
    t.string "summary", limit: 2048
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_books_on_deleted_at"
  end

  create_table "borrowings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "copy_id", null: false
    t.datetime "borrowed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["copy_id"], name: "index_borrowings_on_copy_id"
    t.index ["deleted_at"], name: "index_borrowings_on_deleted_at"
    t.index ["user_id"], name: "index_borrowings_on_user_id"
  end

  create_table "copies", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "location_id", null: false
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["book_id"], name: "index_copies_on_book_id"
    t.index ["deleted_at"], name: "index_copies_on_deleted_at"
    t.index ["location_id"], name: "index_copies_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "city", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255
    t.string "name", limit: 100
    t.string "login_token"
    t.datetime "login_token_valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "votes", force: :cascade do |t|
    t.string "type"
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_votes_on_book_id"
    t.index ["deleted_at"], name: "index_votes_on_deleted_at"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "borrowings", "copies"
  add_foreign_key "borrowings", "users"
  add_foreign_key "copies", "books"
  add_foreign_key "copies", "locations"
  add_foreign_key "votes", "books"
  add_foreign_key "votes", "users"
end
