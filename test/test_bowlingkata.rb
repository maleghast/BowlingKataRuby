$LOAD_PATH.unshift File.dirname(__FILE__) + "/../lib"
require "test/unit"

require "bowlingkata.rb"

class BowlingKataTest < Test::Unit::TestCase
  
  def testGameIsProperlyInitialised
    game = Game.new
    assert_equal([], game.frames)
  end
  
  def testBlankFrameHasAppropriateData
    frame = Frame.new(0,0,0)
    assert(frame.firstball == 0)
    assert(frame.score == 0)
  end
  
  def testAddingFrameToGame
    game = Game.new
    assert_equal([], game.frames)
    game.addframe(Frame.new(2,6,nil))
    assert_equal(2, game.frames[0].firstball)
  end
  
  def testAddingTenFramesToGame
    game = Game.new
    10.times{ game.addframe(Frame.new(3,7,nil))}
    assert(game.frames.length == 10)
  end
  
  def testAddingMoreThanTenFramesToGameIsNotPossible
    game = Game.new
    11.times{ game.addframe(Frame.new(3,7,nil))}
    assert(game.frames.length == 10)
  end
  
  def testScoreCorrectAfterOneFrame
    game = Game.new
    game.addframe(Frame.new(2,6,nil))
    assert_equal(Game.score, [8])
  end
    
end