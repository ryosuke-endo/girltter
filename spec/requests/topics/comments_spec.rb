require 'rails_helper'

RSpec.describe Topics::CommentsController, type: :request do
  describe '#anchor' do
    context 'params[:no] == 1' do
      let(:topic) { create(:topic) }
      it 'topicのbodyが返ってくる' do
        params = { topic_id: topic.id, no: 1 }
        get topic_anchor_path(params)
        expect(response.body).to include(topic.body)
        expect(response.status).to eq 200
      end
    end

    context 'params[:no] !== 1' do
      let(:topic) { create(:topic, :with_comment) }
      it 'commentのbodyが返ってくる' do
        params = { topic_id: topic.id, no: 2 }
        get topic_anchor_path(params)
        expect(response.body).to include(topic.comments.first.body)
        expect(response.status).to eq 200
      end
    end
  end
end
