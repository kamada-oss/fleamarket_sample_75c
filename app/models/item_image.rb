class ItemImage < ApplicationRecord
  mount_uploader :item_image, ImageUploader
  belongs_to :item, optional: true
end
