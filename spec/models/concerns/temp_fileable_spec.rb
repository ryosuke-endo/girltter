require 'rails_helper'

RSpec.describe TempFileable do
  describe '#temp_file=' do
    def upload(file_path)
      ActionDispatch::Http::UploadedFile.new(
        tempfile: File.open(file_path),
        filename: File.basename(file_path),
        type: 'image/jpeg'
      )
    end

    let(:topic) { build(:topic) }

    context '保存される' do
      let!(:temp) { create(:temp_file) }

      it '同一ファイル名, 違うファイルサイズ' do
        file_path = "#{Rails.root}/spec/fixtures/image/2.jpg"
        upload_file = upload(file_path)
        upload_file.original_filename = temp.temp_file_name
        expect {
          topic.temp_file = upload_file
        }.to change { TempFile.count }.by(1)
      end
    end

    context '保存しない' do
      let!(:temp) { create(:temp_file) }

      context '同一ファイル名, 同一ファイルサイズ' do
        it '先に保存されているものになる' do
          file_path = "#{Rails.root}/spec/fixtures/image/1.jpg"
          topic.temp_file = upload(file_path)
          expect(topic.temp_file).to eq temp
        end
      end
    end
  end
end
