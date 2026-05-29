require_relative '../lib/string_calculator'
require 'spec_helper'

RSpec.describe StringCalculator do
  let(:sc) { StringCalculator.new }
  describe '#add' do
    it 'returns 0 for an empty string' do
      expect(sc.add("")).to eq(0)
    end

    it "returns the number for a single number string" do
      expect(sc.add("1")).to eq(1)
    end

    it "returns the sum of two numbers in a string" do
      expect(sc.add("1,2")).to eq(3)
    end

    it "handle an unknown amount of numbers and newlines as delimiters" do
      expect(sc.add("1\n2,3")).to eq(6)
    end

    it 'supports custom single-character delimiter specified in header' do
      expect(sc.add("//;\n1;2")).to eq(3)
    end

    it 'raises on negative numbers with message listing negatives' do
      expect { sc.add("-1,2,-3") }.to raise_error(/negatives not allowed: -1,-3/)
    end

    it 'tracks how many times add was called' do
      sc.add("")
      sc.add("1")
      expect(sc.get_called_count).to eq(2)
    end

    it "ignores numbers greater than 1000" do
      expect(sc.add("2,1001")).to eq(2)
    end


    it 'supports delimiters of any length like [***]' do
      expect(sc.add("//[***]\n1***2***3")).to eq(6)
    end

    it 'supports multiple delimiters like [*][%]' do
      expect(sc.add("//[*][%]\n1*2%3")).to eq(6)
    end

    it 'supports multiple delimiters with length longer than one char' do
      expect(sc.add("//[**][%%]\n1**2%%3")).to eq(6)
    end
  end
end
