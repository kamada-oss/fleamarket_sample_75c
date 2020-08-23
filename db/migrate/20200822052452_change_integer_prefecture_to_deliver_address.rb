class ChangeIntegerPrefectureToDeliverAddress < ActiveRecord::Migration[5.2]
  def change
    change_column :deliver_addresses, :prefecture, :integer
  end
end
