require_relative "../game"
require "test/unit"

class TestMastermindGame < Test::Unit::TestCase
  def test_evaluate
    data = [
      {
        input: [ [1,2,3], [1,3,2] ],
        output: [3,1],
      },
      {
        input: [ [1,2,3], [1,2,3] ],
        output: [3,3],
      },
      {
        input: [ [1,2,3], [0,0,0] ],
        output: [0,0],
      },
      {
        input: [ [1,2,3], [3,1,2] ],
        output: [3,0],
      },
      {
        input: [ [1,2,1], [1,5,3] ],
        output: [1,1],
      },
    ]
    data.each do |test_case|
      assert_equal(test_case[:output], Mastermind::Game.evaluate(*test_case[:input]), "Input was #{test_case[:input]}")
    end
  end
end
