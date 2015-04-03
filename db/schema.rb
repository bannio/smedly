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

ActiveRecord::Schema.define(version: 20150402152540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "handles", force: :cascade do |t|
    t.string   "name"
    t.text     "notes"
    t.integer  "followers"
    t.boolean  "following"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "tweets_count"
    t.date     "last_tweet_date"
    t.text     "profile_description"
    t.string   "location"
    t.string   "profile_image_url"
  end

  create_table "platforms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_handles", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "handle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_handles", ["handle_id"], name: "index_post_handles_on_handle_id", using: :btree
  add_index "post_handles", ["post_id"], name: "index_post_handles_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "topic_id"
    t.text     "content"
    t.datetime "posted_on"
    t.integer  "status",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "platform_id"
    t.string   "url"
  end

  add_index "posts", ["platform_id"], name: "index_posts_on_platform_id", using: :btree
  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.text     "summary"
    t.date     "publish_date"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "status",       default: 0
    t.string   "url"
    t.string   "author"
  end

  add_foreign_key "post_handles", "handles"
  add_foreign_key "post_handles", "posts"
  add_foreign_key "posts", "topics"
end
