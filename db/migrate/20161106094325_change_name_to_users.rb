class ChangeNameToUsers < ActiveRecord::Migration
  def change
    reversible do |r|
      change_table :users do |t|
        r.up do
          execute "UPDATE users SET name = login;"
          t.change :name, :string, null: false
        end
        r.down do
          t.change :name, :string
        end
      end
    end
  end
end
