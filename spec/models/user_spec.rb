require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { create(:user) }

    shared_examples_for 'alphanumeric' do |column_name, min_len, max_len|
      let(:factory_name) { described_class.name.underscore }
      let(:record) { build(factory_name) }

      context "#{column_name}" do
        context '登録できる' do
          context '半角英数字' do
            it '_を含むもの' do
              value = 'mrennai_2'
              if column_name == :password
                expect(record.update(password: value,
                                     password_confirmation: value)).to be_truthy
              else
                record[column_name] = value
                expect(record).to be_valid
              end
            end

            it '-を含むもの' do
              value = 'mrennai_2'
              if column_name == :password
                expect(record.update(password: value,
                                     password_confirmation: value)).to be_truthy
              else
                record[column_name] = value
                expect(record).to be_valid
              end
            end
          end

          context '文字列の長さ' do
            it "#{min_len}文字" do
              value = 'a' * min_len
              if column_name == :password
                expect(record.update(password: value,
                                     password_confirmation: value)).to be_truthy
              else
                record[column_name] = value
                expect(record).to be_valid
              end
            end

            it "#{max_len}文字" do
              value = 'a' * max_len
              if column_name == :password
                expect(record.update(password: value,
                                     password_confirmation: value)).to be_truthy
              else
                record[column_name] = 'a' * max_len
                expect(record).to be_valid
              end
            end
          end
        end

        context '登録できない' do
          context '文字列の長さ' do
            it "#{min_len}文字未満" do
              value = 'a' * (min_len - 1)
              if column_name == :password
                expect(record.update(password: value,
                                     password_confirmation: value)).not_to be_truthy
              else
                record[column_name] = value
                expect(record).not_to be_valid
              end
            end

            it "#{max_len + 1}文字以上" do
              value = 'a' * (max_len + 1)
              if column_name == :password
                expect(record.update(password: value,
                                     password_confirmation: value)).not_to be_truthy
              else
                record[column_name] = value
                expect(record).not_to be_valid
              end
            end
          end

          context '文字の種類' do
            it '半角英数字以外' do
              value = 'みんなの恋愛'
              if column_name == :password
                expect(record.update(password: value,
                                     password_confirmation: value)).not_to be_truthy
              else
                record[column_name] = value
                expect(record).not_to be_valid
              end
            end

            it '全角を含む' do
              value =  '🅰aaaaaaa'
              if column_name == :password
                expect(record.update(password: value,
                                     password_confirmation: value)).not_to be_truthy
              else
                record[column_name] = value
                expect(record).not_to be_valid
              end
            end
          end
        end
      end
    end

    context 'login' do
      it_behaves_like 'alphanumeric', :login, 3, 20

      it '同一IDは登録できない' do
        other_user = build(:user, login: user.login)
        expect(other_user).not_to be_valid
      end
    end


    it_behaves_like 'alphanumeric', :password, 8, 20

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
