$LOAD_PATH.unshift File.dirname(__FILE__) + "/../lib"
require "minitest/autorun"

require "bowlingkata.rb"

class BowlingKataTest < Minitest::Test 
  
  def test_GameIsProperlyInitialised
    game = Game.new
    assert_equal(game.frames, [])
  end
  
  def test_BlankFrameHasAppropriateData
    frame = Frame.new(0,0)
    assert(frame.firstball == 0)
  end
  
  def test_AddingFrameToGame
    game = Game.new
    assert_equal([], game.frames)
    game.addframe(Frame.new(2,6))
    assert_equal(game.frames[0].firstball, 2)
  end
  
  def test_AddingTenFramesToGame
    game = Game.new
    10.times{ game.addframe(Frame.new(3,6))}
    assert(game.frames.length == 10)
  end
  
  def test_AddingMoreThanTenFramesToGameIsNotPossible
    game = Game.new
    11.times{ game.addframe(Frame.new(3,7))}
    assert(game.frames.length == 10)
  end
  
  def test_ScoreCorrectAfterOneFrameNoStrikeOrSpare
    game = Game.new
    game.addframe(Frame.new(2,6))
    assert_equal({scorebyframe: [8], total: 8}, game.score)
  end
  
  def test_ScoreCorrectAfterOneFrameSpare
    game = Game.new
    game.addframe(Frame.new(2,8))
    assert_equal({scorebyframe: [10], total: 10}, game.score)
  end
  
  def test_ScoreCorrectAfterTwoFramesSpareThenIncomplete
    game = Game.new
    game.addframe(Frame.new(6,4))
    game.addframe(Frame.new(9,0))
    assert_equal({scorebyframe: [19,9], total: 28}, game.score)
  end
  
  def test_ScoreCorrectAfterThreeFramesTwoSparesThenIncomplete
    game = Game.new
    game.addframe(Frame.new(6,4))
    game.addframe(Frame.new(9,1))
    game.addframe(Frame.new(9,0))
    assert_equal({scorebyframe: [19,19,9], total: 47}, game.score)
  end
  
  def test_ScoreCorrectAfterOneFrameStrike
    game = Game.new
    game.addframe(Frame.new(10,0))
    assert_equal({scorebyframe: [10], total: 10}, game.score)
  end
  
  def test_ScoreCorrectAfterTwoFramesStrikeThenIncomplete
    game = Game.new
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(2,5))
    assert_equal({scorebyframe: [17,7], total: 24}, game.score)
  end
  
  def test_ScoreCorrectAfterTwoFramesStrikeThenSpare
    game = Game.new
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(5,5))
    assert_equal({scorebyframe: [20,10], total: 30}, game.score)
  end
  
  def test_ScoreCorrectAfterTwoFramesStrikeStrike
    game = Game.new
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(10,0))
    assert_equal({scorebyframe: [20,10], total: 30}, game.score)
  end
  
  def test_ScoreCorrectAfterThreeFramesStrikeStrikeIncomplete
    game = Game.new
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(2,6))
    assert_equal({scorebyframe: [22,18,8], total: 48}, game.score)
  end
  
  def test_ScoreCorrectAfterThreeFramesStrikeStrikeSpare
    game = Game.new
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(6,4))
    assert_equal({scorebyframe: [26,20,10], total: 56}, game.score)
  end
  
  def test_ScoreCorrectFullGameNoSparesOrStrikes
    game = Game.new
    10.times{ game.addframe(Frame.new(2,6))}
    assert_equal({scorebyframe: [8,8,8,8,8,8,8,8,8,8], total: 80}, game.score)
  end
  
  def test_ScoreCorrectFullGameOneSpareNotLastFrame
    game = Game.new
    4.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(5,5))
    5.times{ game.addframe(Frame.new(2,6)) }
    assert_equal({scorebyframe: [8,8,8,8,12,8,8,8,8,8], total: 84}, game.score)
  end
  
  def test_ScoreCorrectFullGameOneSpareLastFrame
    game = Game.new
    9.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(5,5,8))
    assert_equal({scorebyframe: [8,8,8,8,8,8,8,8,8,18], total: 90}, game.score)
  end
  
  def test_ScoreCorrectFullGameOneStrikeNotLastFrame
    game = Game.new
    4.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(10,0))
    5.times{ game.addframe(Frame.new(2,6)) }
    assert_equal({scorebyframe: [8,8,8,8,18,8,8,8,8,8], total: 90}, game.score)
  end
  
  def test_ScoreCorrectFullGameOneStrikeLastFrame
    game = Game.new
    9.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(10,2,4))
    assert_equal({scorebyframe: [8,8,8,8,8,8,8,8,8,16], total: 88}, game.score)
  end
  
  def test_ScoreCorrectFullGameTwoStrikesLastFrame
    game = Game.new
    9.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(10,10,4))
    assert_equal({scorebyframe: [8,8,8,8,8,8,8,8,8,24], total: 96}, game.score)
  end
  
  def test_ScoreCorrectFullGameThreeStrikesLastFrame
    game = Game.new
    9.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(10,10,10))
    assert_equal({scorebyframe: [8,8,8,8,8,8,8,8,8,30], total: 102}, game.score)
  end
  
  def test_ScoreCorrectFullGamePerfectScore
    game = Game.new
    9.times{ game.addframe(Frame.new(10,0)) }
    game.addframe(Frame.new(10,10,10))
    assert_equal({scorebyframe: [30,30,30,30,30,30,30,30,30,30], total: 300}, game.score)
  end
      
end
