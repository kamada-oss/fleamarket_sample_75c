class AddColumnToDaliveryDays < ActiveRecord::Migration[5.2]
  def change
    add_column :delivery_days, :day, :date,  null:false
  end
end
