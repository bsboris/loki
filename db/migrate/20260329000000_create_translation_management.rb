class CreateTranslationManagement < ActiveRecord::Migration[8.1]
  def change
    enable_extension "ltree"

    create_enum :translation_value_type, %w[
      text
      boolean
      integer
      float
      array
      plural
    ]

    create_table :projects do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :project_locales do |t|
      t.references :project, null: false, foreign_key: true
      t.string :code, null: false
      t.boolean :default, null: false, default: false

      t.timestamps
    end

    add_index :project_locales, [:project_id, :code], unique: true
    add_index :project_locales,
              :project_id,
              unique: true,
              where: "\"default\" = true",
              name: "idx_project_locales_one_default_per_project"

    create_table :translation_keys do |t|
      t.references :project, null: false, foreign_key: true

      t.string :segment, null: false
      t.string :path_text, null: false
      t.column :path, :ltree, null: false

      t.boolean :leaf, null: false, default: false
      t.enum :value_type, enum_type: :translation_value_type

      t.timestamps
    end

    add_index :translation_keys, [:project_id, :path_text], unique: true
    add_index :translation_keys, [:project_id, :path], unique: true
    add_index :translation_keys, :path, using: :gist
    add_index :translation_keys, [:project_id, :leaf]

    add_check_constraint :translation_keys,
                         "(leaf AND value_type IS NOT NULL) OR ((NOT leaf) AND value_type IS NULL)",
                         name: "chk_translation_keys_leaf_value_type"

    create_table :translations do |t|
      t.references :translation_key, null: false, foreign_key: true
      t.references :project_locale, null: false, foreign_key: true

      t.jsonb :value, null: false

      t.timestamps
    end

    add_index :translations, [:translation_key_id, :project_locale_id], unique: true
  end
end
