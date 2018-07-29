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

ActiveRecord::Schema.define(version: 2018_07_21_053434) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "appsubgroups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attends", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "estaevent_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "genre"
    t.string "email"
    t.string "manager"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.integer "company_info"
    t.text "body"
    t.string "password_digest"
  end

  create_table "contacts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "message"
    t.string "title"
    t.string "name"
    t.string "email"
    t.string "reply"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estaevents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "place"
    t.string "image"
    t.string "price"
    t.text "body"
    t.string "time"
    t.string "day"
    t.string "genre"
    t.integer "event_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "review"
    t.integer "people"
    t.string "room_id"
    t.integer "user_id"
    t.integer "company_id"
    t.string "conf"
    t.integer "user_count"
    t.integer "company_count"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.string "place"
    t.integer "top_price"
    t.integer "bottom_price"
    t.text "body"
    t.integer "top_people"
    t.integer "bottom_people"
    t.string "time"
    t.string "day"
    t.string "genre"
    t.integer "organizer_id"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count"
    t.string "provide"
    t.string "room_id"
    t.string "conf"
    t.string "permission"
    t.integer "user_count"
    t.integer "company_count"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.string "genre"
    t.string "group_type"
    t.string "format"
    t.string "sub_password"
    t.string "mana_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "information", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "body"
    t.string "title"
    t.integer "user_id"
    t.integer "group_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "to_name"
    t.string "from_name"
    t.text "text"
    t.string "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.integer "user_count"
    t.integer "company_count"
  end

  create_table "resources", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "user_id"
    t.string "email"
    t.integer "organizer_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sex"
    t.integer "age"
    t.integer "user_info"
    t.string "password_digest"
    t.text "body"
  end

  create_table "usersubgroups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_info"
  end

end
