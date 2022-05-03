class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]


  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :card, dependent: :destroy
  has_many :sns_credentials
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item

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

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
  def favorited_by?(item_id)
    favirites.where(item_id: item_id).exists?
  end
end

