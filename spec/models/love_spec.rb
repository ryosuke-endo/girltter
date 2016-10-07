require 'rails_helper'

RSpec.describe Love, type: :model do
  let(:love) { build(:love, :with_member) }
  let!(:tag) { create(:tag) }

  %w(title body).each do |column|
    describe "#{column}" do
      it '存在しないといけない' do
        love[column] = ''
        expect(love).not_to be_valid
      end
    end
  end

  describe 'tags' do
    it 'tagsの言葉が本文にある場合は保存される' do
      love.body = "脈ありですか？"
      love.save
      expect(love.tag_list).to include(tag.name)
    end

    context 'update_tags' do
      it '新しく追加される' do
        love.save
        tag.name = 'bar'
        tag.save
        Love.update_tags!
        expect(love.tag_list).to include(tag.name)
      end
    end
  end
end
