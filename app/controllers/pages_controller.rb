class PagesController < ApplicationController
  def terms
    @tag_ranking = ActsAsTaggableOn::Tag.most_used
  end
end
