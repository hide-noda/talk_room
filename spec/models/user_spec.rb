require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it 'ユーザー情報が全てあれば登録できる' do
          expect(@user).to be_valid
        end
      end
      context '新規登録がうまくいかないとき' do
        it 'family_nameが空だと登録できない' do
          @user.family_name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("姓を入力してください")
        end
        it 'last_nameが空だと登録できない' do
          @user.last_name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("名を入力してください")
        end
        it 'family_name_kanaが空だと登録できない' do
          @user.family_name_kana = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("セイ(全角カナ)を入力してください")
        end
        it 'family_name_kanaがカタカナ以外だと登録できない' do
          @user.family_name_kana = "あいうえお"
          @user.valid?
          expect(@user.errors.full_messages).to include("セイ(全角カナ)は不正な値です")
        end
        it 'last_name_kanaが空だと登録できない' do
          @user.last_name_kana = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("メイ(全角カナ)を入力してください")
        end
        it 'last_name_kanaがカタカナ以外だと登録できない' do
          @user.last_name_kana = "あいうえお"
          @user.valid?
          expect(@user.errors.full_messages).to include("メイ(全角カナ)は不正な値です")
        end
        it 'emailが空だと登録できない' do
          @user.email = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Emailを入力してください")
        end
        it 'emailに@がないと登録できない' do
          @user.email = "aaabbb"
          @user.valid?
          expect(@user.errors.full_messages).to include("Emailは不正な値です")
        end
        it '重複したemailが存在する場合登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include("Emailはすでに存在します")
        end
        it 'passwordが空だと登録できない' do
          @user.password = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Passwordを入力してください")
        end
        it 'passwordが5文字以下であれば登録できない' do
          @user.password = "00000"
          @user.valid?
          expect(@user.errors.full_messages).to include("Passwordは6文字以上で入力してください")
        end
        it 'passwordを登録してもpassword_confirmationが空だと登録できない' do
          @user.password_confirmation = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmationとPasswordの入力が一致しません")
        end
      end
    end
  end
end
