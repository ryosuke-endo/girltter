# coding: utf-8
module LoveDecorator
  def short_body
    body.slice(1, 100).strip << '...'
  end
end
