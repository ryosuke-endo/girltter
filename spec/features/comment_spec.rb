require 'rails_helper'

describe 'comment', js: true do
  let!(:member) { create(:member) }
  before do
    login_as(member)
  end

  context '投稿' do
    context '成功' do
      it 'modalが表示される' do
        visit '/'
      end
    end
  end
end
