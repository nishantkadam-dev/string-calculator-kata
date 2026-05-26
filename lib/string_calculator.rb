class StringCalculator
  def initialize
    @count = 0
  end

  def add(numbers)
    @count += 1
    return 0 if numbers.empty? || numbers.nil?
    # default delimiters: comma
    delimiters = [',']
    numbers.split(Regexp.union(delimiters)).map(&:to_i).sum
  end
end