class Measure
  def self.result(left_side_coins, right_side_coins)
    new(left_side_coins, right_side_coins).measure
  end

  attr_reader :left_side_coins, :right_side_coins

  # @param left_side_coins [Array<Coin>]
  # @param right_side_coins [Array<Coin>]
  def initialize(left_side_coins, right_side_coins)
    @left_side_coins = Array(left_side_coins)
    @right_side_coins = Array(right_side_coins)
  end

  # @return[:left, :right, :middle] which side is heavier
  def measure
    self.class.count_measure
    left_side_weight_sum = left_side_coins.map(&:weight).reduce(:+)
    right_side_weight_sum = right_side_coins.map(&:weight).reduce(:+)
    case
      when left_side_weight_sum > right_side_weight_sum
        :left
      when left_side_weight_sum < right_side_weight_sum
        :right
      else
        :middle
    end
  end

  class << self

    # @note increments @number_of_measures by 1
    # @note Raises an error if we have already done 3 measures. In this case, we reset the number of measures.
    def count_measure
      @number_of_measures ||= 0
      if (@number_of_measures += 1) > 3
        raise TooManyMeasuresError.new('Dude seriously, I told you not to overuse the balance...')
      end
      true
    end

    # @note resets @number_of_measures to 0
    def reset_number_of_measures
      @number_of_measures = 0
      true
    end
  end

  class TooManyMeasuresError < StandardError; end
end
