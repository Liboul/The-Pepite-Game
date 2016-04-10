require './secret/test_strategy.rb'
require './secret/solutions/one_solution'
require './secret/solutions/one_better_solution.rb'
require './my_strategy'

TestStrategy.new(MyStrategy).perform_test
