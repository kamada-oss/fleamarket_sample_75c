class AddColumnToDaliveryWays < ActiveRecord::Migration[5.2]
  def change
    add_column :delivery_ways, :name, :string,  null:false
  end
end
