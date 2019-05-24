require_relative "card"

class Board
  attr_reader :size, :grid
  @@card_values = ("a".."z").to_a + ("A".."Z").to_a

  def initialize(size)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
    @selection = @@card_values.sample(@size * @size / 2)
    @pairs = (@selection + @selection).map { |card| Card.new(card) }
  end

  def shuffle
    @pairs = @pairs.sample(@pairs.length)

    return
  end

  def populate
    i = 0

    (0...@size).each do |x|
      (0...@size).each do |y|
        @grid[x][y] = @pairs[i]
        
        i += 1
      end
    end

    return
  end
  
  def render
    puts "  " + (0...@size).to_a.join(" ")
    @grid.each_with_index do |line, i|
      print i.to_s + " "
      line.each { |card| print card.display + " " }
      puts
    end

    return
  end
  
  def won?
    cards.all? { |card| card.faceup }
  end
  
  def reveal
    #should reveal a Card at guessed_pos (unless it's already face-up, in
    #which case the method should do nothing). It should also return the 
    #value of the card it revealed (you'll see why later).
  end

  def [](pos)
    x, y = pos

    @grid[y][x]
  end
end