# coding: utf-8
require 'rails_helper'
require 'webmock/rspec'

describe TopicDecorator do
  describe 'image' do
    let(:topic) { build(:topic) }
    before do
      decorate(topic)
      stub_request(:get, 'www.example.com/sample.jpg').
        with(headers: { Accept: ['image/jpeg', 'image/png']})
    end

    it 'image_tagに変換される' do
      url = 'http://www.example.com/sample.jpg'
      body = <<~"EOS"
      画像テスト

      #{url}
      EOS
      topic.body = body
      expect(!!(topic.send(:image, [url]).match(/<img src.*>/))).to be_truthy
    end
  end
end
