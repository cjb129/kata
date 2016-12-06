require 'rubygems'
gem 'test-unit'

class Game
  def initialize
    @arr = Array.new()
  end
  def Score()
    return 0
  end
end

require 'test/unit'

class GameTest < Test::Unit::TestCase
  def testNoRollsReturnsZero()
    g = Game.new
    assert_equal 0, g.Score
  end
end
