class AddColumnToCard < ActiveRecord::Migration[5.2]
  def change
    add_reference :cards, :user, null:false
    add_column :cards, :customer_id, :string, null:false
    add_column :cards, :card_id, :string, null:false
  end
end
