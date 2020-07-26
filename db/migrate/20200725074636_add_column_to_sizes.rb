class AddColumnToSizes < ActiveRecord::Migration[5.2]
  def change
    add_column :sizes, :kind,     :string, null:false
    add_column :sizes, :path,     :string, null:false
    add_column :sizes, :ancestry, :string
    add_index :sizes,  :ancestry
  end
end
