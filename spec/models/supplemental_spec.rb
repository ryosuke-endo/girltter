require 'rails_helper'

RSpec.describe Supplemental, type: :model do
  describe 'validation' do
    describe 'Memberが投稿する件数' do
      let!(:supplemental) { create(:supplemental, :with_love) }
      let!(:other_supplemental) { create(:supplemental,
                                         supplementable_id: supplemental.supplementable.id,
                                         supplementable_type: supplemental.supplementable_type) }

      it '最大2件' do
        expect(build(:supplemental,
                     supplementable_id: supplemental.supplementable.id,
                     supplementable_type: supplemental.supplementable_type))
          .not_to be_valid
      end
    end
  end
end
