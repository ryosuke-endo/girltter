module TempFileable
  extend ActiveSupport::Concern
  attr_reader :temp_file

  def temp_file=(temp_file)
    @temp_file = TempFile.new
    temp_files = TempFile.where(temp_file_name: temp_file.original_filename)
    if temp_files.count.zero?
      @temp_file.temp = temp_file
      @temp_file.save
    else
      sizes = temp_files.map(&:temp_file_size).select { |x| x == temp_file.size }
      if sizes.blank?
        @temp_file.temp = temp_file
        @temp_file.save
      else
        @temp_file = temp_files.first
      end
    end
  end
end
