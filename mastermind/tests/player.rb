require_relative "../player.rb"
require "test/unit"

class TestMastermindPlayer < Test::Unit::TestCase

  def test_initialize_new_level
    player = Mastermind::Player.new(client: nil)
    level = player.initialize_new_level(1, {
      "numGladiators" => 4,
      "numGuesses"    => 8,
      "numRounds"     => 1,
      "numWeapons"    => 6,
    })
    assert_equal level.levelNum, 1
    assert_equal level.numGladiators, 4
    assert_equal level.numWeapons, 6
  end

end
