require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nickname、email、passwordとpassword_confirmation、名前(姓名)、名前(カナ)、birthdayが存在すれば登録できる' do
      expect(@user).to be_valid
    end
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '既に登録されているemailは登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'emailは@を含まないと登録できない' do
      @user.email = 'testgmail.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it 'passwordが5文字以下では登録できない' do
      @user.password = '123ab'
      @user.password_confirmation = '123ab'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passwordが129文字以上では登録できない' do
      @user.password = Faker::Internet.password(min_length: 129)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
    end
    it 'family_nameが空では登録できない' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end
    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'family_name_kanaが空では登録できない' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank")
    end
    it 'first_name_kanaが空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it 'birthdayが空では登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
    it 'family_nameが全角文字以外では登録できない' do
      @user.family_name = 'family'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name には全角文字を使用してください")
    end
    it 'first_nameが全角文字以外では登録できない' do
      @user.first_name = 'first'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name には全角文字を使用してください")
    end
    it 'family_name_kanaが全角カタカナ以外では登録できない' do
      @user.family_name_kana = '名字'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana には全角カタカナを使用してください")
    end
    it 'first_name_kanaが全角カタカナ以外では登録できない' do
      @user.first_name_kana = '名前'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana には全角カタカナを使用してください")
    end
    it 'passwordが数字のみでは登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には半角英数字混合で設定してください")
    end
    it 'passwordが英字のみでは登録できない' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には半角英数字混合で設定してください")
    end
  end
end
