require 'rails_helper'

describe Api::EmojiIndexService do
  describe '#result' do
    context '#except' do
      it 'unicode_version' do
        query = { except: { unicode_version: '9.0' } }.with_indifferent_access
        index = Api::EmojiIndexService.new(query)
        expect(index.result.all? { |x| x.unicode_version != '9.0'}).to be_truthy
      end

      it 'ios_version' do
        query = { except: { ios_version: '10.0' } }.with_indifferent_access
        index = Api::EmojiIndexService.new(query)
        expect(index.result.all? { |x| x.ios_version != '10.0'}).to be_truthy
      end
    end
  end
end
