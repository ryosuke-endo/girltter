require 'rails_helper'

RSpec.describe CachedMap, type: :model do
  let(:category) { create(:icon_category) }

  describe '#cached' do
    it '結果をhashで返す' do
      result = [[category.id, category]].to_h
      expect(IconCategory.cached).to eq result
    end
  end
end
