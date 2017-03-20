class CreateIcons < ActiveRecord::Migration
  def change
    create_table :icons do |t|
      t.attachment :image
      t.timestamps null: false
    end
  end
end
