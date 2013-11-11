class Game
  
  attr_reader :frames
  
  def initialize
    @frames = Array.new
  end
  
  def addframe(frame)
    unless @frames.length > 9
      @frames << frame
    end
  end

  def score
    scoresheet = Hash.new
    scorebyframe = Array.new
    @frames.each_with_index do |frame, index|
      if frame.strike || frame.spare
        if frame.strike
          if index == @frames.length - 1
            scorebyframe << frame.firstball + frame.secondball + frame.thirdball
          else
            if @frames[index + 1].strike
              framescore = frame.firstball + frame.secondball + frame.thirdball + @frames[index + 1].firstball
              if @frames[index + 2].nil?
                framescore = framescore + @frames[index + 1].secondball
              else
                framescore = framescore + @frames[index + 2].firstball
              end
            else
              framescore = frame.firstball + frame.secondball + frame.thirdball + @frames[index + 1].firstball + @frames[index + 1].secondball
            end
            scorebyframe << framescore
          end
        else
          if index == @frames.length - 1
            scorebyframe << frame.firstball + frame.secondball + frame.thirdball
          else
            scorebyframe << frame.firstball + frame.secondball + frame.thirdball + @frames[index + 1].firstball
          end
        end
      else
        scorebyframe << frame.firstball + frame.secondball + frame.thirdball
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