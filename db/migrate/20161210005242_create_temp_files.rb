class CreateTempFiles < ActiveRecord::Migration
  def change
    create_table :temp_files do |t|
      t.string :temp_file_name, null: false
      t.integer :temp_file_size, null: false
      t.string :temp_content_type, null: false
      t.datetime :temp_updated_at, null: false

      t.timestamps null: false
    end
  end
end
