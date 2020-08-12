class AddColumnToItemImages < ActiveRecord::Migration[5.2]
  def change
    add_reference :item_images, :item, null:false
  end
end
