class Game
  
  attr_reader :frames
  
  MAX_NUM_FRAMES = 10
  
  def initialize
    @frames = Array.new
  end
  
  def addframe(frame)
    unless @frames.length >= MAX_NUM_FRAMES
      @frames << frame
    end
  end
  
  def calculatebonus(frame, index, basicframescore)
    if index + 1 == @frames.length
      basicframescore
    else
      if frame.strike
        if @frames[index + 1].strike
          if index + 2 >= @frames.length
            basicframescore + @frames[index + 1].firstball + @frames[index + 1].secondball
          else
            basicframescore + @frames[index + 1].firstball + @frames[index + 2].firstball
          end
        else
          basicframescore + @frames[index + 1].firstball + @frames[index + 1].secondball
        end
      else
        basicframescore + @frames[index + 1].firstball
      end
    end
  end
  
  def score
    scoresheet = Hash.new
    scorebyframe = Array.new
    @frames.each_with_index do |frame, index|
      basicframescore = frame.firstball + frame.secondball + frame.thirdball
      if frame.strike || frame.spare
        scorebyframe << calculatebonus(frame, index, basicframescore)
      else
      scorebyframe << basicframescore
      end
    end
    scoresheet[:scorebyframe] = scorebyframe
    scoresheet[:total] = scorebyframe.reduce(:+)
    scoresheet
  end
  
end

class Frame
  
  attr_reader :firstball, :secondball, :thirdball, :strike, :spare
  
  def initialize(firstball, secondball, thirdball = nil)
    @firstball = firstball
    @secondball = secondball
    @thirdball = (thirdball.nil?) ? 0 : thirdball
    @strike = (firstball == 10) ? true : false
    @spare = (firstball != 10 && (firstball + secondball == 10)) ? true : false
  end
  
end