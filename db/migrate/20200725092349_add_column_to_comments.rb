class AddColumnToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :text, :text, null:false
    add_reference :comments, :user, null:false
    add_reference :comments, :item, null:false
  end
end
