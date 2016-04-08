require './secret/coin.rb'
require './secret/measure.rb'
require './secret/one_solution.rb'

class TestStrategy
  attr_reader :strategy

  # @param strategy [Class] that responds to :perform
  def initialize(strategy)
    @strategy ||= strategy
  end

  # @note (re)sets @coins to a size 12 array of coins of weight 1
  def set_coins
    @coins = [Coin.new(1)]*12
    true
  end

  # @param i [Integer] between 0 and 11
  # @param change [Symbol] :lighter or :heavier
  # @note changes @coins by faking the coin number i
  def fake_coin(i, change)
    case change
      when :lighter
        @coins[i] = Coin.new(0.5)
      when :heavier
        @coins[i] = Coin.new(1.5)
      else
        raise 'Second argument must be :lighter or :heavier...'
    end
  end

  # @param i [Integer] between 0 and 11
  # @param change [Symbol] :lighter or :heavier
  # @note changes @coins by faking the coin number i
  def check_result(i, change)
    raise 'Second argument must be :lighter or :heavier...' unless %i(lighter heavier).include?(change)
    set_coins and fake_coin(i, change)
    begin
      strategy.new(@coins).perform == {coin_index: i, fake_coin_is: change} ? :correct : :incorrect
    rescue Measure::TooManyMeasuresError
      :too_many_measures_error
    rescue
      :other_error
    end
  end

  # @note alters @coins
  # @return [Hash] results of MyStrategy on all possible coins sets
  #   i.e. {correct: 10, incorrect: 4, too_many_measures_error: 3, other_error: 5}
  def check_all_results
    (0..11).inject([]) do |results, i|
      results << check_result(i, :lighter)
      Measure.reset_number_of_measures
      results << check_result(i, :heavier)
      Measure.reset_number_of_measures
      results
    end.group_by(&:to_sym).map{|k, v| [k, v.count]}.to_h
  end

  # Prints the result of the test in the terminal. Let's make it pretty!
  def perform_test
    puts <<-header

######################################################################################################################

                          So you think you have beaten The Pépite Game, huh?
                          Think you are a Pépite? Think again you cheeky little rubyist.
                          I doubt you would understand the solution if I gave it to you ...
                          But let's see that right now...

######################################################################################################################

    header

    sleep(3)

    print '                           Suspense...'
    10.times{sleep(0.2); print('.')}

    puts "\n"

    results = check_all_results
    sleep(1)


    if results[:correct].to_i < 24
      if results[:correct].to_i == 0
        message = "                           I'm laughing my ass off. Not a single one of your predictions is correct.\n                           Come back when you know Ruby and bought a brain."
      else
        message = "                           Not even close... Somehow you managed to get it #{results[:correct]*100.0/24} % correct. I guess you're just lucky..."
      end
      message << "\n                           Oh and by the way, stop cheating, you can't make more than 3 measures, alright?" if results[:too_many_measures_error].to_i > 0

      puts <<-result

######################################################################################################################

#{message}

######################################################################################################################
      result

    else
      puts "\n######################################################################################################################\n\n"
      puts '                           Oh My.'
      sleep(1)
      puts "                           No way, that's impossible! How did you...?"
      sleep(3)
      puts "                           Admit it, you cheated, right?"
      sleep(3)
      puts "                           That's it, you smartass, I'm done. Congrats."
      sleep(3)
      puts "                           Here, consider this potato a reward."
      sleep(2)
      puts <<-potato


                                      TOPOTATOPOTATOPOTATOPOTATOPOTATO
                                    POTATOPOTATOPOTATOPOTATOPOTATOPOTATO
                                  TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                                TATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTA
                              POTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                            TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                              POTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATO
                                TATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPOTA
                                  TOPOTATOPOTATOPOTATOPOTATOPOTATOPOTATOPO
                                    POTATOPOTATOPOTATOPOTATOPOTATOPOTATO
                                      TOPOTATOPOTATOPOTATOPOTATOPOTATO
      potato
    end
  end
end
