class AddColumnToItemImages < ActiveRecord::Migration[5.2]
  def change
    add_column :item_images, :image_url, :string, null:false
    add_reference :item_images, :item, null:false
    add_reference :item_images, :user, null:false
  end
end
