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

ActiveRecord::Schema.define(version: 2020_04_09_180217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commands", force: :cascade do |t|
    t.string "title"
    t.bigint "games_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_commands_on_title"
  end

  create_table "commands_games", force: :cascade do |t|
    t.integer "command_id"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "indicators", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "game_id"
    t.string "kind"
    t.string "title"
    t.string "value"
    t.boolean "gained"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "target_indicator_id"
    t.index ["game_id"], name: "index_indicators_on_game_id"
    t.index ["kind"], name: "index_indicators_on_kind"
    t.index ["player_id"], name: "index_indicators_on_player_id"
    t.index ["target_indicator_id"], name: "index_indicators_on_target_indicator_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "command_id"
    t.string "name"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["command_id"], name: "index_players_on_command_id"
  end

  add_foreign_key "indicators", "games"
  add_foreign_key "indicators", "players"
  add_foreign_key "players", "commands"
end
