require 'rails_helper'
require 'webmock/rspec'

describe ContentsView do
  include ActionView::TestCase::Behavior

  let(:view_context) { controller.view_context }
  let(:contents_view) {
    ContentsView.new('sample', view_context)
  }

  describe '#sanitize_content' do
    context '許可しない' do
      it 'script tag' do
        contents = <<~"EOS"
          <script>
            alert('foo');
          </script>
        EOS
        contents_view.instance_variable_set(:@contents, contents)
        expect(!!(contents_view.contents.match(/<script>/))).to be_truthy
      end
    end
  end

  describe '#image' do
    before do
      stub_request(:get, 'www.example.com/sample.jpg').
        with(headers: { Accept: ['image/jpeg', 'image/png']})
    end

    it 'image_tagに変換される' do
      url = 'http://www.example.com/sample.jpg'
      contents = "画像テスト\r\n#{url}"
      contents_view.instance_variable_set(:@image_urls, [url])
      contents_view.instance_variable_set(:@contents, contents)
      contents_view.send(:image)
      expect(!!(contents_view.contents.match(/<img src.*>/))).to be_truthy
    end
  end

  describe '#convert_url_to_html!' do
    context '成功' do
      it '?が含まれる' do
        url = 'http://headlines.yahoo.co.jp/hl?a=20161216-00000540-san-pol'
        html = 'foo'
        contents_view.instance_variable_set(:@contents, url)
        expect(contents_view.send(:convert_url_to_html!, url, html)).to be_truthy
      end
    end
  end
end
