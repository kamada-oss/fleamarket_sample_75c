class AddColumnToShippings < ActiveRecord::Migration[5.2]
  def change
    add_column :shippings, :fee_burden,    :boolean, null:false
    add_column :shippings, :area,          :integer, null:false
    add_column :shippings, :handling_time, :integer, null:false
    add_reference :shippings, :item, null:false
  end
end
