# coding: utf-8
require 'rails_helper'

describe LoveDecorator do
  let(:love) { build(:love).extend(LoveDecorator) }

  context 'less than 100 charcterts' do
    it 'no change body' do
      love.body = "a" * 99
      expect(love.short_body.length).to eq love.body.length
    end
  end

  context 'equel 100 charcterts' do
    it 'no change body' do
      love.body = "a" * 100
      expect(love.short_body.length).to eq love.body.length
    end
  end
end
