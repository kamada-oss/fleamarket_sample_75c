## 機能
- 商品出品機能
- 商品検索機能
- 商品購入機能
- 商品取引機能
- 商品お気に入り機能
- マイページ機能


# DBテーブル構成

 ## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false, unique: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|
|introduction|text|
|phone_number|integer|null: false|

### Association
- has_many :likes, dependent: :destroy
- has_many :comments
- has_one :deliver_address
- accepts_nested_attributes_for :deliver_address
- has_many :items, through: :purchases
- has_many :purchases
- has_one :card

## deliver_addressテーブル

|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|zip_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address1|string|null: false|
|address2|string||
|phone_number|integer|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user, optional: true

## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## comments テーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
|text|text|null: false|

### Association
- belongs_to :item
- belongs_to :user


## purchasesテーブル

|Column|Type|Options|
|------|----|-------|
|buyer_id|references|null: false, foreign_key: true|
|saler_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
- belongs_to :saler, class_name: 'User', foreign_key: 'saler_id'


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|text|text|null: false|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|condition|integer|null: false|
|price|integer|null: false|
|saler_id|references|null: false, foreign_key: true|
|buyer_id|references|null: false, foreign_key: true|
|size_id|references|null: false, foreign_key: true|
|delivery_way_id|string|null: false, foreign_key: true|
|delivery_day_id|string|null: false, foreign_key: true|
|shipping_id|references|null: false, foreign_key: true|
|prefecture|string|null: false|

### Association
- has_many :users, through: :purchases
- belongs_to :category
- belongs_to :brand
- has_many :likes, depedent: :destroy
- has_many :comments
- has_one :shipping, dependent: :destroy
- accepts_nested_attributes_for :shipping
- belongs_to :size, optional: true
- has_many :item_images, dependent: :destroy
- accepts_nested_attributes_for :item_images, allow_destroy: true

## item_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image_url|string|null: false|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: falsem foreign_key: true|

### Association
- belongs_to :item, optional: true

## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||
|path|text|null: false|

### Association
- has_many :items
- has_ancestry

## sizesテーブル

|Column|Type|Options|
|------|----|-------|
|kind|string|null: false|
|ancestry|string||
|path|text|null: false|

### Association
- has_many :items
- has_ancestry

## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items


## shippingsテーブル

|Column|Type|Options|
|------|----|-------|
|fee_burden|boolean|null: false|
|area|integer|null: false|
|handling_time|integer|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item, optional: true


## delivery_days テーブル

|Column|Type|Options|
|------|----|-------|
|day|date|null: false|

### Association
- has_many :items

## delivery_ways テーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :items

## cards テーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user


## ER図
<img width="1148" alt="ER図２" src="https://user-images.githubusercontent.com/64828177/88174033-8777f800-cc5e-11ea-9574-2ba429ef25a5.png">
