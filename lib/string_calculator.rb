class StringCalculator
  def initialize
    @count = 0
  end

  def add(numbers)
    @count += 1
    return 0 if numbers.empty? || numbers.nil?
    # Further behavior implemented in later steps
    numbers.to_i
  end
end