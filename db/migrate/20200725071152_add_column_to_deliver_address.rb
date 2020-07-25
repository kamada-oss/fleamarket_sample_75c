class AddColumnToDeliverAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :deliver_addresses, :family_name,      :string, null:false
    add_column :deliver_addresses, :first_name,       :string, null:false
    add_column :deliver_addresses, :family_name_kana, :string, null:false
    add_column :deliver_addresses, :first_name_kana,  :string, null:false
    add_column :deliver_addresses, :zip_code,         :integer, null:false
    add_column :deliver_addresses, :prefecture,       :string, null:false
    add_column :deliver_addresses, :city,             :string, null:false
    add_column :deliver_addresses, :address1,         :string, null:false
    add_column :deliver_addresses, :address2,         :string
    add_column :deliver_addresses, :phone_number,     :integer, null:false
    add_reference :deliver_addresses, :user, null:false
  end
end
