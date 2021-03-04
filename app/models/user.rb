class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :sns_credentials

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
  
  with_options presence: true do
   validates :nickname
   validates :birth_date 
   with_options format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i } do
    validates :password
    validates :password_confirmation
   end
    with_options format: { with: /\A[ぁ-んァ-ン一-龥々]/ } do     
     validates :lastname_ja  
     validates :firstname_ja 
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
     validates :lastname_ka  
     validates :firstname_ka 
    end
  end
end