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