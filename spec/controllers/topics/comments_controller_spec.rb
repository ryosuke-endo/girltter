require 'rails_helper'

RSpec.describe Topics::CommentsController, type: :controller do
  let(:topic) { create(:topic) }
  describe '#anchor' do
    context 'no1の場合' do
      it 'レスポンス200を返す' do
        params = { topic_id: topic.id, no: 1 }
        get :anchor, params
        expect(response.status).to eq 200
      end
    end

    context 'コメントが取得できない場合' do
      it 'レスポンス404を返す' do
        params = { topic_id: topic.id, no: 2 }
        get :anchor, params
        expect(response.status).to eq 404
      end
    end
  end
end
