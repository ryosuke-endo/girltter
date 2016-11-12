require 'rails_helper'

RSpec.feature 'comment', js: true do
  let(:member) { create(:member) }
  let(:love) { create(:love, :with_category) }
  before do
    login_as(member)
  end

  context '投稿' do
    context '成功' do
      it 'コメント本文が表示される' do
        visit love_path(love)
        find('#comment_body').set('出直し')
        find('#js-comment-btn').click
        expect(page).to have_selector 'p', text: '出直し'
      end
    end
  end
end
