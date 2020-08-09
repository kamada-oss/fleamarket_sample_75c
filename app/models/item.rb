class Item < ApplicationRecord
  enum condition: { "新品・未使用":1, "未使用に近い":2, "目立った傷や汚れ無し":3, "やや傷や汚れあり":4, "傷や汚れあり":5,"全体的に状態が悪い":6 }
  belongs_to :user
  has_one    :purchase
  belongs_to :category
  belongs_to :brand, optional: true
  has_many   :likes, dependent: :destroy
  has_many   :comments
  has_one    :shipping, dependent: :destroy
  accepts_nested_attributes_for :shipping
  belongs_to :size, optional: true
  has_many   :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true
  validates :name,                         presence: true,    length: { maximum: 40 } 
  validates :text,                         presence: true,    length: { maximum: 1000 } 
  validates :category_id,                  presence: true
  validates :condition,                    presence: true
  validates :prefecture,                   presence: true
  validates :price,                        presence: true
  validates_associated :item_images
  validates :item_images,                       presence: true


end
