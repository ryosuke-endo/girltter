require 'rails_helper'

describe Api::EmojiIndexService do
  describe '#result' do
    context 'query[:name]' do
      it '該当するnameになる' do
        query = { name: 'bow' }.with_indifferent_access
        index = Api::EmojiIndexService.new(query)
        expect(index.result).to eq [Gemojione.index.find_by_name('bow')]
      end
    end

    context 'query[:category]' do
      it '該当するcategoryになる' do
        query = { category: 'people' }.with_indifferent_access
        index = Api::EmojiIndexService.new(query)
        expect(index.result).to eq Gemojione.index.find_by_category('people').values
      end
    end
  end
end
