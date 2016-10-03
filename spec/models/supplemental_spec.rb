require 'rails_helper'

RSpec.describe Supplemental, type: :model do
  describe 'validation' do
    describe 'Memberが投稿する件数' do
      let!(:love) { create(:love, :with_member) }
      let!(:supplemental) { create(:supplemental) }
      let!(:other_supplemental) { create(:supplemental) }

      it '最大2件' do
        expect(build(:supplemental)).not_to be_valid
      end
    end
  end
end
