class AddColumnToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :name, :string, null:false
    add_column :categories, :path, :string, null:false
    add_column :categories, :ancestry, :string
    add_index  :categories, :ancestry
  end
end
