require './secret/test_strategy.rb'
require './my_strategy'

TestStrategy.new(MyStrategy).perform_test
