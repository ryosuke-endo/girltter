require 'rails_helper'

RSpec.describe 'Members', type: :request do
  describe "POST #create" do
    let(:member) { build(:member)}
    let(:params) { { login: member.login,
                     email: member.email,
                     password: 'password',
                     password_confirmation: 'password' } }

    context "with valid params" do
      it "creates a new Member with login" do
        expect {
          post members_path, params: { member: params }
        }.to change(Member, :count).by(1)
        expect(login?).to be_truthy
        expect(response).to redirect_to home_path
      end
    end
  end
end
