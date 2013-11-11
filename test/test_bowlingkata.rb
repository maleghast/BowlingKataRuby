$LOAD_PATH.unshift File.dirname(__FILE__) + "/../lib"
require "test/unit"

require "bowlingkata.rb"

class BowlingKataTest < Test::Unit::TestCase
  
  def testGameIsProperlyInitialised
    game = Game.new
    assert_equal(game.frames, [])
  end
  
  def testBlankFrameHasAppropriateData
    frame = Frame.new(0,0)
    assert(frame.firstball == 0)
  end
  
  def testAddingFrameToGame
    game = Game.new
    assert_equal([], game.frames)
    game.addframe(Frame.new(2,6))
    assert_equal(game.frames[0].firstball, 2)
  end
  
  def testAddingTenFramesToGame
    game = Game.new
    10.times{ game.addframe(Frame.new(3,6))}
    assert(game.frames.length == 10)
  end
  
  def testAddingMoreThanTenFramesToGameIsNotPossible
    game = Game.new
    11.times{ game.addframe(Frame.new(3,7))}
    assert(game.frames.length == 10)
  end
  
  def testScoreCorrectAfterOneFrameNoStrikeOrSpare
    game = Game.new
    game.addframe(Frame.new(2,6))
    assert_equal({scorebyframe: [8], total: 8}, game.score)
  end
  
  def testScoreCorrectAfterOneFrameSpare
    game = Game.new
    game.addframe(Frame.new(2,8))
    assert_equal({scorebyframe: [10], total: 10}, game.score)
  end
  
  def testScoreCorrectAfterTwoFramesSpareThenIncomplete
    game = Game.new
    game.addframe(Frame.new(6,4))
    game.addframe(Frame.new(9,0))
    assert_equal({scorebyframe: [19,9], total: 28}, game.score)
  end
  
  def testScoreCorrectAfterThreeFramesTwoSparesThenIncomplete
    game = Game.new
    game.addframe(Frame.new(6,4))
    game.addframe(Frame.new(9,1))
    game.addframe(Frame.new(9,0))
    assert_equal({scorebyframe: [19,19,9], total: 47}, game.score)
  end
  
  def testScoreCorrectAfterOneFrameStrike
    game = Game.new
    game.addframe(Frame.new(10,0))
    assert_equal({scorebyframe: [10], total: 10}, game.score)
  end
  
  def testScoreCorrectAfterTwoFramesStrikeThenIncomplete
    game = Game.new
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(2,5))
    assert_equal({scorebyframe: [17,7], total: 24}, game.score)
  end
  
  def testScoreCorrectAfterTwoFramesStrikeThenSpare
    game = Game.new
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(5,5))
    assert_equal({scorebyframe: [20,10], total: 30}, game.score)
  end
  
  def testScoreCorrectAfterTwoFramesStrikeStrike
    game = Game.new
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(10,0))
    assert_equal({scorebyframe: [20,10], total: 30}, game.score)
  end
  
  def testScoreCorrectAfterThreeFramesStrikeStrikeIncomplete
    game = Game.new
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(2,6))
    assert_equal({scorebyframe: [22,18,8], total: 48}, game.score)
  end
  
  def testScoreCorrectAfterThreeFramesStrikeStrikeSpare
    game = Game.new
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(10,0))
    game.addframe(Frame.new(6,4))
    assert_equal({scorebyframe: [26,20,10], total: 56}, game.score)
  end
  
  def testScoreCorrectFullGameNoSparesOrStrikes
    game = Game.new
    10.times{ game.addframe(Frame.new(2,6))}
    assert_equal({scorebyframe: [8,8,8,8,8,8,8,8,8,8], total: 80}, game.score)
  end
  
  def testScoreCorrectFullGameOneSpareNotLastFrame
    game = Game.new
    4.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(5,5))
    5.times{ game.addframe(Frame.new(2,6)) }
    assert_equal({scorebyframe: [8,8,8,8,12,8,8,8,8,8], total: 84}, game.score)
  end
  
  def testScoreCorrectFullGameOneSpareLastFrame
    game = Game.new
    9.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(5,5,8))
    assert_equal({scorebyframe: [8,8,8,8,8,8,8,8,8,18], total: 90}, game.score)
  end
  
  def testScoreCorrectFullGameOneStrikeNotLastFrame
    game = Game.new
    4.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(10,0))
    5.times{ game.addframe(Frame.new(2,6)) }
    assert_equal({scorebyframe: [8,8,8,8,18,8,8,8,8,8], total: 90}, game.score)
  end
  
  def testScoreCorrectFullGameOneStrikeLastFrame
    game = Game.new
    9.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(10,2,4))
    assert_equal({scorebyframe: [8,8,8,8,8,8,8,8,8,16], total: 88}, game.score)
  end
  
  def testScoreCorrectFullGameTwoStrikesLastFrame
    game = Game.new
    9.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(10,10,4))
    assert_equal({scorebyframe: [8,8,8,8,8,8,8,8,8,24], total: 96}, game.score)
  end
  
  def testScoreCorrectFullGameThreeStrikesLastFrame
    game = Game.new
    9.times{ game.addframe(Frame.new(2,6)) }
    game.addframe(Frame.new(10,10,10))
    assert_equal({scorebyframe: [8,8,8,8,8,8,8,8,8,30], total: 102}, game.score)
  end
  
  def testScoreCorrectFullGamePerfectScore
    game = Game.new
    9.times{ game.addframe(Frame.new(10,0)) }
    game.addframe(Frame.new(10,10,10))
    assert_equal({scorebyframe: [30,30,30,30,30,30,30,30,30,30], total: 300}, game.score)
  end
      
end