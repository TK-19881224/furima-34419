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
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
     end

     it "emailが空では登録できないこと" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
     end

     it "重複したemailが存在する場合登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
     end

     it "メールアドレスは、@を含む必要があること" do
      @user.email = "testcom"
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールは不正な値です")
     end

     it "passwordが空では登録できないこと" do  
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは不正な値です", "パスワード（確認用）とパスワードの入力が一致しません")
     end

     it "passwordが6文字以下であれば登録できない" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください", "パスワードは不正な値です", "パスワード（確認用）は不正な値です")
     end
  
     it "passwordとpassword_confirmationが不一致では登録できないこと" do
      @user.password = "123pwe"
      @user.password_confirmation = "123ewq"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
     end

     it "ユーザー本名は、名字と名前がそれぞれ必須であること①" do
      @user.lastname_ja = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名字を入力してください", "名字は不正な値です")
     end
     
     it "ユーザー本名は、名字と名前がそれぞれ必須であること②" do
      @user.firstname_ja = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください", "名前は不正な値です")
     end

     it "ユーザー本名のフリガナは、名字と名前がそれぞれ必須であること①" do
      @user.lastname_ka = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名字（全角カタカナ）を入力してください", "名字（全角カタカナ）は不正な値です")
     end

     it "ユーザー本名のフリガナは、名字と名前がそれぞれ必須であること②" do
      @user.firstname_ka = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名前（全角カタカナ）を入力してください", "名前（全角カタカナ）は不正な値です")
     end

     it "生年月日が必須であること" do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
     end
 
     it "passwordが半角数字のみの場合は登録できない" do
      @user.password = "111111"
      @user.password_confirmation = "111111"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは不正な値です", "パスワード（確認用）は不正な値です")
     end
     
     it "passwordが半角英字のみの場合は登録できない" do
      @user.password = "aaaaaa"
      @user.password_confirmation = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは不正な値です", "パスワード（確認用）は不正な値です")
     end
    
     it "passwordが全角の場合は登録できない" do
      @user.password = "１１１ａａａ"
      @user.password_confirmation = "１１１ａａａ"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは不正な値です", "パスワード（確認用）は不正な値です")
     end

     it "ユーザーの名字は全角（漢字・ひらがな・カタカナ）以外では登録できない①" do
      @user.lastname_ja = "tanaka"
      @user.valid?
      expect(@user.errors.full_messages).to include("名字は不正な値です")
     end

     it "ユーザーの名前は全角（漢字・ひらがな・カタカナ）以外では登録できない②" do
      @user.firstname_ja = "tarou"
      @user.valid?
      expect(@user.errors.full_messages).to include("名前は不正な値です")
     end     

     it "ユーザーの名字のフリガナは全角（カタカナ）以外では登録できない①" do
      @user.lastname_ka = "ﾀﾅｶ"
      @user.valid?
      expect(@user.errors.full_messages).to include("名字（全角カタカナ）は不正な値です")
     end

     it "ユーザーの名前のフリガナは全角（カタカナ）以外では登録できない①" do
      @user.firstname_ka = "ﾀﾛｳ"
      @user.valid?
      expect(@user.errors.full_messages).to include("名前（全角カタカナ）は不正な値です")
     end

    end
  end
end

