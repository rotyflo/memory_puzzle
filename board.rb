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
  end

  def populate
    i = 0

    (0...@size).each do |x|
      (0...@size).each do |y|
        @grid[x][y] = @pairs[i]
        
        i += 1
      end
    end
  end
  
  def render
    system("clear")
    puts "  " + (0...@size).to_a.join(" ")
    @grid.each_with_index do |line, i|
      print i.to_s + " "
      line.each { |card| print card.display + " " }
      puts
    end
  end
  
  def won?
    cards.all? { |card| card.faceup }
  end

  def [](pos)
    x, y = pos

    if x.is_a?(Integer) && y.is_a?(Integer)
      if x.between?(0, @size - 1) && y.between?(0, @size - 1)
        return @grid[y][x]
      end
    end

    nil
  end
end