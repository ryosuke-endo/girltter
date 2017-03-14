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
end
