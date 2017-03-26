require 'rails_helper'

RSpec.describe Api::Topics::CommentsController, type: :request do
  describe '#create' do
    context 'success' do
      it 'response 200' do
        params = { comment: build(:comment).attributes }
        expect {
          post api_topic_comments_path(topic_id: 1, form: :json), params: params
        }.to change { Comment.count }.by(1)
        expect(response.status).to eq 200
      end
    end

    context 'fail' do
      it 'response 422' do
        params = { comment: { name: ''} }
        expect {
          post api_topic_comments_path(topic_id: 1, form: :json), params: params
        }.to change { Topic.count }.by(0)
        expect(response.status).to eq 422
      end
    end
  end
end
