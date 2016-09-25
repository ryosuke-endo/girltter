require 'rails_helper'

RSpec.describe Love, type: :model do
  let(:love) { build(:love) }

  %w(title body).each do |column|
    describe "#{column}" do
      it '存在しないといけない' do
        love[column] = ''
        expect(love).not_to be_valid
      end
    end
  end
end
