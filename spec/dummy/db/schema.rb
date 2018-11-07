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

ActiveRecord::Schema.define(version: 2018_11_06_201638) do

  create_table "stripe_subscribe_remote_resources", force: :cascade do |t|
    t.string "remote_resource_id"
    t.string "remote_resource_type"
    t.integer "stripeable_id"
    t.string "stripeable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["remote_resource_id"], name: "index_stripe_subscribe_remote_resources_on_remote_resource_id"
    t.index ["stripeable_type", "stripeable_id"], name: "index_remote_resource_on_stripeable_type_and_stripeable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
