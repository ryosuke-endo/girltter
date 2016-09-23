require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    let(:user) { build(:user)}
    let(:params) { { login: user.login,
                     email: user.email,
                     password: 'password',
                     password_confirmation: 'password' } }

    context "with valid params" do
      it "creates a new User with login" do
        expect {
          post :create, { user: params }
        }.to change(User, :count).by(1)
        expect(login?).to be_truthy
        id = session[:user_id]
        expect(response).to redirect_to user_path(id)
      end
    end
  end
end
