require 'rails_helper'

RSpec.describe 'Api::TopicsController', type: :request do
  describe '#create' do
    context 'success' do
      it 'response 200' do
        params = { topic: FactoryGirl.build(:topic).attributes }
        expect {
          post api_topics_path(format: :json), params
        }.to change { Topic.count }.by(1)
        expect(response.status).to eq 200
      end
    end

    context 'fail' do
      it 'response 422' do
        params = { topic: { title: "foo"} }
        expect {
          post api_topics_path(format: :json), params
        }.to change { Topic.count }.by(0)
        expect(response.status).to eq 422
      end
    end
  end
end
