
ActiveRecord::Schema.define(version: 20160519064009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "musics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "uid",          null: false
    t.string   "display_name", null: false
    t.string   "email"
    t.string   "provider",     null: false
    t.string   "photo_url"
  end

end
