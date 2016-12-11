require 'rails_helper'
require 'webmock/rspec'

RSpec.describe TopicsView do
  describe 'process_image' do
    before do
      stub_request(:get, 'www.example.com/sample.jpg').
        with(headers: { Accept: ['image/jpeg', 'image/png']})
    end

    it 'image_tagに変換される' do
      url = 'http://www.example.com/sample.jpg'
      body = <<~"EOS"
        画像テスト

        #{url}
      EOS
      TopicsView.process_image(body, [url])
      expect(!!(body.match(/<img src.*>/))).to be_truthy
    end
  end
end
