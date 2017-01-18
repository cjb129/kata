require 'rubygems'
gem 'test-unit'

class Frame
  def initialize(f, s)
    @spare = false
    @strike = false
    @first_roll = f
    @second_roll = s
  end

  def is_spare
    return @first_roll + @second_roll == 10 unless self.is_strike
  end

  def is_strike
    return @first_roll == 10
  end

  def get_first
    return @first_roll
  end

  def get_second
    return @second_roll
  end

end

class Game
  def initialize
    @score = Array.new
  end

  def Score()
    @score.push(Frame.new(0,0))
    @score.push(Frame.new(0,0))

    totalScore = 0
    currentFrame = 0
    for frame in @score
      if currentFrame < 10
        if frame.is_spare
          totalScore += @score[currentFrame+1].get_first
        end
        if frame.is_strike
          if @score[currentFrame+1].is_strike
            totalScore += @score[currentFrame+1].get_first + @score[currentFrame+2].get_first
          else
            totalScore += @score[currentFrame+1].get_first + @score[currentFrame+1].get_second
          end
        end
        totalScore += frame.get_first + frame.get_second
        currentFrame += 1
      end
    end
    p currentFrame
    return totalScore
  end

  def Roll(frame)
    @score.push(frame)
    # p frame
  end

end

require 'test/unit'

class GameTest < Test::Unit::TestCase

  def setup()
    @g = Game.new
  end

  def roll_many(frames, score)
      for r in 1..frames
        @g.Roll(Frame.new(score,score))
      end
  end

  def roll_list(rolls)
    i = 0
    while rolls[i]
      if(rolls[i]%2==0 and rolls[i]==10)
        rolls.insert(i+1,0)
      end
      if(rolls[i+1]==nil)
        f = Frame.new(rolls[i], 0)
      else
        f = Frame.new(rolls[i], rolls[i+1])
      end
      @g.Roll(f)
      i+=2
    end
  end

  def test_no_rolls_returns_zero
    assert_equal 0, @g.Score
  end

  def test_roll_1_returns_1
    f = Frame.new(1,0)
    @g.Roll(f)
    assert_equal 1, @g.Score
  end

  def test_roll_10_frames_of_1s_returns_20
    roll_many(10, 1)
    assert_equal 20, @g.Score
  end

  def test_one_simple_spare
    roll_list([1,9,1,2])
    assert_equal 14, @g.Score
  end

  def test_roll_10_frames_5s_returns_150
    roll_list([5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5])
    assert_equal 150, @g.Score
  end

  def test_roll_10_frames_10s_returns_300
    roll_list([10,10,10,10,10,10,10,10,10,10,10,10])
    assert_equal 300, @g.Score
  end

  def test_seemingly_random_rolls_returns_133
    roll_list([1,4,4,5,6,4,5,5,10,0,1,7,3,6,4,10,2,8,6])
    assert_equal 133, @g.Score
  end
end
