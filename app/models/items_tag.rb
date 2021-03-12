class ItemsTag

  include ActiveModel::Model
  attr_accessor :message, :name, :text, :category_id, :status_id, :burden_id, :area_id, :days_id, :price, :user_id, :images, :created_at, :update_at, :item_id

  with_options presence: true do
    validates :message
    validates :name
    validates :images
    validates :text       
    validates :category_id
    validates :status_id  
    validates :burden_id  
    validates :area_id    
    validates :days_id    
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  with_options numericality: { other_than: 1 } do
    validates :burden_id
    validates :category_id
    validates :days_id
    validates :status_id
    validates :area_id
  end  

  def save
    item = Item.create(name: name, text: text, category_id: category_id, status_id: status_id, burden_id: burden_id, area_id: area_id, days_id: days_id, price: price, user_id: user_id, images: images )
    tag = Tag.where(message: message).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end
  def update(item)
    update_item = item.update(name: name, text: text, category_id: category_id, status_id: status_id, burden_id: burden_id, area_id: area_id, days_id: days_id, price: price, user_id: user_id, images: images )
    tag = Tag.where(message: message).first_or_initialize
    tag.save


  end

end
