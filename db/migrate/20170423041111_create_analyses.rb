class CreateAnalyses < ActiveRecord::Migration[5.0]
  def change
    create_table :analyses do |t|
      t.bigint :analysisable_id, null: false
      t.string :analysisable_type, null: false
      t.integer :pageview, null: false, default: 0
      t.date :date, null: false
    end

    add_index :analyses, [:analysisable_id, :analysisable_type]
  end
end
