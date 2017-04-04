require 'rails_helper'

RSpec.describe CachedMap, type: :model do
  let(:category) { create(:icon_category) }

  describe '#cached' do
    it '結果をhashで返す' do
      result = [[category.id, category]].to_h
      expect(IconCategory.cached).to eq result
    end
  end

  describe '#find_cached' do
    it 'modelの中身を返す' do
      expect(IconCategory.find_cached(category.id)).to eq category
    end
  end
end
