require 'rails_helper'

RSpec.describe "cookies", type: :request do
  fixtures :topics, :analysis

  context '#set_identity_cookie' do
    it '_cadrが設定される' do
      get root_path
      expect(response.cookies['_cadr'].present?).to be_truthy
    end
  end
end
