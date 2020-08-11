class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                     null:false
      t.string :text,                     null:false
      t.integer :condition,               null:false
      t.integer :price,                   null:false
      t.bigint :category_id,              foreign_key: true, null:false
      t.references :brand
      t.bigint :user_id,                  foreign_key:true, null:false
      t.timestamps
    end
  end
end
