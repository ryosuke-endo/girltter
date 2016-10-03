require 'rails_helper'

RSpec.describe MembersController, type: :controller do
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
        expect(response).to redirect_to member_path(id)
      end
    end
  end
end
