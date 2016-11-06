require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  describe 'GET #index' do
    let(:member) { create(:member)}
    context 'redirect to root' do
      it 'not logged in user' do
        get :index
        expect(response).to redirect_to root_path
      end

      it 'logged in member' do
        login_as(member)
        get :index
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST #create" do
    let(:member) { build(:member)}
    let(:params) { { login: member.login,
                     email: member.email,
                     password: 'password',
                     password_confirmation: 'password' } }

    context "with valid params" do
      it "creates a new Member with login" do
        expect {
          post :create, { member: params }
        }.to change(Member, :count).by(1)
        expect(login?).to be_truthy
        id = session[:user_id]
        expect(response).to redirect_to home_path
      end
    end
  end
end
