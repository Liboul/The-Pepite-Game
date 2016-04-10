require './secret/solutions/solution_base'

# Good luck understanding this

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

class OneBetterSolution < SolutionBase
  # @return [Hash] {coin_index: [Integer], fake_coin_is: [:heavier or :lighter]}
  # examples of valid outputs:
  #   - {coin_index: 0, fake_coin_is: :heavier}
  #   - {coin_index: 5, fake_coin_is: :lighter}
  def perform
    heavy_coin_index = coin_paths.key(measures)
    return {coin_index: heavy_coin_index, fake_coin_is: :heavier} if heavy_coin_index
    light_coin_index = coin_paths.key(invert_path(measures))
    return {coin_index: light_coin_index, fake_coin_is: :lighter} if light_coin_index
    raise 'I think I screwed up somewhere...'
  end

  # @return [Hash]
  def coin_paths
    Hash[(0..11).zip %w(LLR LLO LRO LOL RLL RLR ROL ROO ORL ORR ORO OOR)]
  end

  # @param i [integer] between 0 and 2
  # @return [Symbol] :right, :left, or :middle
  def measure(i)
    left_side = indexes_to_coins(coin_paths.select{|_k, v| v[i] == 'L'}.keys)
    right_side = indexes_to_coins(coin_paths.select{|_k, v| v[i] == 'R'}.keys)
    Measure.new(left_side, right_side).measure
  end

  # @return [String] shortcut for the result of the 3 measures, i.e. 'LOL', 'ROL', 'LLR'
  def measures
    @measures ||= (0..2).map{|i| shortcut_measure_result(measure(i))}.join('')
  end

  # @param measure_result [Symbol] :left, :right, or :middle
  # @return [String] 'L', 'R', or 'O'
  def shortcut_measure_result(measure_result)
    {right: 'R', left: 'L', middle: 'O'}[measure_result]
  end

  # @param path [String] of size 3, i.e. 'LLR', 'LOL'
  # @return [String] of size 3, i.e. 'RRL', 'ROR'
  def invert_path(path)
    path.split('').map{|letter| invert_measure(letter)}.join('')
  end

  # @param letter [String] of size 1, 'L', 'R' or 'O'
  # @return [String] of size 1, 'L', 'R' or 'O'
  def invert_measure(letter)
    {'L' => 'R', 'R' => 'L', 'O' => 'O'}[letter]
  end

  # @param indexes [Array<Integer>]
  # @return [Array<Coins>]
  def indexes_to_coins(indexes)
    indexes.map{ |i| coins[i] }
  end
end
