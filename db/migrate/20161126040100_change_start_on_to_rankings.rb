class ChangeStartOnToRankings < ActiveRecord::Migration
  def change
    reversible do |r|
      change_table :rankings do |t|
        r.up do
          t.change :start_on, :date, null: false
          t.rename :start_on, :start_date
        end
        r.down do
          t.rename :start_date, :start_on
          t.change :start_on, :datetime, null: false
        end
      end
    end
  end
end
