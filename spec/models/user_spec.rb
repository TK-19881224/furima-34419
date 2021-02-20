require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = "123456"
        @user.password_confirmation = "123456"
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

     it "パスワードは、半角英数字混合での入力が必須であること（半角英数字が混合されていれば、登録が可能なこと）" do
      @user.password = "123"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
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
    end
  end
end

