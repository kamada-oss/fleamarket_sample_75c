class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes, dependent: :destroy
  has_many :comments
  has_one  :deliver_address
  accepts_nested_attributes_for :deliver_address
  has_many :items, through: :purchases
  has_many :purchases
  has_one  :card
end
