require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Topic, type: :model do
  describe 'thumbnails_first' do
    let(:topic) { build(:topic) }

    context '画像URLを含む' do
      it '最初の画像URLを返す' do
        urls = <<~EOS
          https://example.com/
          https://example.com/sample.jpg
        EOS
        topic.body = urls
        expect(topic.thumbnails_first).to eq 'https://example.com/sample.jpg'
      end
    end

    context '画像URLを含まない' do
      it 'URLを返さない' do
        urls = <<~EOS
          https://example.com/
          https://example.com/sample.html
          https://example.com/foo/index.html
        EOS
        topic.body = urls
        expect(topic.thumbnails_first.blank?).to be_truthy
      end
    end
  end
end
