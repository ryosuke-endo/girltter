require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    let(:comment) { build(:comment) }
    context 'body' do
      it '存在しないといけない' do
        comment.body = ''
        expect(comment).not_to be_valid
      end
    end

    context 'name' do
      it '存在しないといけない' do
        comment.name = ''
        expect(comment).not_to be_valid
      end
    end
  end
end
