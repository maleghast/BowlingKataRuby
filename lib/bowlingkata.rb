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
  
  def scoresheet
    @scoresheet
  end
  
end

class Frame
  
  attr_reader :firstball, :secondball, :thirdball, :score
  
  def initialize(firstball, secondball, thirdball = nil)
    @firstball = firstball
    @secondball = secondball
    @thirdball = (thirdball.nil?) ? 0 : thirdball
    @strike = (firstball == 10) ? true : false
    @spare = (firstball != 10 && (firstball + secondball == 10)) ? true : false
    @score = 0
  end
  
end