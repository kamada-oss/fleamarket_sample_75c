class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :name,        :string,  null:false
    add_column :items, :text,        :text,    null:false
    add_column :items, :prefecture,  :string,  null:false
    add_column :items, :condition,   :integer, null:false
    add_column :items, :price,       :integer, null:false
    add_column :items, :saler_id,    :integer, null:false
    add_column :items, :buyer_id,    :integer, null:false
    add_reference :items, :category,    null:false
    add_reference :items, :brand,       null:false
    add_reference :items, :size,        null:false
    add_reference :items, :deliver_way, null:false
    add_reference :items, :deliver_day, null:false
    add_reference :items, :shipping,    null:false
  end
end
