require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { create(:user) }

    context 'login' do
      context '登録できる' do
        context '半角英数字' do
          it '_を含むもの' do
            other_user = build(:user, login: 'mrennai_2')
            expect(other_user).to be_valid
          end

          it '-を含むもの' do
            other_user = build(:user, login: 'mrennai-2')
            expect(other_user).to be_valid
          end
        end

        context '文字列の長さ' do
          it '4文字' do
            name = 'a' * 4
            other_user = build(:user, login: name)
            expect(other_user).to be_valid
          end

          it '20文字' do
            name = 'a' * 20
            other_user = build(:user, login: name)
            expect(other_user).to be_valid
          end
        end
      end

      context '登録できない' do
        it '同一loginID' do
          other_user = build(:user, login: user.login)
          expect(other_user).not_to be_valid
        end

        context '文字の種類' do
          it '半角英数字以外' do
            other_user = build(:user, login: 'みんなの恋愛')
            expect(other_user).not_to be_valid
          end

          it '全角を含む' do
            other_user = build(:user, login: '🅰aaaaaaa')
            expect(other_user).not_to be_valid
          end
        end

        context '文字列の長さ' do
          it '4文字未満' do
            user.login = 'a' * 3
            expect(user).not_to be_valid
          end

          it '21文字以上' do
            user.login = 'a' * 21
            expect(user).not_to be_valid
          end
        end
      end
    end

    context 'email' do
      context '登録できる' do
        context '文字の種類' do
          it '半角英数字' do
            other_user = build(:user, email: 'mrennai@example.com')
            expect(other_user).to be_valid
          end

          it '_を含むものを登録できる' do
            other_user = build(:user, email: 'mrennai_2@example.com')
            expect(other_user).to be_valid
          end
        end

        context '変換する' do
          it '大文字を小文字' do
            other_user = create(:user, email: 'Mrennai@example.com')
            expect(other_user.email).to eq other_user.email.downcase
          end
        end
      end

      context '登録できない' do
        it '日本語は登録できない' do
          other_user = build(:user, email: 'みんなの恋愛@example.com')
          expect(other_user).not_to be_valid
        end

        it '全角を含む' do
          other_user = build(:user, login: '🅰aaaaaaa@example.com')
          expect(other_user).not_to be_valid
        end
      end
    end
  end
end
