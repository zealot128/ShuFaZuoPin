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

ActiveRecord::Schema.define(:version => 20110607153337) do

  create_table "characters", :force => true do |t|
    t.string   "pinyin"
    t.string   "hanzi"
    t.text     "translation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "freq"
    t.string   "norm_pinyin"
    t.integer  "tone"
    t.integer  "hsk_level",   :default => -1
    t.string   "type",        :default => "Character"
    t.string   "zew"
  end

  add_index "characters", ["hsk_level"], :name => "index_characters_on_hsk_level"
  add_index "characters", ["norm_pinyin"], :name => "index_characters_on_norm_pinyin"
  add_index "characters", ["pinyin"], :name => "index_characters_on_pinyin"

  create_table "selections", :force => true do |t|
    t.integer  "character_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level_1",      :default => 0
    t.integer  "level_2",      :default => 0
    t.integer  "level_3",      :default => 0
    t.datetime "next_visit_1"
    t.datetime "next_visit_2"
    t.datetime "next_visit_3"
    t.text     "stats"
  end

  add_index "selections", ["character_id"], :name => "index_selections_on_character_id"
  add_index "selections", ["level_1"], :name => "index_selections_on_level_1"
  add_index "selections", ["level_2"], :name => "index_selections_on_level_2"
  add_index "selections", ["level_3"], :name => "index_selections_on_level_3"
  add_index "selections", ["next_visit_1"], :name => "index_selections_on_next_visit_1"
  add_index "selections", ["next_visit_2"], :name => "index_selections_on_next_visit_2"
  add_index "selections", ["next_visit_3"], :name => "index_selections_on_next_visit_3"
  add_index "selections", ["user_id"], :name => "index_selections_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
