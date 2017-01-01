require_relative "../client"
require "test/unit"

class TestMastermindClient < Test::Unit::TestCase
  def test_initialize
    c = Mastermind::Client.new('test@example.com')
    c.reset()
    puts c.start_level(1).inspect
    puts c.solve_level(1, [1,2,3,4]).inspect
  end
end
