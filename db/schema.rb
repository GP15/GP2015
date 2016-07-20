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

ActiveRecord::Schema.define(version: 20160720025214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "",             null: false
    t.string   "encrypted_password",     default: "",             null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,              null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "time_zone",              default: "Kuala Lumpur", null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",             null: false
    t.string   "encrypted_password",     default: "",             null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,              null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,              null: false
    t.datetime "locked_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "time_zone",              default: "Kuala Lumpur", null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "contact_requests", force: :cascade do |t|
    t.string   "email"
    t.string   "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "development_elements", force: :cascade do |t|
    t.string   "title"
    t.integer  "point"
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
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "featured",     default: false
    t.string   "logo"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_allowed", default: 0
    t.string   "email"
  end

  add_index "partners", ["city_id"], name: "index_partners_on_city_id", using: :btree

  create_table "promo_codes", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "title"
    t.integer  "brain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "referred_to_id"
    t.boolean  "rewards_used"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

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
    t.string   "recurrence"
  end

  add_index "schedules", ["activity_id"], name: "index_schedules_on_activity_id", using: :btree
  add_index "schedules", ["city_id"], name: "index_schedules_on_city_id", using: :btree
  add_index "schedules", ["klass_id"], name: "index_schedules_on_klass_id", using: :btree
  add_index "schedules", ["partner_id"], name: "index_schedules_on_partner_id", using: :btree
  add_index "schedules", ["starts_at", "ends_at"], name: "index_schedules_on_starts_at_and_ends_at", using: :btree

  create_table "static_page_contents", force: :cascade do |t|
    t.string   "key"
    t.text     "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscription_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "activities_allowed"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "featured",                 default: false
    t.integer  "discount_price"
    t.boolean  "on_discount"
    t.boolean  "two_child_onward_package"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "plan_id"
    t.integer  "user_id"
    t.date     "renewal_date"
    t.boolean  "status",               default: true
    t.integer  "quantity",             default: 1
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "child_id"
    t.datetime "cancelled_on"
    t.string   "subscription_id"
    t.datetime "start_date"
    t.integer  "subscription_type_id"
    t.string   "promo_code"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "",             null: false
    t.string   "encrypted_password",                default: "",             null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,              null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "time_zone",                         default: "Kuala Lumpur", null: false
    t.string   "name"
    t.string   "location"
    t.string   "customer_id"
    t.string   "promo_code",             limit: 10
    t.integer  "referred",                          default: 0
    t.string   "phone_no"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "zipcodes", force: :cascade do |t|
    t.string   "pincode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
