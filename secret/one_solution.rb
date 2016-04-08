# Good luck understanding this

class OneSolution
  attr_reader :coins

  # @param coins [Array<Coin>] of size 12
  def initialize(coins)
    raise 'You need 12 coins at least and 12 coins only' unless coins.count == 12
    @coins = coins
  end

  ######################################
  #  path   chosen? opposite coin_number
  #   LLL	    ---	    ---	      ---
  #   LLR	    xxx	    RRL	      0
  #   LLO	    xxx	    RRO	      1
  #   LRL	    ---	    ---	      ---
  #   LRR	    ---	    ---	      ---
  #   LRO	    xxx	    RLO	      2
  #   LOL	    xxx	    ROR	      3
  #   LOR	    ---	    ---	      ---
  #   LOO	    ---	    ---	      ---
  #   RLL	    xxx	    LRR	      4
  #   RLR	    xxx	    LRL	      5
  #   RLO	    ---	    ---	      ---
  #   RRL	    ---	    ---	      ---
  #   RRR	    ---	    ---	      ---
  #   RRO	    ---	    ---	      ---
  #   ROL	    xxx	    LOR	      6
  #   ROR	    ---	    ---	      ---
  #   ROO	    xxx	    LOO	      7
  #   OLL	    ---	    ---	      ---
  #   OLR	    ---	    ---	      ---
  #   OLO	    ---	    ---	      ---
  #   ORL	    xxx	    OLR	      8
  #   ORR	    xxx	    OLL	      9
  #   ORO	    xxx	    OLO	      10
  #   OOL	    ---	    ---	      ---
  #   OOR	    xxx	    OOL	      11
  #   OOO	    ---	    ---	      ---
  #
  # ===============>
  #
  #   - 1st measure: [C0 C1 C2 C3] ____ [C4 C5 C6 C7]
  #   - 2nd measure: [C0 C1 C4 C5] ____ [C2 C8 C9 C10]
  #   - 3rd measure: [C3 C4 C6 C8] ____ [C0 C5 C9 C11]
  ######################################
  #
  # @return [Hash] {coin_index: [Integer], fake_coin_is: [:heavier or :lighter]}
  # examples of valid outputs:
  #   - {coin_index: 0, fake_coin_is: :heavier}
  #   - {coin_index: 5, fake_coin_is: :lighter}
  def perform
    coin_index, heavier_or_lighter = case shortcut_3_measure_results
                                       when 'LLR'
                                         [0, :heavier]
                                       when 'RRL'
                                         [0, :lighter]
                                       when 'LLO'
                                         [1, :heavier]
                                       when 'RRO'
                                         [1, :lighter]
                                       when 'LRO'
                                         [2, :heavier]
                                       when 'RLO'
                                         [2, :lighter]
                                       when 'LOL'
                                         [3, :heavier]
                                       when 'ROR'
                                         [3, :lighter]
                                       when 'RLL'
                                         [4, :heavier]
                                       when 'LRR'
                                         [4, :lighter]
                                       when 'RLR'
                                         [5, :heavier]
                                       when 'LRL'
                                         [5, :lighter]
                                       when 'ROL'
                                         [6, :heavier]
                                       when 'LOR'
                                         [6, :lighter]
                                       when 'ROO'
                                         [7, :heavier]
                                       when 'LOO'
                                         [7, :lighter]
                                       when 'ORL'
                                         [8, :heavier]
                                       when 'OLR'
                                         [8, :lighter]
                                       when 'ORR'
                                         [9, :heavier]
                                       when 'OLL'
                                         [9, :lighter]
                                       when 'ORO'
                                         [10, :heavier]
                                       when 'OLO'
                                         [10, :lighter]
                                       when 'OOR'
                                         [11, :heavier]
                                       when 'OOL'
                                         [11, :lighter]
                                       else
                                         raise 'Oopsy, I think I screwed up... Or maybe there is no fake coins... Or maybe more than 1 fake coin!'
                                     end
    {coin_index: coin_index, fake_coin_is: heavier_or_lighter}
  end

  # @param indexes [Array<Integer>]
  # @return [Array<Coins>]
  def indexes_to_coins(indexes)
    indexes.map{ |i| coins[i] }
  end

  # @return [String] of size 3, i.e. 'LLR', or 'OOL'
  def shortcut_3_measure_results
    measure_results.map { |measure_result| shortcut_measure_result(measure_result) }.join('')
  end

  # @return [Array<Symbol>] of size 3, i.e. [:left, :left, :right], or [:middle, :middle, :left]
  def measure_results
    left_side1 = indexes_to_coins([0, 1, 2, 3])
    right_side1 = indexes_to_coins([4, 5, 6, 7])
    left_side2 = indexes_to_coins([0, 1, 4, 5])
    right_side2 = indexes_to_coins([2, 8, 9, 10])
    left_side3 = indexes_to_coins([3, 4, 6, 8])
    right_side3 = indexes_to_coins([0, 5, 9, 11])
    [ Measure.new(left_side1, right_side1).measure,
      Measure.new(left_side2, right_side2).measure,
      Measure.new(left_side3, right_side3).measure ]
  end

  # @param measure_result [Symbol] :left, :right, or :middle
  # @return [String] 'L', 'R', or 'O'
  def shortcut_measure_result(measure_result)
    case measure_result
      when :left
        'L'
      when :right
        'R'
      when :middle
        'O'
      else
        raise 'The argument must be one of the following: :left, :right, or :middle'
    end
  end
end
