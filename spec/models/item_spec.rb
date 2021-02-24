require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '商品出品が成功した時' do

    it "データが全て入力されている場合" do
      expect(@item).to be_valid
    end

    it "販売価格は半角数字のみ保存可能であること" do
      @item.price = 111111
      @item.valid?
      expect(@item).to be_valid
    end
  end  
    
  context '商品出品に失敗した時' do
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
  
    it "販売価格は、¥299以下だと保存できないこと" do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
    
    it "10,000,000以上では登録できないこと" do
      @item.price = 200000000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 99999999")
    end

    it "半角英語だけでは登録できないこと" do
      @item.price = "aaaaaa"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it "全角文字では登録できないこと" do
      @item.price = "１１１１１"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it "categoryカラムのidが1の場合保存できない" do
      @item.category_id  = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category must be other than 1")
    end

    it "statusカラムのidが1の場合保存できない" do
      @item.status_id  = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Status must be other than 1")
    end

    it "burdenカラムのidが1の場合保存できない" do
      @item.burden_id  = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Burden must be other than 1")
    end

    it "areaカラムのidが1の場合保存できない" do
      @item.area_id  = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Area must be other than 0")
    end

    it "daysカラムのidが1の場合保存できない" do
      @item.days_id  = 1
      @item.valid?
      binding.pry
      expect(@item.errors.full_messages).to include("Days must be other than 1")
    end

  end

end