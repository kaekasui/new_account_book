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

ActiveRecord::Schema.define(version: 20160727164312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auths", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "screen_name"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "breakdowns", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["category_id"], name: "index_breakdowns_on_category_id", using: :btree
    t.index ["user_id"], name: "index_breakdowns_on_user_id", using: :btree
  end

  create_table "cancels", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_cancels_on_user_id", using: :btree
  end

  create_table "captures", force: :cascade do |t|
    t.date     "published_at"
    t.integer  "charge"
    t.string   "category_name"
    t.string   "breakdown_name"
    t.string   "place_name"
    t.text     "memo"
    t.integer  "user_id"
    t.text     "tags"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "comment"
    t.index ["user_id"], name: "index_captures_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "barance_of_payments"
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.integer  "position"
    t.integer  "breakdowns_count",    default: 0, null: false
    t.integer  "places_count",        default: 0, null: false
    t.integer  "records_count",       default: 0, null: false
    t.index ["user_id"], name: "index_categories_on_user_id", using: :btree
  end

  create_table "categorize_places", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "place_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.boolean  "checked"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.index ["user_id"], name: "index_feedbacks_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "feedback_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "type"
    t.boolean  "read",        default: false
    t.datetime "sent_at"
  end

  create_table "monthly_counts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "month"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount"
    t.index ["user_id"], name: "index_monthly_counts_on_user_id", using: :btree
  end

  create_table "notices", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "post_type"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "post_at"
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_places_on_user_id", using: :btree
  end

  create_table "records", force: :cascade do |t|
    t.date     "published_at"
    t.integer  "charge"
    t.integer  "breakdown_id"
    t.text     "memo"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "place_id"
    t.integer  "category_id"
    t.index ["breakdown_id"], name: "index_records_on_breakdown_id", using: :btree
    t.index ["category_id"], name: "index_records_on_category_id", using: :btree
    t.index ["place_id"], name: "index_records_on_place_id", using: :btree
    t.index ["user_id"], name: "index_records_on_user_id", using: :btree
  end

  create_table "tagged_records", force: :cascade do |t|
    t.integer  "record_id"
    t.integer  "tag_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["record_id"], name: "index_tagged_records_on_record_id", using: :btree
    t.index ["tag_id"], name: "index_tagged_records_on_tag_id", using: :btree
    t.index ["user_id"], name: "index_tagged_records_on_user_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.string   "color_code"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_tags_on_user_id", using: :btree
  end

  create_table "tallies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "month"
    t.text     "list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "name",             null: false
    t.integer  "tokenizable_id",   null: false
    t.string   "tokenizable_type", null: false
    t.string   "token",            null: false
    t.text     "data"
    t.datetime "expires_at"
    t.datetime "created_at",       null: false
    t.index ["expires_at"], name: "index_tokens_on_expires_at", using: :btree
    t.index ["token"], name: "index_tokens_on_token", using: :btree
    t.index ["tokenizable_id", "tokenizable_type", "name"], name: "index_tokens_on_tokenizable_id_and_tokenizable_type_and_name", unique: true, using: :btree
    t.index ["tokenizable_type", "tokenizable_id"], name: "index_tokens_on_tokenizable_type_and_tokenizable_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "token"
    t.string   "nickname"
    t.string   "type"
    t.boolean  "admin"
    t.string   "code"
    t.integer  "status"
    t.string   "password_digest"
    t.boolean  "breakdown_field",        default: true
    t.boolean  "place_field",            default: true
    t.boolean  "memo_field",             default: true
    t.boolean  "tag_field",              default: true
    t.string   "new_email"
    t.string   "currency"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
