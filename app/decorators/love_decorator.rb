# coding: utf-8
module LoveDecorator
  def short_body
    body.length <= 100 ? body : truncate(body, length: 100, omission: '...')
  end
end
