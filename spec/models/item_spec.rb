require 'rails_helper'

RSpec.describe Item, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @item = FactoryBot.build(:item)
  end

  context '商品出品機能' do
    it "データが全て入力されている場合" do
      expect(@item).to be_valid
    end
  
    it "商品画像を1枚つけることが必須であること" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
  
    it "商品名が必須であること" do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
  
    it "商品の説明が必須であること" do 
      @item.text = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Text can't be blank")
    end
  
    it "カテゴリーの情報が必須であること" do
      @item.category_id  = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category is not a number", "Category can't be blank")
    end
  
    it "商品の状態についての情報が必須であること" do
      @item.status_id  = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Status is not a number", "Status can't be blank")
    end
  
    it "配送料の負担についての情報が必須であること" do
      @item.burden_id  = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Burden is not a number", "Burden can't be blank")
    end
  
    it "発送元の地域についての情報が必須であること" do
      @item.area_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Area is not a number", "Area can't be blank")
    end
  
    it "発送までの日数についての情報が必須であること" do
      @item.days_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Days is not a number", "Days can't be blank")
    end
  
    it "販売価格についての情報が必須であること" do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank", "Price is not a number")
    end
  
    it "販売価格は、¥300~¥9,999,999の間のみ保存可能であること" do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
  
    it "販売価格は半角数字のみ保存可能であること" do
      @item.price = "１１１１１"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end
  
  end

end