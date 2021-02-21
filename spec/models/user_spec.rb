require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        @user.valid?
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = "123qwe"
        @user.password_confirmation = "123qwe"
        @user.valid?
        expect(@user).to be_valid
      end

    end

    context '新規登録できないとき' do
     it "nicknameが空では登録できないこと" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
     end

     it "emailが空では登録できないこと" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
     end

     it "重複したemailが存在する場合登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
     end

     it "メールアドレスは、@を含む必要があること" do
      @user.email = "testcom"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
     end

     it "passwordが空では登録できないこと" do  
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
     end

     it "passwordが6文字以下であれば登録できない" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
     end
  
     it "passwordとpassword_confirmationが不一致では登録できないこと" do
      @user.password = "123pwe"
      @user.password_confirmation = "123ewq"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
     end

     it "ユーザー本名は、名字と名前がそれぞれ必須であること①" do
      @user.lastname_ja = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname ja can't be blank")
     end
     
     it "ユーザー本名は、名字と名前がそれぞれ必須であること②" do
      @user.firstname_ja = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstname ja can't be blank")
     end

     it "ユーザー本名のフリガナは、名字と名前がそれぞれ必須であること①" do
      @user.lastname_ka = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname ka can't be blank")
     end

     it "ユーザー本名のフリガナは、名字と名前がそれぞれ必須であること②" do
      @user.firstname_ka = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstname ka can't be blank")
     end

     it "生年月日が必須であること" do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
     end
 
     it "passwordが半角数字のみの場合は登録できない" do
      @user.password = "111111"
      @user.password_confirmation = "111111"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
     end
     
     it "passwordが半角英字のみの場合は登録できない" do
      @user.password = "aaaaaa"
      @user.password_confirmation = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
     end
    
     it "passwordが全角の場合は登録できない" do
      @user.password = "１１１ａａａ"
      @user.password_confirmation = "１１１ａａａ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
     end

     it "ユーザー本名は全角（漢字・ひらがな・カタカナ）以外では登録できない①" do
      @user.lastname_ja = "tanaka"
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname ja is invalid")
     end

     it "ユーザー本名は全角（漢字・ひらがな・カタカナ）以外では登録できない②" do
      @user.lastname_ja = "tarou"
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname ja is invalid")
     end     

     it "ユーザー本名のフリガナは全角（カタカナ）以外では登録できない①" do
      @user.lastname_ka = "ﾀﾅｶ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname ka is invalid")
     end

     it "ユーザー本名のフリガナは全角（カタカナ）以外では登録できない①" do
      @user.lastname_ka = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname ka is invalid")
     end

    end
  end
end

