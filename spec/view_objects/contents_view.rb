require 'rails_helper'
require 'webmock/rspec'

describe ContentsView do
  include ActionView::TestCase::Behavior

  OG_BODY = <<-"EOS"
<html xmlns:og="http://opengraphprotocol.org/schema/">
  <head>
    <meta charset="utf-8"/>
    <meta property="og:type" content="website"/>
    <meta property="og:site_name" content="foo.com">
    <meta property="og:title" content="Title from og">
    <meta property="og:description" content="Description from og">
    <title>Title</title>
  </head>
</html>
  EOS

  OG_WITH_IMAGE_BODY = <<-"EOS"
<html xmlns:og="http://opengraphprotocol.org/schema/">
  <head>
    <meta charset="utf-8"/>
    <meta property="og:type" content="website"/>
    <meta property="og:site_name" content="foo.com">
    <meta property="og:title" content="Title from og">
    <meta property="og:description" content="Description from og">
    <meta property="og:image" content="http://foo.com/foo.png">
    <meta property="og:image:width" content="100">
    <meta property="og:image:height" content="100">
    <title>Title</title>
  </head>
</html>
  EOS

  SCRIPT_TAG = <<~"EOS"
    <script>
      alert('foo');
    </script>
  EOS

  describe '#processing_display' do
    context 'brタグ変換' do
      context '文字列だけ' do
        it '変換される' do
          contents = "fpp\r\nbar\r\n\r\n\r\nbaz"
          contents_view = ContentsView.new(contents)
          expect(contents_view.processing_display.scan(/<br>/).size).to eq 4
        end
      end

      context '引用URLを含む' do
        before do
          stub_request(:get, 'http://www.example.com/').
            to_return(status: 200, body: OG_BODY, headers: {})
        end

        it '変換される' do
          url = 'http://www.example.com/'
          contents = "fpp\r\nbar\r\n\r\n\r\nbaz#{url}"
          contents_view = ContentsView.new(contents)
          expect(contents_view.processing_display.scan(/<br>/).size).to eq 4
        end
      end
    end

    it 'script_tagを許可しない' do
      contents_view = ContentsView.new(SCRIPT_TAG)
      expect(!!(contents_view.processing_display.match(/<script>/))).to be_falsey
    end

    context '画像URLがある場合' do
      before do
        stub_request(:get, 'www.example.com/sample.jpg').
          with(headers: { Accept: ['image/jpeg', 'image/png'] })
      end

      it 'image_tagに変換される' do
        url = 'http://www.example.com/sample.jpg'
        contents = "画像テスト\r\n#{url}"
        contents_view = ContentsView.new(contents)
        expect(!!(contents_view.processing_display.match(/<img src.*>/))).to be_truthy
      end
    end

    context '引用URLにOGが含まれる場合' do
      context '?が含まれる場合' do
        before do
          stub_request(:get, 'http://www.example.com/hl?a=20170107-00000000-jct-soci').
            to_return(status: 200, body: OG_BODY, headers: {})
        end

        it '変換される' do
          url = 'http://www.example.com/hl?a=20170107-00000000-jct-soci'
          contents = "?が含まれる\r\n#{url}"
          contents_view = ContentsView.new(contents)
          contents_view.processing_display
          expect(contents_view.contents.match(/Title from og/)).to be_truthy
          expect(contents_view.contents.match(/Description from og/)).to be_truthy
          expect(contents_view.contents.match(/no_image.*\.png/)).to be_truthy
        end
      end

      context '画像が含まれる場合' do
        before do
          stub_request(:get, 'http://www.example.com/').
            to_return(status: 200, body: OG_WITH_IMAGE_BODY, headers: {})
          stub_request(:get, 'http://foo.com/foo.png').
            to_return(status: 200, body: '', headers: {})
        end

        it '画像URLに変換される' do
          url = 'http://www.example.com/'
          contents_view = ContentsView.new(url)
          contents_view.processing_display
          expect(contents_view.contents.match(/Title from og/)).to be_truthy
          expect(contents_view.contents.match(/Description from og/)).to be_truthy
          expect(contents_view.contents.match(/no_image.*\.png/)).to be_falsey
        end
      end
    end
  end
end
