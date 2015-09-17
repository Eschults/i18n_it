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

ActiveRecord::Schema.define(version: 20150917133639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bucket_schemas", force: :cascade do |t|
    t.integer  "bucket_id"
    t.string   "col_type"
    t.string   "bucket_schema_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "cross_languages"
  end

  add_index "bucket_schemas", ["bucket_id"], name: "index_bucket_schemas_on_bucket_id", using: :btree

  create_table "buckets", force: :cascade do |t|
    t.string   "bucket_name"
    t.integer  "project_id"
    t.string   "kind"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "buckets", ["project_id"], name: "index_buckets_on_project_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "company_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "language_key"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "languages_projects", id: false, force: :cascade do |t|
    t.integer "language_id", null: false
    t.integer "project_id",  null: false
  end

  add_index "languages_projects", ["language_id", "project_id"], name: "index_languages_projects_on_language_id_and_project_id", using: :btree
  add_index "languages_projects", ["project_id", "language_id"], name: "index_languages_projects_on_project_id_and_language_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "project_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "projects", ["company_id"], name: "index_projects_on_company_id", using: :btree

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "user_id",    null: false
  end

  create_table "sub_buckets", force: :cascade do |t|
    t.integer  "bucket_id"
    t.string   "sub_bucket_name"
    t.string   "uuid"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "sub_buckets", ["bucket_id"], name: "index_sub_buckets_on_bucket_id", using: :btree

  create_table "translations", force: :cascade do |t|
    t.string   "translation_key"
    t.text     "text"
    t.integer  "bucket_id"
    t.integer  "sub_bucket_id"
    t.integer  "language_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "bucket_schema_id"
  end

  add_index "translations", ["bucket_id"], name: "index_translations_on_bucket_id", using: :btree
  add_index "translations", ["bucket_schema_id"], name: "index_translations_on_bucket_schema_id", using: :btree
  add_index "translations", ["language_id"], name: "index_translations_on_language_id", using: :btree
  add_index "translations", ["sub_bucket_id"], name: "index_translations_on_sub_bucket_id", using: :btree

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
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bucket_schemas", "buckets"
  add_foreign_key "buckets", "projects"
  add_foreign_key "projects", "companies"
  add_foreign_key "sub_buckets", "buckets"
  add_foreign_key "translations", "bucket_schemas"
  add_foreign_key "translations", "buckets"
  add_foreign_key "translations", "languages"
  add_foreign_key "translations", "sub_buckets"
end
