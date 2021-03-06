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

ActiveRecord::Schema.define(version: 20171010213404) do

  create_table "cards", force: :cascade do |t|
    t.string "scryfall_id"
    t.string "name"
    t.string "image_url"
    t.string "rarity"
    t.float "cmc"
    t.string "mana_cost"
    t.string "color_identity"
    t.string "card_type"
    t.string "rules"
    t.string "flavor_text"
    t.string "price"
    t.string "power"
    t.string "toughness"
    t.string "formats"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "deck_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_comments_on_deck_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "deck_cards", force: :cascade do |t|
    t.integer "deck_id"
    t.integer "card_id"
    t.index ["card_id"], name: "index_deck_cards_on_card_id"
    t.index ["deck_id"], name: "index_deck_cards_on_deck_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "format"
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "sideboard_cards", force: :cascade do |t|
    t.integer "sideboard_id"
    t.integer "card_id"
    t.index ["card_id"], name: "index_sideboard_cards_on_card_id"
    t.index ["sideboard_id"], name: "index_sideboard_cards_on_sideboard_id"
  end

  create_table "sideboards", force: :cascade do |t|
    t.integer "deck_id"
    t.index ["deck_id"], name: "index_sideboards_on_deck_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
  end

end
