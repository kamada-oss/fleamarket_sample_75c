class Item < ApplicationRecord
  has_many   :users, through: :purchases
  belongs_to :category
  belongs_to :brand
  has_many   :likes, depedent: :destroy
  has_many   :comments
  has_one    :shipping, dependent: :destroy
  accepts_nested_attributes_for :shipping
  belongs_to :size, optional: true
  has_many   :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true
end
