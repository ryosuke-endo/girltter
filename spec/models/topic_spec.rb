require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'extract_url' do
    let(:topic) { build(:topic) }

    context 'image_url' do
      it 'image_tagに変換される' do
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
    end
  end
end
