require './secret/solutions/solution_base'

# Welcome to the game:
#
# You are given 12 coins, 1 one which is fake, but you don't know if the fake coin is heavier or lighter.
# You are also given a regular balance with two plates.
#
# The game is simple: Elaborate a strategy to determine which one of the 12 coins is fake,
#   and if it is lighter or heavier.
# Beware, as you can use this balance 3 times at most. If you try to use it more than 3 times, the game ends.
#
# To use this balance, simply call `Measure.result(left_side_coins, right_side_coins)`
#   with your left_side_coins and right_side_coins (array of coins, sub-arrays of the coins input).
#
# The result will be one of the following: :left, :right, or :middle
#   :left if the left side is heavier than the right side
#   :right if the right side is heavier than the left side
#   :middle if the left side and the right side are balanced
#
# Your goal is to write the perform method.
# When you are done, run `ruby am_i_a_pepite.rb` in your terminal to see the result of your strategy.
#
# Good luck, and remember:
#   - Do not ever use the balance more than 3 times, or chaos will ensue
#   - Take a pick at the 'secret' directory and you'll be burnt to ashes in a glimpse. I wouldn't do that if I were you
#
# For additional points, document your code, and explain why your strategy is better than everybody else's.
# Have fun.
#
#
class MyStrategy < SolutionBase

  # You have access to the `coins` attribute. It returns an array of 12 Coins you can use to make measures.
  # Check out `SolutionBase` if you're curious.

  # @return [Hash] {coin_index: [Integer], fake_coin_is: [:heavier or :lighter]}
  # examples of valid outputs:
  #   - {coin_index: 0, fake_coin_is: :heavier}
  #   - {coin_index: 5, fake_coin_is: :lighter}
  def perform

  end

  # Use auxiliary methods if you want, it's Ruby, make it self-explanatory!
  #
  #
  #
  #
  #
end
