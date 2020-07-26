class AddColumnToLike < ActiveRecord::Migration[5.2]
  def change
    add_reference :likes, :user, null:false
    add_reference :likes, :item, null:false
  end
end
