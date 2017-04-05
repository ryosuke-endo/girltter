require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Topic, type: :model do
  describe 'add_tags' do
    let!(:tag) { create(:tag) }
    let(:topic) { build(:topic) }

    context 'タイトルにtag名が含んでいる場合' do
      it 'タグを増やす' do
        topic.title = 'ママ友トラブル'
        topic.save
        expect(topic.tag_list).to eq [tag.name]
      end
    end

    context '本文にtag名が含んでいる場合' do
      it 'タグを増やす' do
        topic.body = 'ママ友トラブル'
        topic.save
        expect(topic.tag_list).to eq [tag.name]
      end
    end

    context 'タイトル・本文に同一のタグが含んでいる場合' do
      it '一つのタグしか増やさない' do
        topic.title = 'ママ友トラブル'
        topic.body = 'ママ友トラブル'
        topic.save
        expect(topic.tag_list).to eq [tag.name]
      end
    end
  end

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
