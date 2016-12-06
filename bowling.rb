require 'rubygems'
gem 'test-unit'

class Game
  def initialize
    @score = Array.new
  end

  def Score()
    totalScore = 0
    for pins in @score
      totalScore+=pins
    end
    return totalScore
  end

  def Roll(pins)
    @score.push(pins)
  end

end

require 'test/unit'

class GameTest < Test::Unit::TestCase
  def testNoRollsReturnsZero()
    g = Game.new
    assert_equal 0, g.Score
  end

  def testRollOneReturnsOne
    g = Game.new
    g.Roll(1)
    assert_equal 1, g.Score
  end
end
