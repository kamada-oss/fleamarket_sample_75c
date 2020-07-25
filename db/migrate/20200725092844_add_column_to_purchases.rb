class AddColumnToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :saler_id, :integer, null:false
    add_column :items, :buyer_id, :integer, null:false
    add_reference :purchases, :item, null:false
  end
end
