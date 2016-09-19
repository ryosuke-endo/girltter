require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { create(:user) }

    context 'login' do
      it '存在しないといけない' do
        user.login = ''
        expect(user).not_to be_valid
      end

      it '同じものは登録できない' do
        other_user = build(:user, login: user.login)
        expect(other_user).not_to be_valid
      end

      context '半角英数字' do
        it '登録できる' do
          other_user = build(:user, login: 'mrennai')
          expect(other_user).to be_valid
        end

        it '_を含むものを登録できる' do
          other_user = build(:user, login: 'mrennai_2')
          expect(other_user).to be_valid
        end
      end

      context '半角英数字以外' do
        it '登録できない' do
          other_user = build(:user, login: 'みんなの恋愛')
          expect(other_user).not_to be_valid
        end
      end
    end
  end
end
