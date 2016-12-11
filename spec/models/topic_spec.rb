require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Topic, type: :model do
  describe 'process_body' do
    let(:topic) { build(:topic) }

    context 'image_url' do
      it 'image_tagに変換される' do
        stub_request(:get, 'www.example.com/sample.jpg').
          with(headers: { Accept: ['image/jpeg', 'image/png']})
        url = "http://www.example.com/sample.jpg"
        host_name = URI.parse(url).hostname
        text = <<~"EOS"
          <div class="c-grid__quotation-image">
            <img src="#{url}" alt="Sample" />
            <a href=#{url} target=\"_blank\">
              出典：#{host_name}
            </a>
          </div>
        EOS
        topic.body = url
        topic.save
        expect(topic.body).to eq text
      end

      context '拡張子' do
        context '画像拡張子以外' do
          extensions = %w(zip cgi dat doc exe js lzh mpeg wav)
          extensions.each do |extension|
            it "#{extension}はエラーになる" do
              stub_request(:get, 'www.example.com/sample.zip').
                with(headers: { Accept: ['image/jpeg', 'image/png']})
              url = "http://www.example.com/sample.zip"
              topic.body = url
              topic.save
              expect(topic.errors[:body]).to be_present
            end
          end
        end
      end
    end
  end
end
