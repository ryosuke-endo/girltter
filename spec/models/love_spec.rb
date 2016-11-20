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

  describe '#update_read_count' do
    context 'love exists read_count' do
      before do
        Timecop.freeze(Date.yesterday) do
          name = love.class.name.tableize
          RedisService.count_up(love.id, name)
        end
        Timecop.return
      end

      it '前日の日付分が追加される' do
        love.update_read_count
        expect(love.read_count).to eq 1
      end
    end

    context 'love not exists read_count' do
      it '値が追加されない' do
        love.update_read_count
        expect(love.read_count).to eq 0
      end
    end
  end
end
