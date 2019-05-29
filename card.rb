class Card
  attr_reader :face_value, :faceup

  def initialize(face_value)
    @face_value = face_value
    @faceup = false
  end

  def display
    if @faceup
      return @face_value
    end

    "."
  end

  def hide
    @faceup = false
  end
  
  def reveal
    @faceup = true
  end
end