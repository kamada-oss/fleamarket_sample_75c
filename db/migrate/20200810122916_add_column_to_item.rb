class AddColumnToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :fee_burden, :integer, null: false
    add_column :items, :prefecture, :integer, null: false
    add_column :items, :handling_time, :integer, null: false
    add_column :items, :auction_status, :integer,null:false,_suffix: true, default:"1"
  end
end
