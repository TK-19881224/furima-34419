class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

validates :nickname      ,presence:  true
validates :lastname_ja   ,presence:  true
validates :lastname_ka   ,presence:  true
validates :firstname_ja  ,presence:  true
validates :firstname_ka  ,presence:  true
validates :birth_date    ,presence:  true
         







end
