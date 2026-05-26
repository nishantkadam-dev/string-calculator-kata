require_relative '../lib/string_calculator'
require 'spec_helper'

RSpec.describe StringCalculator do
  describe '#add' do
    it 'returns 0 for an empty string' do
      sc = StringCalculator.new
      expect(sc.add("")).to eq(0)
    end
  end
end
