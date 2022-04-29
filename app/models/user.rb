class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]


  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :card, dependent: :destroy
  has_many :sns_credentials

  validates :nickname, presence: true
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, allow_blank: true, message: 'には全角文字を使用してください' } do
    validates :family_name
    validates :first_name
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, allow_blank: true, message: 'には半角英数字混合で設定してください' 

  with_options presence: true, format: { with: /\A[ァ-ヴー]+\z/, allow_blank: true, message: 'には全角カタカナを使用してください' } do
    validates :family_name_kana
    validates :first_name_kana
  end
  validates :birthday, presence: true
end

