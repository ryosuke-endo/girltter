require 'rails_helper'

RSpec.describe 'UserSessions', type: :request do
  describe "POST #create" do
    let(:member) { create(:member) }

    context '成功する' do
      it "email" do
        post user_sessions_path, params: {
          email: member.email,
          password: 'password'
        }
        expect(login?).to be_truthy
      end

      it "login" do
        post user_sessions_path, params: {
          email: member.login,
          password: 'password'
        }
        expect(login?).to be_truthy
      end
    end
  end
end
