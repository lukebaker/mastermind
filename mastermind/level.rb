module Mastermind
  class Level
    attr_reader :levelNum, :numGladiators, :numWeapons

    def initialize(numGladiators:, numGuesses:, numRounds:, numWeapons:, roundsLeft: nil, levelNum:)
      @numGladiators = numGladiators
      @numGuesses = numGuesses
      @numRounds = numRounds
      @numWeapons = numWeapons
      @levelNum = levelNum
    end

    # all_possible_responses returns all possible responses for this level.
    def all_possible_responses
      responses = []
      (0..@numGladiators).each do |correctWeapon|
        (0..correctWeapon).each do |correctAttack|
          # Edge case: cannot choose all weapons correctly and have all but one attacking properly.
          next if correctWeapon == @numGladiators and correctAttack + 1 == @numGladiators
          responses << [correctWeapon, correctAttack]
        end
      end
      responses
    end

    # all_possible_guesses returns all possible guesses for this level.
    def all_possible_guesses
      (0...@numWeapons).to_a.permutation(@numGladiators)
    end

    # Given an array of weapons return all permutations of possible answers.
    def possible_answers(weapons)
      weapons.permutation(@numGladiators)
    end

    # Return all weapon combinations.
    def weapon_combinations
      (0...@numWeapons).to_a.combination(@numGladiators)
    end

  end
end
