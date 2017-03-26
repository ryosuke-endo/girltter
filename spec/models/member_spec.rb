require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'validation' do
    let(:member) { create(:member) }

    shared_examples_for 'alphanumeric' do |column_name, min_len, max_len|
      let(:factory_name) { described_class.name.underscore }
      let(:record) { build(factory_name) }

      context "#{column_name}" do
        context '登録できる' do
          context '半角英数字' do
            it '_を含むもの' do
              value = 'kijochannel_2'
              if column_name == :password
                expect(record.update(password: value,
                                     password_confirmation: value)).to be_truthy
              else
                record[column_name] = value
                expect(record).to be_valid
              end
            end

            it '-を含むもの' do
              value = 'kijochannel-2'
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

            it '@を含む' do
              value = 'kijochannel@'
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
        other_member = build(:member, login: member.login)
        expect(other_member).not_to be_valid
      end
    end

    context 'name' do
      context 'create' do
        it '初期値はlogin' do
          expect(member.name).to eq member.login
        end
      end
    end

    it_behaves_like 'alphanumeric', :password, 8, 20

    context 'password' do
      context 'skip_validate_password' do
        context 'true' do
          it 'validation skip' do
            member.skip_validate_password = true
            short_pw = "pass"
            expect(
              member.update(password: "#{short_pw}",
                            password_confirmation: "#{short_pw}")
            ).to be_truthy
          end
        end
      end
    end

    context 'email' do
      context '登録できる' do
        context '文字の種類' do
          it '半角英数字' do
            other_member = build(:member, email: 'kijochannel@example.com')
            expect(other_member).to be_valid
          end

          it '_を含むものを登録できる' do
            other_member = build(:member, email: 'kijochannel_2@example.com')
            expect(other_member).to be_valid
          end
        end

        context '変換する' do
          it '大文字を小文字' do
            other_member = create(:member, email: 'kijochannel@example.com')
            expect(other_member.email).to eq other_member.email.downcase
          end
        end
      end

      context '登録できない' do
        it '日本語は登録できない' do
          other_member = build(:member, email: 'みんなの恋愛@example.com')
          expect(other_member).not_to be_valid
        end
      end
    end
  end
end
