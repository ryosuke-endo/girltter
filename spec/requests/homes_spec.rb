require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe '#PATCH #update_password' do
    let(:member) { create(:member) }
    let(:params) { { password: 'pass',
                     password_confirmation: 'pass' } }

    context 'with invalid params less than 8 character' do
      before do
        login_as(member)
      end
      it 'fail' do
        patch update_password_home_path(member_id: member.id), params: { member: params }
        expect(assigns(:member).errors.present?).to be_truthy
      end
    end
  end
end
