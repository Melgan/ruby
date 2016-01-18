class Money
  attr_reader :value, :currency

  def initialize(value, currency)
    @value = value.to_f.round(2)
    @currency = currency.to_s
  end

  def to_s
    "%.2f %s" % [value, currency]
  end

  def *(num)
    Money.new(value * num, currency)
  end

  def +(other)
    if other.currency != currency
      raise ArgumentError.new("Can't add monies due to different currency: #{other.inspect} and #{self.inspect}.")
    end
    Money.new(value + other.value, currency)
  end

  def -(other)
    if other.currency != currency
      raise ArgumentError.new("Can't substract monies due to different currency: #{other.inspect} and #{self.inspect}.")
    end
    Money.new(value - other.value, @currency)
  end

  def /(other)
    if other.currency != currency
      raise ArgumentError.new("Can't divide two monies in different currencies: #{other.inspect} and #{self.inspect}")
    end
    Money.new(value / other.value, currency)
  end

  def ==(other)
    currency == other.currency && @value == other.value
  end

  def positive?
    @value > 0
  end

  def negative?
    @value < 0
  end

  def the_same_currency(other)
    currency == other.currency
  end

  def different_currency(other)
    !the_same_currency(other)
  end

  def self.convert(arry)
    if arry.size >= 3
      raise ArgumentError.new("The size of array is to big: #{arry.inspect}")
    end
    Money.new(arry[0], arry[1])
  end

  # This is a version of sum that works with different currencies.
  # Returns an array of Money instances, one for each currency that appeared
  # in the input array.
  def self.sum(moneys)
    moneys.group_by(&:currency).values.map(&:sum)
  end
end
