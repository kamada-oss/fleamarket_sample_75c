class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :introduction,:text, null: true # null: trueを明示する必要がある
  end

  def down
    change_column :users, :introduction,:text, null: false
  end
end
