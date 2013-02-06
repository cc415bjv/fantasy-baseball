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

ActiveRecord::Schema.define(:version => 20130202065312) do

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "player_code"
    t.string   "birth_year"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "statistics", :force => true do |t|
    t.string   "player_id"
    t.string   "player_code"
    t.string   "year"
    t.string   "team"
    t.integer  "games"
    t.integer  "at_bats"
    t.integer  "runs"
    t.integer  "hits"
    t.integer  "doubles"
    t.integer  "triples"
    t.integer  "homeruns"
    t.integer  "rbis"
    t.integer  "stolen_bases"
    t.integer  "caught_stealing"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
