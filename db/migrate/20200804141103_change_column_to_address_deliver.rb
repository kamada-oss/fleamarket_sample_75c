class ChangeColumnToAddressDeliver < ActiveRecord::Migration[5.2]
  def up
    change_column :deliver_addresses, :phone_number, :string, null: true # null: trueを明示する必要がある
  end

  def down
    change_column :deliver_addresses, :phone_number, :integer,null: false
  end
end
