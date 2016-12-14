require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Topic, type: :model do
  let(:topic) { build(:topic) }

  context 'invalid_extension' do
    context '画像拡張子以外' do
      extensions = %w(zip cgi dat doc exe js lzh mpeg wav)
      extensions.each do |extension|
        before do
          stub_request(:get, "www.example.com/sample.#{extension}").
            with(headers: { Accept: ['image/jpeg', 'image/png'] })
        end

        it "#{extension}はエラーになる" do
          url = "http://www.example.com/sample.#{extension}"
          topic.body = url
          topic.save
          expect(topic.errors[:body]).to be_present
        end
      end
    end
  end
end
