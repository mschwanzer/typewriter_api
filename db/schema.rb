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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130425053023) do

  create_table "jobs", :force => true do |t|
    t.string   "owner"
    t.text     "content"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "status_code"
    t.string   "tweet_id"
    t.string   "profile_image_url"
    t.string   "location"
    t.string   "user_name"
    t.string   "user_id"
  end

  create_table "settings", :force => true do |t|
    t.text     "status"
    t.boolean  "maintanance"
    t.boolean  "camera"
    t.string   "camera_link"
    t.string   "admin_password"
    t.string   "hashtag"
    t.string   "twitter_user"
    t.string   "twitter_app_id"
    t.string   "twitter_app_token"
    t.string   "twitter_app_oauth"
    t.string   "twitter_app_oauth_token"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

end
