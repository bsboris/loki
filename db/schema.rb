# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_29_000000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "ltree"
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "translation_value_type", ["text", "boolean", "integer", "float", "array", "plural"]

  create_table "project_locales", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.boolean "default", default: false, null: false
    t.bigint "project_id", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "code"], name: "index_project_locales_on_project_id_and_code", unique: true
    t.index ["project_id"], name: "idx_project_locales_one_default_per_project", unique: true, where: "(\"default\" = true)"
    t.index ["project_id"], name: "index_project_locales_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translation_keys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "leaf", default: false, null: false
    t.ltree "path", null: false
    t.string "path_text", null: false
    t.bigint "project_id", null: false
    t.string "segment", null: false
    t.datetime "updated_at", null: false
    t.enum "value_type", enum_type: "translation_value_type"
    t.index ["path"], name: "index_translation_keys_on_path", using: :gist
    t.index ["project_id", "leaf"], name: "index_translation_keys_on_project_id_and_leaf"
    t.index ["project_id", "path"], name: "index_translation_keys_on_project_id_and_path", unique: true
    t.index ["project_id", "path_text"], name: "index_translation_keys_on_project_id_and_path_text", unique: true
    t.index ["project_id"], name: "index_translation_keys_on_project_id"
    t.check_constraint "leaf AND value_type IS NOT NULL OR NOT leaf AND value_type IS NULL", name: "chk_translation_keys_leaf_value_type"
  end

  create_table "translations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "project_locale_id", null: false
    t.bigint "translation_key_id", null: false
    t.datetime "updated_at", null: false
    t.jsonb "value", null: false
    t.index ["project_locale_id"], name: "index_translations_on_project_locale_id"
    t.index ["translation_key_id", "project_locale_id"], name: "index_translations_on_translation_key_id_and_project_locale_id", unique: true
    t.index ["translation_key_id"], name: "index_translations_on_translation_key_id"
  end

  add_foreign_key "project_locales", "projects"
  add_foreign_key "translation_keys", "projects"
  add_foreign_key "translations", "project_locales"
  add_foreign_key "translations", "translation_keys"
end
