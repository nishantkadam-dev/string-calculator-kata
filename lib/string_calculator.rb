class StringCalculator
  def initialize
    @count = 0
  end

  def add(numbers)
    @count += 1
    return 0 if numbers.empty? || numbers.nil?
    # support for comma-separated numbers for now
    numbers.split(',').map(&:to_i).sum 
  end
end