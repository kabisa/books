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

ActiveRecord::Schema.define(version: 2020_02_28_093126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "link", limit: 2048
    t.string "summary", limit: 2048
    t.datetime "deleted_at"
    t.integer "likes_count", default: 0
    t.integer "dislikes_count", default: 0
    t.integer "comments_count", default: 0
    t.string "cover"
    t.integer "num_of_pages", limit: 2
    t.date "published_on"
    t.bigint "reedition_id"
    t.index ["deleted_at"], name: "index_books_on_deleted_at"
    t.index ["reedition_id"], name: "index_books_on_reedition_id"
  end

  create_table "books_writers", id: false, force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "writer_id", null: false
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

  create_table "comments", force: :cascade do |t|
    t.string "body", limit: 1024
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["book_id"], name: "index_comments_on_book_id"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "copies", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "location_id", null: false
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.integer "borrowings_count", default: 0
    t.index ["book_id"], name: "index_copies_on_book_id"
    t.index ["deleted_at"], name: "index_copies_on_deleted_at"
    t.index ["location_id"], name: "index_copies_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "city", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "media", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "location_id"
    t.integer "copies_count"
    t.datetime "deleted_at"
    t.integer "borrowings_count", default: 0
    t.string "link", limit: 2048
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_media_on_book_id"
    t.index ["location_id"], name: "index_media_on_location_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255
    t.string "name", limit: 100
    t.string "login_token"
    t.datetime "login_token_valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "comments_anonymously", default: false
    t.string "avatar"
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

  create_table "writers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "books", "books", column: "reedition_id"
  add_foreign_key "borrowings", "copies"
  add_foreign_key "borrowings", "users"
  add_foreign_key "comments", "books"
  add_foreign_key "comments", "users"
  add_foreign_key "copies", "books"
  add_foreign_key "copies", "locations"
  add_foreign_key "taggings", "tags"
  add_foreign_key "votes", "books"
  add_foreign_key "votes", "users"
end
