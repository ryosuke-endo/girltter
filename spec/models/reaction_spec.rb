require 'rails_helper'

RSpec.describe Reaction, type: :model do
  describe '#validation' do
    context 'reactionable_id, icon_id, user_cookie_value, reactionable_typeの複合unique' do
      let(:reaction) { create(:reaction) }

      context '同一の値のデータが作成される場合' do
        it '保存できない' do
          params = reaction.attributes
          x = Reaction.new(params)
          x.save
          expect(x.errors[:reactionable_id].size).to eq 1
        end
      end

      context '同一ではない値のデータが作成される場合' do
        it '保存できる' do
          params = reaction.attributes.with_indifferent_access.except(:id)
          params[:user_cookie_value] = 'foo'
          x = Reaction.new(params)
          x.save
          expect(x.errors[:reactionable_id].size).to eq 0
        end
      end
    end
  end

  describe '#limit_reaction' do
    context '絵文字を20個つけた場合' do
      before do
        19.times { |i| create(:reaction, user_cookie_value: i) }
      end

      it '保存できる' do
        reaction = build(:reaction)
        reaction.save
        expect(reaction.errors[:reactionable_id].size).to eq 0
      end
    end

    context '絵文字を20個以上つけた場合' do
      before do
        20.times { |i| create(:reaction, user_cookie_value: i) }
      end

      it '保存できない' do
        reaction = build(:reaction)
        reaction.save
        expect(reaction.errors[:reactionable_id].size).to eq 1
      end
    end
  end

  describe '#user_limit_reaction' do
    context '一人のユーザーは5個リアクションをつけた場合' do
      before do
        4.times { create(:reaction) }
      end

      it '保存できる' do
        reaction = build(:reaction)
        reaction.save
        expect(reaction.errors[:reactionable_id].size).to eq 0
      end
    end

    context '一人のユーザーは5個以上リアクションをつけた場合' do
      before do
        5.times { create(:reaction) }
      end

      it '保存できない' do
        reaction = build(:reaction)
        reaction.save
        expect(reaction.errors[:reactionable_id].size).to eq 1
      end
    end
  end
end
