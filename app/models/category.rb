class Category < ApplicationRecord
  has_many :items
  has_ancestry
  scope :ancestries, ->(ancestry) {where(ancestry: ancestry)}
  scope :name_not, ->(name) {where.not(name: name).pluck(:name)}
end
