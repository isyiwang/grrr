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

ActiveRecord::Schema.define(version: 2018_01_06_222125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string "access_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expiration"
    t.index ["access_token"], name: "index_access_tokens_on_access_token", unique: true
  end

# Could not dump table "animals" because of following StandardError
#   Unknown type 'animal_gender' for column 'gender'

  create_table "authentications", force: :cascade do |t|
    t.string "type", null: false
    t.string "uid", null: false
    t.string "encrypted_token", null: false
    t.string "encrypted_token_iv", null: false
    t.string "encrypted_refresh_token"
    t.string "encrypted_refresh_token_iv"
    t.jsonb "aux_data"
    t.integer "expires_at"
    t.bigint "user_id"
    t.string "encrypted_kms_dek"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "uid"], name: "index_authentications_on_type_and_uid", unique: true
    t.index ["uid"], name: "index_authentications_on_uid"
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "name", null: false
    t.string "image"
    t.string "phone_number"
    t.datetime "confirmed_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "whitelisted_emails", force: :cascade do |t|
    t.string "email", null: false
    t.index ["email"], name: "index_whitelisted_emails_on_email", unique: true
  end

  create_table "zoos", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_zoos_on_name", unique: true
  end

end
