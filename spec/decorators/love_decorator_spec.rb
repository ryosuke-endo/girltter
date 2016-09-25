# coding: utf-8
require 'spec_helper'

describe LoveDecorator do
  let(:love) { Love.new.extend LoveDecorator }
  subject { love }
  it { should be_a Love }
end
