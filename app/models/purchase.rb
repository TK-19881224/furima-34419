class Purchase
  include ActiveModel::Model
  attr_accessor :postal_code,:area_id,:municipalites,:address,:building_name,:phone_number,:user_id,:item_id,:token
 

  # ここにバリデーションの処理を書く
  validates :token, presence: true

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :area_id,numericality: { other_than: 1 }
    validates :municipalites
    validates :address
    validates :phone_number, format: { with: /\A\d{11}\z/ }

    validates :user_id
    validates :item_id
  end
    


  def save
    # 各テーブルにデータを保存する処理を書く

   order = Order.create(item_id: item_id, user_id: user_id)

   ShippingAddress.create(postal_code: postal_code, area_id: area_id, municipalites: municipalites, address: address, building_name: building_name, phone_number: phone_number,order_id: order.id)
  end
end