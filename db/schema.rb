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

ActiveRecord::Schema.define(version: 20151028052041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "children", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "birth_year"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "children", ["birth_year"], name: "index_children_on_birth_year", using: :btree
  add_index "children", ["user_id"], name: "index_children_on_user_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "klasses", force: :cascade do |t|
    t.string   "name"
    t.string   "level"
    t.integer  "age_start"
    t.integer  "age_end"
    t.text     "description"
    t.integer  "activity_id"
    t.integer  "partner_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "reservation_limit", default: 0, null: false
  end

  add_index "klasses", ["activity_id"], name: "index_klasses_on_activity_id", using: :btree
  add_index "klasses", ["age_start", "age_end"], name: "index_klasses_on_age_start_and_age_end", using: :btree
  add_index "klasses", ["level"], name: "index_klasses_on_level", using: :btree
  add_index "klasses", ["partner_id"], name: "index_klasses_on_partner_id", using: :btree

  create_table "partners", force: :cascade do |t|
    t.string   "company"
    t.string   "phone"
    t.string   "address"
    t.string   "state"
    t.string   "img_url"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "partners", ["city_id"], name: "index_partners_on_city_id", using: :btree

  create_table "reservation_cancellations", force: :cascade do |t|
    t.string   "transaction_id"
    t.float    "amount",         default: 0.0
    t.integer  "reservation_id"
    t.integer  "user_id"
    t.string   "card_type"
    t.string   "last4"
    t.integer  "child_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "child_id"
    t.integer  "schedule_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "deleted",     default: false
    t.datetime "deleted_at"
  end

  add_index "reservations", ["child_id", "schedule_id"], name: "index_reservations_on_child_id_and_schedule_id", using: :btree
  add_index "reservations", ["schedule_id"], name: "index_reservations_on_schedule_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "klass_id"
    t.integer  "partner_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "city_id"
    t.integer  "activity_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "reservations_count", default: 0,     null: false
    t.boolean  "archived",           default: false, null: false
  end

  add_index "schedules", ["activity_id"], name: "index_schedules_on_activity_id", using: :btree
  add_index "schedules", ["city_id"], name: "index_schedules_on_city_id", using: :btree
  add_index "schedules", ["klass_id"], name: "index_schedules_on_klass_id", using: :btree
  add_index "schedules", ["partner_id"], name: "index_schedules_on_partner_id", using: :btree
  add_index "schedules", ["starts_at", "ends_at"], name: "index_schedules_on_starts_at_and_ends_at", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.string   "plan_id"
    t.integer  "user_id"
    t.date     "renewal_date"
    t.boolean  "status",          default: true
    t.integer  "quantity",        default: 1
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "child_id"
    t.datetime "cancelled_on"
    t.string   "subscription_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "location"
    t.string   "customer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
