class StringCalculator
  def initialize
    @count = 0
  end

  def add(numbers)
    @count += 1
    return 0 if numbers.empty? || numbers.nil?
    # default delimiters: comma and newline
    delimiters = [',', "\n"]
    nums_str = numbers
    
    # check for custom delimiter in header
    if numbers.start_with?('//')
      header, nums_str = numbers.split("\n", 2)
      custom_delimiter = header[2..-1] # get the part after '//'
      delimiters << custom_delimiter
    end

    nums = nums_str.split(Regexp.union(delimiters)).map(&:to_i)
    negatives = nums.select { |n| n < 0 }
    raise "negatives not allowed: #{negatives.join(',')}" unless negatives.empty?

    nums.sum
  end
end