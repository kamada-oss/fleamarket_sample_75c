class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :likes, dependent: :destroy
  has_many :likes, through: :likes, source: :item
  has_many :comments
  has_one  :deliver_address
  accepts_nested_attributes_for :deliver_address
  has_many :items, through: :purchases
  has_many :purchases
  has_one  :card
  has_many :sns_credentials

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_KATAKANA_REGEX = /\A[ァ-ン]/
  VALID_ZENKAKU_REGEX = /\A[ぁ-んァ-ン一-龥]/

  validates :nickname, presence: true, length: {maximum: 20}
  validates :email, presence:true, uniqueness: true, 
                format: { with: VALID_EMAIL_REGEX, message: 'のフォーマットが不適切です'}
  validates :password, presence: true, length: { in: 7..128 }
  validates :password_confirmation, presence: true, length: { in: 7..128 }
  validates :family_name, presence:true, length: {maximum: 35},
                format: { with: VALID_ZENKAKU_REGEX, message: 'は全角で入力して下さい'}
  validates :first_name, presence:true, length: {maximum: 35},
                format: { with: VALID_ZENKAKU_REGEX, message: 'は全角で入力して下さい'}
  validates :family_name_kana, presence:true, length: {maximum: 35}, 
                format: { with: VALID_KATAKANA_REGEX, message: 'は全角カタカナで入力して下さい'}
  validates :first_name_kana, presence:true, length: {maximum: 35}, 
                format: { with: VALID_KATAKANA_REGEX, message: 'は全角カタカナで入力して下さい'}
  validates :birthday, presence: true

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
