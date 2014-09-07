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

ActiveRecord::Schema.define(version: 20140326044647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "famroomacroletters", force: true do |t|
    t.string "let3"
    t.string "let4"
    t.string "let5"
    t.string "let6"
    t.string "let7"
  end

  create_table "famroomanswers", force: true do |t|
    t.integer  "user_id"
    t.integer  "round"
    t.string   "answer"
    t.datetime "roundstarted"
    t.integer  "points",       default: 0
    t.boolean  "winner",       default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "category"
    t.string   "acroletters"
    t.boolean  "gotvote"
  end

  create_table "famroomcats", force: true do |t|
    t.string   "r1cat"
    t.string   "r2cat"
    t.string   "r3cat"
    t.string   "r4cat"
    t.string   "r5cat"
    t.string   "r6cat"
    t.string   "r7cat"
    t.string   "r8cat"
    t.string   "r9cat"
    t.string   "r10cat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "famroomgamestates", force: true do |t|
    t.string  "activity"
    t.integer "round"
    t.boolean "inprogress"
  end

  create_table "famroomroundtimes", force: true do |t|
    t.datetime "r1prep"
    t.datetime "r1write"
    t.datetime "r1vote"
    t.datetime "r1res"
    t.datetime "r2prep"
    t.datetime "r2write"
    t.datetime "r2vote"
    t.datetime "r2res"
    t.datetime "r3prep"
    t.datetime "r3write"
    t.datetime "r3vote"
    t.datetime "r3res"
    t.datetime "r4prep"
    t.datetime "r4write"
    t.datetime "r4vote"
    t.datetime "r4res"
    t.datetime "r5prep"
    t.datetime "r5write"
    t.datetime "r5vote"
    t.datetime "r5res"
    t.datetime "r6prep"
    t.datetime "r6write"
    t.datetime "r6vote"
    t.datetime "r6res"
    t.datetime "r7prep"
    t.datetime "r7write"
    t.datetime "r7vote"
    t.datetime "r7res"
    t.datetime "r8prep"
    t.datetime "r8write"
    t.datetime "r8vote"
    t.datetime "r8res"
    t.datetime "r9prep"
    t.datetime "r9write"
    t.datetime "r9vote"
    t.datetime "r9res"
    t.datetime "r10prep"
    t.datetime "r10write"
    t.datetime "r10vote"
    t.datetime "r10res"
    t.datetime "finalresults"
    t.datetime "newgamestarts"
  end

  create_table "messages", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "content"
    t.integer  "user_id"
  end

  create_table "players", force: true do |t|
    t.integer "user_id"
    t.string  "name"
    t.string  "room"
    t.integer "gamepoints"
  end

  create_table "updates", force: true do |t|
    t.text     "news"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",               null: false
    t.string   "encrypted_password",     default: "",               null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "username"
    t.date     "dateofbirth"
    t.string   "location",               default: "Acroparty City"
    t.string   "about",                  default: "-"
    t.integer  "gamesplayed",            default: 0
    t.integer  "gameswon",               default: 0
    t.integer  "ignores",                default: 0
    t.integer  "boots",                  default: 0
    t.integer  "highestscore",           default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "admin",                  default: false
    t.string   "time_zone"
    t.integer  "answervotedfor"
    t.integer  "gamepoints",             default: 0
    t.integer  "points_alltime",         default: 0
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "winninganswers", force: true do |t|
    t.integer  "user_id"
    t.string   "answer"
    t.integer  "points",      default: 0
    t.string   "category"
    t.string   "acroletters"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.float    "answertime",  default: 0.0
    t.string   "roomname"
  end

end
