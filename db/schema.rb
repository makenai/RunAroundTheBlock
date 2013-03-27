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

ActiveRecord::Schema.define(:version => 20130327210318) do

  create_table "bonuses", :force => true do |t|
    t.integer  "turn_id"
    t.integer  "spaces"
    t.string   "bonus_type"
    t.integer  "player_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "game_pieces", :force => true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.string   "image_url"
    t.integer  "last_space"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.datetime "start_at"
    t.datetime "ended_at"
    t.integer  "winner_game_piece_id"
    t.integer  "current_turn_number"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "players", :force => true do |t|
    t.integer  "gamepiece_id"
    t.integer  "user_id"
    t.integer  "turn_joined"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "turns", :force => true do |t|
    t.integer  "gamepiece_id"
    t.integer  "turn_number"
    t.integer  "spaces"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "runkeeper_id"
    t.string   "name"
    t.string   "nickname"
    t.string   "location"
    t.string   "gender"
    t.string   "image_url"
    t.string   "thumb_url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "token"
  end

end
