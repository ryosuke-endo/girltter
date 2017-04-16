require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { build(:comment) }
  describe 'validation' do
    context 'body' do
      it '存在しないといけない' do
        comment.body = ''
        expect(comment).not_to be_valid
      end
    end

    context 'name' do
      it '存在しないといけない' do
        comment.name = ''
        expect(comment).not_to be_valid
      end
    end
  end

  describe 'topic_update_time' do
    it '作成後にtopicの更新時間を更新する' do
      topic = comment.topic
      topic.updated_at = 1.day.ago
      topic.save
      comment.save
      expect(topic.updated_at).to eq comment.updated_at
    end
  end
end
