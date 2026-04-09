class CreateRepositories < ActiveRecord::Migration[8.1]
  def change
    create_table :repositories do |t|
      t.string :provider, null: false
      t.string :namespace_path, null: false
      t.string :name, null: false
      t.string :default_base_ref, null: false, default: "main"

      t.timestamps
    end

    add_index :repositories, %i[provider namespace_path name], unique: true
  end
end
