class StringCalculator
  def initialize
    @count = 0
  end

  def add(numbers)
    @count += 1
    return 0 if numbers.nil? || numbers.empty?

    delimiters = [',', "\n"]
    nums_str = numbers

    # check for custom delimiter in header
    if numbers.start_with?('//')
      header, nums_str = numbers.split("\n", 2)
      custom_delimiter = header[2..]

      delimiters += if custom_delimiter.start_with?('[')
                      custom_delimiter.scan(/\[(.*?)\]/).flatten
                    else
                      [custom_delimiter]
                    end
    end

    nums = nums_str.split(Regexp.union(delimiters)).map(&:to_i)

    negatives = nums.select(&:negative?)
    raise "negatives not allowed: #{negatives.join(',')}" if negatives.any?

    nums.reject { |n| n > 1000 }.sum
  end

  def get_called_count
    @count
  end
end