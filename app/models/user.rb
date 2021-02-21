class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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