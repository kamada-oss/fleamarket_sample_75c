class ChangeColumnToBrand < ActiveRecord::Migration[5.2]
  def up
    change_column :brands, :name, :string # null: trueを明示する必要がある
  end

  def down
    change_column :brands, :name, :string, null:false
  end
end
