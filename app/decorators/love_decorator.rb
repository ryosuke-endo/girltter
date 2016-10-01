# coding: utf-8
module LoveDecorator
  def short_body
    body.slice(0, 100).strip << '...'
  end
end
