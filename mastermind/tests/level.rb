require_relative "../level.rb"
require "test/unit"

class TestMastermindLevel < Test::Unit::TestCase
  def test_all_possible_responses_with_2_gladiators
    l = Mastermind::Level.new(numGladiators: 2, numGuesses: 8, numRounds: 1, numWeapons: 6, levelNum: 1)
    assert_equal l.all_possible_responses, [[0, 0], [1, 0], [1, 1], [2, 0], [2, 2]]
  end

  def test_all_possible_responses_with_3_gladiators
    l = Mastermind::Level.new(numGladiators: 3, numGuesses: 8, numRounds: 1, numWeapons: 6, levelNum: 1)
    assert_equal l.all_possible_responses, [[0, 0], [1, 0], [1, 1], [2, 0], [2, 1], [2, 2], [3, 0], [3, 1], [3, 3]]
  end

  def test_all_possible_responses_with_4_gladiators
    l = Mastermind::Level.new(numGladiators: 4, numGuesses: 8, numRounds: 1, numWeapons: 6, levelNum: 1)
    assert_equal l.all_possible_responses, [[0, 0], [1, 0], [1, 1], [2, 0], [2, 1], [2, 2], [3, 0], [3, 1], [3, 2], [3, 3], [4, 0], [4, 1], [4, 2], [4, 4]]
  end

  def test_all_possible_guesses
    l = Mastermind::Level.new(numGladiators: 2, numGuesses: 8, numRounds: 1, numWeapons: 3, levelNum: 1)
    assert_equal l.all_possible_guesses.to_a, [[0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1]]
  end

  def test_possible_answers
    l = Mastermind::Level.new(numGladiators: 2, numGuesses: 8, numRounds: 1, numWeapons: 6, levelNum: 1)
    assert_equal l.possible_answers([0,1,2]).to_a, [[0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1]]
  end

  def test_weapon_combinations
    l = Mastermind::Level.new(numGladiators: 2, numGuesses: 8, numRounds: 1, numWeapons: 6, levelNum: 1)
    assert_equal l.weapon_combinations.to_a, [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [1, 2], [1, 3], [1, 4], [1, 5], [2, 3], [2, 4], [2, 5], [3, 4], [3, 5], [4, 5]]
  end
end
