class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :burden
  belongs_to :category
  belongs_to :days
  belongs_to :status
  belongs_to :user
  
  has_one_attached :image

  with_options numericality: { other_than: 1 } do
    
    validates :burden_id
    validates :category_id
    validates :days_id
    validates :status_id

  end
    validates :area_id,numericality: { other_than: 0 }   

  with_options presence: true do

    validates :image
    validates :name       
    validates :text       
    validates :category_id
    validates :status_id  
    validates :burden_id  
    validates :area_id    
    validates :days_id    
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 99999999 }
    validates :price, numericality: { with: /\A[a-zA-Z]+\z/ } 
  
  end

end
