require 'rails_helper'

RSpec.describe Purchase, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase = FactoryBot.build(:purchase,user_id:user.id,item_id:item.id)
    sleep(1)
  end

  context '配送先の情報入力が成功した時' do
 
    it "データが全て入力されている場合" do
      expect(@purchase).to be_valid
    end

    it "データが全て入力されている場合(ビル名無し)" do
      @purchase.building_name = nil
      @purchase.valid?
      expect(@purchase).to be_valid
    end
  end  

  context '配送先の情報入力に失敗した時' do
 
    it "郵便番号が必須であること" do
      @purchase.postal_code = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid")
    end

    it "都道府県が必須であること" do
      @purchase.area_id  = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Area can't be blank", "Area is not a number")
    end

    it "市区町村が必須であること" do
      @purchase.municipalites = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Municipalites can't be blank")
    end

    it "番地が必須であること" do
      @purchase.address = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Address can't be blank")
    end

    it "電話番号が必須であること" do
      @purchase.phone_number = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Phone number can't be blank", "Phone number is invalid")
    end

    it "郵便番号の保存にはハイフンが必要であること（123-4567となる）" do
      @purchase.postal_code = "1234567"
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Postal code is invalid")
    end

    it "電話番号は11桁以内の数値のみ保存可能なこと（09012345678となる）" do
      @purchase.phone_number = "0901234567890"
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Phone number is invalid")
    end

    it "電話番号は英数混合では登録できないこと" do
      @purchase.phone_number = "090qwer1234"
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Phone number is invalid")
    end

    it "tokenが空では登録できないこと" do
      @purchase.token = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Token can't be blank")
    end

    it "areaカラムのidが1の場合保存できない" do
      @purchase.area_id  = 1
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Area must be other than 1")
    end

    it "user_idが空では登録できないこと" do
      @purchase.user_id = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("User can't be blank")
    end

    it "item_idが空では登録できないこと" do
      @purchase.item_id = nil
      @purchase.valid?
      expect(@purchase.errors.full_messages).to include("Item can't be blank")
    end

  end
end 