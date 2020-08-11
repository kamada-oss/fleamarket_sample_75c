class CreateItemImages < ActiveRecord::Migration[5.2]
  def change
    create_table :item_images do |t|
      t.string :item_image, null:false
      t.timestamps
    end
  end
end
