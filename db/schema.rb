# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160114011932) do

  create_table "breakdowns", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "category_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "breakdowns", ["category_id"], name: "index_breakdowns_on_category_id", using: :btree
  add_index "breakdowns", ["user_id"], name: "index_breakdowns_on_user_id", using: :btree

  create_table "cancels", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cancels", ["user_id"], name: "index_cancels_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "barance_of_payments"
    t.datetime "deleted_at"
    t.integer  "user_id",             limit: 4
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.string   "email",      limit: 255
    t.boolean  "checked"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "feedback_id", limit: 4
    t.text     "content",     limit: 65535
    t.string   "type",        limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monthly_counts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "year",       limit: 4
    t.integer  "month",      limit: 4
    t.integer  "count",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount",     limit: 4
  end

  add_index "monthly_counts", ["user_id"], name: "index_monthly_counts_on_user_id", using: :btree

  create_table "notices", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.string   "post_type",  limit: 255
    t.datetime "post_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
  end

  add_index "places", ["user_id"], name: "index_places_on_user_id", using: :btree

  create_table "records", force: :cascade do |t|
    t.date     "published_at"
    t.integer  "charge",       limit: 4
    t.integer  "category_id",  limit: 4
    t.integer  "breakdown_id", limit: 4
    t.integer  "place_id",     limit: 4
    t.text     "memo",         limit: 65535
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",      limit: 4
  end

  add_index "records", ["breakdown_id"], name: "index_records_on_breakdown_id", using: :btree
  add_index "records", ["category_id"], name: "index_records_on_category_id", using: :btree
  add_index "records", ["place_id"], name: "index_records_on_place_id", using: :btree
  add_index "records", ["user_id"], name: "index_records_on_user_id", using: :btree

  create_table "tagged_records", force: :cascade do |t|
    t.integer  "record_id",  limit: 4
    t.integer  "tag_id",     limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tagged_records", ["record_id"], name: "index_tagged_records_on_record_id", using: :btree
  add_index "tagged_records", ["tag_id"], name: "index_tagged_records_on_tag_id", using: :btree
  add_index "tagged_records", ["user_id"], name: "index_tagged_records_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "color_code", limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "tokens", force: :cascade do |t|
    t.string   "name",             limit: 255,   null: false
    t.integer  "tokenizable_id",   limit: 4,     null: false
    t.string   "tokenizable_type", limit: 255,   null: false
    t.string   "token",            limit: 255,   null: false
    t.text     "data",             limit: 65535
    t.datetime "expires_at"
    t.datetime "created_at",                     null: false
  end

  add_index "tokens", ["expires_at"], name: "index_tokens_on_expires_at", using: :btree
  add_index "tokens", ["token"], name: "index_tokens_on_token", using: :btree
  add_index "tokens", ["tokenizable_id", "tokenizable_type", "name"], name: "index_tokens_on_tokenizable_id_and_tokenizable_type_and_name", unique: true, using: :btree
  add_index "tokens", ["tokenizable_type", "tokenizable_id"], name: "index_tokens_on_tokenizable_type_and_tokenizable_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: ""
    t.string   "password_digest",        limit: 255
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "token",                  limit: 255
    t.string   "code",                   limit: 255
    t.boolean  "admin"
    t.string   "type",                   limit: 255
    t.integer  "status",                 limit: 4
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
