require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'topics dependent: :destroy' do
    let(:category) { create(:category) }
    let!(:topic) { create(:topic, category_id: category.id) }

    it 'topic destory' do
      expect(Topic.count).to eq 1
      category.destroy
      expect(Topic.count).to eq 0
    end
  end
end
