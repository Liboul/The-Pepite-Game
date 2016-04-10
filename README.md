# Want to know if you are a Pépite?
# Welcome to The Pépite Game

### You are given 12 coins, 1 one which is fake, and a twin-pan balance.
### You don't know if the fake coin is heavier or lighter than the others.

# The game is simple:
## Elaborate a strategy to determine which one of the 12 coins is fake, and if it is lighter or heavier.
 Beware, as you can use this balance 3 times at most. If you try to use it more than 3 times, the game ends, and you burn in hell also.

## Solve this problem by

    - Cloning this repo
    - Implementing the `perform` method in the file `my_strategy.rb`

 Some more instructions are given in this file if you are lost.

 When you think you got it solved, run `ruby am_i__a_pepite.rb` in your terminal to see the result of your efforts.

 Good luck, and remember:
   - Do not ever use the balance more than 3 times, or chaos will ensue
   - Take a pick at the 'secret' directory and you'll be burnt to ashes in a glimpse. I wouldn't do that if I were you.

 ## To use the balance in your code:
 Call `Measure.new(left_side_coins, right_side_coins).measure`
 with your `left_side_coins` and `right_side_coins` (arrays of coins, sub-arrays of the coins input).

 The result will be one of the following: `:left`, `:right`, or `:middle`
 
    - `:left` if the left side is heavier than the right side
    - `:right` if the right side is heavier than the left side
    - `:middle` if the left side and the right side of the balance are

 For additional points, document your code, and explain why your strategy is better than everybody else's.

## Have fun.

## Finished the game?

 Congrats! Open a pull request with your solution!
