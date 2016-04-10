# Good luck understanding this

class SolutionBase
  attr_reader :coins

  # @param coins [Array<Coin>] of size 12
  def initialize(coins)
    raise 'You need 12 coins at least and 12 coins only' unless coins.count == 12
    @coins = coins
  end

  # Should be overridden in child classes
  # @return [Hash] {coin_index: [Integer], fake_coin_is: [:heavier or :lighter]}
  # examples of valid outputs:
  #   - {coin_index: 0, fake_coin_is: :heavier}
  #   - {coin_index: 5, fake_coin_is: :lighter}
  def perform
    raise NotImplementedError
  end
end
