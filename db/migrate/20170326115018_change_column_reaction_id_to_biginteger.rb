class ChangeColumnReactionIdToBiginteger < ActiveRecord::Migration[5.0]
  def up
    change_column(:reactions, :id, :integer, limit: 8, auto_increment: true)
  end

  def down
    change_column(:reactions, :id, :integer, auto_increment: true)
  end
end
