require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  describe "POST #create" do
    let(:user) { create(:user) }

    context '成功する' do
      it "email" do
        post :create, { email: user.email,
                        password: 'password' }
        expect(login?).to be_truthy
      end

      it "login" do
        post :create, { email: user.login,
                        password: 'password' }
        expect(login?).to be_truthy
      end
    end
  end
end
