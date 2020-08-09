class Shipping < ApplicationRecord
  belongs_to :item, optional: true
end
