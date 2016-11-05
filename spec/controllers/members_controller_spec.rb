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


  describe "PATCH #update_password" do
    let(:member) { create(:member) }
    let(:params) { { password: 'pass',
                     password_confirmation: 'pass' } }

    context "with invalid params less than 8 character" do
      before do
        login_as(member)
      end
      it "fail" do
        patch :update_password, member_id: member.id, member: params
        expect(assigns(:member).errors.present?).to be_truthy
      end
    end
  end
end
