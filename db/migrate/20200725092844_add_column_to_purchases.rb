class AddColumnToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_reference :purchases, :item, null:false
  end
end
