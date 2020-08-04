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

  validates :nickname, presence: true, length: {maximum: 20}
  validates :email, presence:true, uniqueness: true
  # validates :password, presense:true, uniqueness: true,length: {in: 7..128 }
  # validates :password_confirmation, presense:true, uniqueness: true
  validates :family_name, presence:true, length: {maximum: 35}
  validates :first_name, presence:true, length: {maximum: 35}
  validates :family_name_kana, presence:true, length: {maximum: 35}
  validates :first_name_kana, presence:true, length: {maximum: 35}
  validates :birthday, presence: true
end
