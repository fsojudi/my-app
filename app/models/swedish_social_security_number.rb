class  SwedishSocialSecurityNumber
  def initialize(ssn)
    @ssn = ssn
  end

  def valid?
    return false unless valid_format?
    return false unless valid_date?
    valid_check_digit?
  end

  private

#The SSN should match the format YYMMDD-NNNN
#Numerical groups are usually separated by a hyphen (-).
#but if the person is over 100 years old a plus sign (+)
  def valid_format?
    !!(@ssn =~ /^\d{6}[-+]\d{4}$/)
  end

  def valid_date?
    year, month, day = extract_date_parts
    Date.valid_date?(year, month, day)
  end

  def valid_check_digit?
    digits = @ssn.gsub(/[-+]/, "").chars.map(&:to_i)
    checksum = luhn_checksum(digits[0...9])
    checksum == digits[9]
  end

  def extract_date_parts
    year = @ssn[0..1].to_i
    month = @ssn[2..3].to_i
    day = @ssn[4..5].to_i
    [year, month, day]
  end

  def luhn_checksum(digits)
    sum = 0
    digits.each_with_index do |digit, index|
      digit *= 2 if index.even?
      digit = sum_of_digits(digit) if digit > 9
      sum += digit
    end
    (10 - (sum % 10))
  end

  def sum_of_digits(number)
    # Convert the number to a string
    number_string = number.to_s
    sum = 0
    # Iterate through each character of the string
    number_string.each_char do |char|
      # Convert the character back to integer and add it to the sum
      sum += char.to_i
    end
    return sum
  end

end
