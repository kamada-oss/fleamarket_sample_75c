class AddColumnToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_reference :purchases, :item, null:false
    add_reference :purchases, :saler, foreign_key: { to_table: :users }, null:false
    add_reference :purchases, :buyer, foreign_key: { to_table: :users }, null:false
  end
end
