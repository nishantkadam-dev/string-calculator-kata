require_relative '../lib/string_calculator'
require 'spec_helper'

RSpec.describe StringCalculator do
  describe '#add' do
    it 'returns 0 for an empty string' do
      sc = StringCalculator.new
      expect(sc.add("")).to eq(0)
    end

    it "returns the number for a single number string" do
      sc = StringCalculator.new
      expect(sc.add("1")).to eq(1)
    end

    it "returns the sum of two numbers in a string" do
      sc = StringCalculator.new
      expect(sc.add("1,2")).to eq(3)
    end
  end
end
