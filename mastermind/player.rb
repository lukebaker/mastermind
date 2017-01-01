require_relative 'level'
require_relative 'game'
module Mastermind
  class Player

    def initialize(client:)
      @client = client
    end

    def play(level=1)
      start_new_level(level)
    end

    def start_new_level(level_num)
      level = @client.start_level(level_num)
      level_details = level.parsed_response

      @current_level = initialize_new_level(level_num, level_details)

      reset_remaining_possibilities

      resp = solve_current_level
      if resp['message'] and !resp['hash']
        start_new_level(level_num + 1)
      else
        puts resp.inspect
      end
    end

    def initialize_new_level(level_num, level_details)
      level_details.keys.each do |key|
        level_details[(key.to_sym rescue key) || key] = level_details.delete(key)
      end
      level_details[:levelNum] = level_num

      Mastermind::Level.new(level_details)
    end

    def reset_remaining_possibilities
      @remaining_possibilities = @current_level.all_possible_guesses
    end

    def solve_current_level
      # Too many possibilities? Reduce weapon options with not-as-smart guesses.
      reduce_weapon_options if @remaining_possibilities.size > 10 ** 6
      if !@remaining_possibilities.kind_of?(Array)
        @remaining_possibilities = @remaining_possibilities.to_a
      end

      guess = @remaining_possibilities.sample
      response = @client.solve_level(@current_level.levelNum, guess)

      if response['roundsLeft']
        # If we're starting a new round, reset possibilities and restart level.
        reset_remaining_possibilities
        return solve_current_level
      elsif !response['response']
        # Unhandled response, return to sender. Most likely success or too many guesses.
        return response
      end

      # Only keep possibilities that would yield same response if they were the secret.
      @remaining_possibilities.select! do |possibility|
        Mastermind::Game.evaluate(guess, possibility) == response['response']
      end
      solve_current_level
    end

    # Level 4 has 25 weapon options, which yields over 100 million permutations
    # of guesses. reduce_weapon_options reduces the possible guesses by using
    # not as smart guess to reduce the number of weapon options.
    def reduce_weapon_options
      # Here we're simple interested in eliminating weapons, so we care only
      # about combinations, not perumtations. This is more manageable.
      weapon_combinations = @current_level.weapon_combinations.to_a
      guesses_with_answer = []

      # Guess until we've narrowed it down to 10 weapons or fewer.
      while weapon_combinations.flatten.uniq.size > 10 do
        weapon_guess = weapon_combinations.sample
        resp = @client.solve_level(@current_level.levelNum, weapon_guess)
        weapon_combinations.select! do |possibility|
          # At the moment, we only care about which weapons are correctly used.
          Mastermind::Game.evaluate(weapon_guess, possibility).first == resp['response'].first
        end
        # Save guesses and full answer to process later.
        guesses_with_answer << [weapon_guess, resp['response']]
      end
      # Now that we've reduced the number of weapons, generate list of all
      # remaining possibilities.
      @remaining_possibilities = @current_level.possible_answers(weapon_combinations.flatten.uniq).to_a

      # Loop through prior guesses to eliminate any that can be.
      guesses_with_answer.each do |gwa|
        @remaining_possibilities.select! do |possibility|
          Mastermind::Game.evaluate(gwa[0], possibility) == gwa[1]
        end
      end
      @remaining_possibilities
    end

  end
end
