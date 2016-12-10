class TempFile < ActiveRecord::Base
  has_attached_file :temp, styles: { medium: '300x300>', thumb: '140x140>' }
  validates_attachment :temp,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }
end
