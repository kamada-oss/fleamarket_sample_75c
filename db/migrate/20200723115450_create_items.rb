class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                     null:false
      t.string :text,                     null:false
      t.integer :prefecture,              null:false
      t.integer :condition,               null:false
      t.integer :price,                   null:false
      t.references :category,             foreign_key: true
      t.references :brand_name,           null:false
      t.integer :fee_burdens,             null:false
      t.integer :handling_times,          null:false
      t.references :user,                 foreign_key:true
      t.timestamps
    end
  end
end
