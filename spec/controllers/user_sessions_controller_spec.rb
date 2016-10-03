require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  describe "POST #create" do
    let(:member) { create(:member) }

    context '成功する' do
      it "email" do
        post :create, { email: member.email,
                        password: 'password' }
        expect(login?).to be_truthy
      end

      it "login" do
        post :create, { email: member.login,
                        password: 'password' }
        expect(login?).to be_truthy
      end
    end
  end
end
