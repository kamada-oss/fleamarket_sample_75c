class AddColumnToShippings < ActiveRecord::Migration[5.2]
  def change
    add_reference :shippings, :item, null:false
  end
end
