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

ActiveRecord::Schema.define(version: 20150110084808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: true do |t|
    t.string   "message"
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gamechats", force: true do |t|
    t.string   "message"
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gamedata", force: true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.string   "r1answer"
    t.string   "r2answer"
    t.string   "r3answer"
    t.string   "r4answer"
    t.integer  "gamepoints"
    t.boolean  "r1voted"
    t.boolean  "r2voted"
    t.boolean  "r3voted"
    t.boolean  "r4voted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "r1votedfor",    default: 0
    t.integer  "r2votedfor",    default: 0
    t.integer  "r3votedfor",    default: 0
    t.integer  "r4votedfor",    default: 0
    t.string   "r5answer"
    t.string   "r6answer"
    t.string   "r7answer"
    t.string   "r8answer"
    t.boolean  "r5voted"
    t.boolean  "r6voted"
    t.boolean  "r7voted"
    t.boolean  "r8voted"
    t.integer  "r5votedfor",    default: 0
    t.integer  "r6votedfor",    default: 0
    t.integer  "r7votedfor",    default: 0
    t.integer  "r8votedfor",    default: 0
    t.integer  "r1points",      default: 0
    t.integer  "r2points",      default: 0
    t.integer  "r3points",      default: 0
    t.integer  "r4points",      default: 0
    t.integer  "r5points",      default: 0
    t.integer  "r6points",      default: 0
    t.integer  "r7points",      default: 0
    t.integer  "r8points",      default: 0
    t.boolean  "voteemailsent", default: false
    t.boolean  "seenresults",   default: false
    t.string   "whochatted",    default: ""
  end

  create_table "games", force: true do |t|
    t.string   "r1letters"
    t.string   "r2letters"
    t.string   "r3letters"
    t.string   "r4letters"
    t.string   "r1cat"
    t.string   "r2cat"
    t.string   "r3cat"
    t.string   "r4cat"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.string   "length"
    t.datetime "playendtime"
    t.datetime "voteendtime"
    t.integer  "playercount", default: 0
    t.boolean  "gameover",    default: false
    t.string   "r5letters"
    t.string   "r6letters"
    t.string   "r7letters"
    t.string   "r8letters"
    t.string   "r5cat"
    t.string   "r6cat"
    t.string   "r7cat"
    t.string   "r8cat"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lightningdata", force: true do |t|
    t.integer  "user_id"
    t.integer  "lightning_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment",      default: ""
    t.datetime "commenttime"
    t.boolean  "thumbsup"
    t.boolean  "heart",        default: false
    t.boolean  "userhasvoted", default: false
  end

  create_table "lightnings", force: true do |t|
    t.integer  "user_id"
    t.string   "letters"
    t.string   "category"
    t.integer  "votes",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "answer",       default: ""
    t.boolean  "completed",    default: false
    t.integer  "thumbsup",     default: 0
    t.integer  "thumbsdown",   default: 0
    t.integer  "hearts",       default: 0
    t.string   "whovoted",     default: ""
    t.string   "whocommented", default: ""
  end

  create_table "memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                            default: "",     null: false
    t.string   "encrypted_password",               default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "username"
    t.string   "about"
    t.boolean  "showads",                          default: true
    t.integer  "lifetimepoints",                   default: 0
    t.boolean  "tooltips",                         default: true
    t.integer  "lifetimeroundsplayed",             default: 0
    t.string   "nextlightning",                    default: "play"
    t.integer  "lifetimelightningthumbsup",        default: 0
    t.integer  "lifetimelightningthumbsdown",      default: 0
    t.integer  "lifetimelightninghearts",          default: 0
    t.integer  "lifetimelightningsplayed",         default: 0
    t.integer  "lifetimelightningthumbsupgiven",   default: 0
    t.integer  "lifetimelightningthumbsdowngiven", default: 0
    t.integer  "lifetimelightningheartsgiven",     default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votemailqueues", force: true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "playendtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
