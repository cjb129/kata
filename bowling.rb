require 'rubygems'
gem 'test-unit'

class Frame
  def initialize(f, s)
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
    @all_frames = Array.new
    @all_rolls = Array.new
    @current_frame_number = 0
  end

  def Roll(pin)
    @all_rolls.push(pin)    
  end

  def Score()
    prepare_scores
    total_score = 0
    
    for current_frame_score in @all_frames
      if @current_frame_number < 10
        total_score += spare_bonus(current_frame_score)
        total_score += strike_bonus(current_frame_score)        
        total_score += current_frame_score.get_first + current_frame_score.get_second
        @current_frame_number += 1
      end
    end
    
    return total_score
  end
  
  #parse list of scores into frames
  def prepare_scores
    i = 0
    while @all_rolls[i]
      if(@all_rolls[i] == 10)
        #add empty second roll for strikes
        @all_rolls.insert(i+1, 0)
      end

      if(!@all_rolls[i+1])
        #allows for incomplete frames
        f = Frame.new(@all_rolls[i], 0)
      else
        #build frame
        f = Frame.new(@all_rolls[i], @all_rolls[i+1])
      end

      @all_frames.push(f)
      i += 2
    end
    
    #cushion to account for out of bounds errors
    @all_frames.push(Frame.new(0, 0))
    @all_frames.push(Frame.new(0, 0))
  end
  
  def spare_bonus(current_frame_score)
    return current_frame_score.is_spare ? add_spare_bonus : 0
  end
  
  def add_spare_bonus
    return @all_frames[@current_frame_number+1].get_first
  end
  
  def strike_bonus(current_frame_score)
    return current_frame_score.is_strike ? add_strike_bonus : 0
  end

  def add_strike_bonus
    return @all_frames[@current_frame_number+1].is_strike ? add_next_frame_is_strike_bonus : add_next_frame_is_not_strike_bonus
  end
  
  def add_next_frame_is_strike_bonus
    return @all_frames[@current_frame_number+1].get_first + @all_frames[@current_frame_number+2].get_first    
  end
  
  def add_next_frame_is_not_strike_bonus
    return @all_frames[@current_frame_number+1].get_first + @all_frames[@current_frame_number+1].get_second    
  end

end

require 'test/unit'

class GameTest < Test::Unit::TestCase

  def setup()
    @g = Game.new
  end

  def roll_many(frames, score)
      for r in 1..frames
        @g.Roll(score)
        @g.Roll(score)
      end
  end

  def roll_list(rolls)
    for f in rolls
      @g.Roll(f)
    end
  end

  def test_no_rolls_returns_zero
    assert_equal 0, @g.Score
  end

  def test_roll_1_returns_1
    @g.Roll(1)
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
  
  def test_dads_best_score
    roll_list([10,10,10,10,10,10,10,10,10,8,2,10])
    assert_equal 278, @g.Score
  end
  
end
