class Admin::Tags::SimultaneousRegistrationController < AdminController
  def index
  end

  def create
    tags = ActsAsTaggableOn::Tag.pluck(:name)
    Love.find_each do |love|
      tags.each do |tag|
        if !!(love.body.match(tag))
          love.tag_list << tag
        end
      end
      if love.tag_list.present?
        love.save
      end
    end
  end
end
